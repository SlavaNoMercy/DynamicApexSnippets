public with sharing class DynamicSObjectGenerator {
    public static SObject createSObject(String typeName) {
        Schema.SObjectType typeDefinition = Schema.getGlobalDescribe().get(typeName);

        if (typeDefinition == null) {
            throw new TypeNotDefinedException('Chosen SObject Type does not exist.');
        }

        return typeDefinition.newSObject();
    }
}
