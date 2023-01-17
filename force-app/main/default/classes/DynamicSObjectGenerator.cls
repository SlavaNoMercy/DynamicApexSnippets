public with sharing class DynamicSObjectGenerator {
    public static SObject createSObject(String typeName) {
        Schema.SObjectType typeDefinition = Schema.getGlobalDescribe().get(typeName);

        if (typeDefinition == null) {
            throw new TypeNotDefinedException(typeName);
        }

        return typeDefinition.newSObject();
    }

    public static List<SObject> dynamicSOQL(String objName, List<String> fieldList) {
        List<SObject> resultList;
        String queryStr = 'SELECT Id';

        if (String.isBlank(objName) || fieldList == null || fieldList.isEmpty()) {
            throw new TypeNotDefinedException('Cannot generate SOQL with defined parameters');    
        }

        for (String field : fieldList) {
            queryStr += ',' + field;
        }

        queryStr += ' FROM ' + objName;

        resultList = Database.query(String.escapeSingleQuotes(queryStr));
        return resultList;
    }

    public static List<List<SObject>> dynamicSOSL(String searchTerm, List<String> objList) {
        List<List<SObject>> searchResult;
        String searchStr = 'FIND ';

        if (String.isBlank(searchTerm) || objList.isEmpty() || objList == null) {
            throw new TypeNotDefinedException('Cannot Generate SOSL with defined parameters');
        }

        searchStr += '\'' + searchTerm + '\'' + ' IN ALL FIELDS RETURNING ';
        
        for (String objName : objList) {
            searchStr += objName + ',';
        }

        searchResult = Search.query(searchStr.removeEnd(','));

        return searchResult;
    }
}