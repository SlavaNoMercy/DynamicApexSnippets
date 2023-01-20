global with sharing class SObjectListViewCtrl {
    public String selectedType { get; set; }
    public Map<String, Schema.SObjectType> sobjMap;

    public SObjectListViewCtrl() {
        sobjMap = Schema.getGlobalDescribe();
    }

    public List<SelectOption> getSobjectList() {
        List<SelectOption> sobjList = new List<SelectOption>();
        
        for (String key : sobjMap.keySet()) {
            sobjList.add(new SelectOption(key, key));
            
            if (sobjList.size() == 20) {
                break;
            }
        }

        return sobjList;
    }

    @RemoteAction
    public static List<String> getRequiredFields(String sobjName) {
        List<String> requiredFieldNames = new List<String>();
        Schema.DescribeSObjectResult [] sobjToken;
        Map<String, Schema.SObjectField> fieldsMap;

        if (String.isBlank(sobjName)) {
            System.debug('null parameter passed!');
            return null;
        }

        sobjToken = Schema.describeSObjects(new List<String>{sobjName});
        fieldsMap = sobjToken[0].fields.getMap();
        requiredFieldNames.addAll(fieldsMap.keySet());
        
        return requiredFieldNames;
    }
    
    webservice static String getFieldType(String fieldName, String sobjName) {
        String fieldType;
        Schema.DescribeSObjectResult [] sobjToken;
        Schema.SObjectField fieldToken;

        if (String.isBlank(fieldName) || String.isBlank(sobjName)) {
            return null;
        }

        sobjToken = Schema.describeSObjects(new List<String>{sobjname});
        fieldToken = sobjToken[0].fields.getMap().get(fieldName);
        fieldType = String.valueOf(fieldToken.getDescribe().getType());
        
        return fieldType;
    }
}