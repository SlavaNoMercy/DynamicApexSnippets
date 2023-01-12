public with sharing class DynamicSObjectGenerator {
    public static SObject createSObject(String typeName) {
        Schema.SObjectType typeDefinition = Schema.getGlobalDescribe().get(typeName);

        if (typeDefinition == null) {
            throw new TypeNotDefinedException(typeName);
        }

        return typeDefinition.newSObject();
    }
}
