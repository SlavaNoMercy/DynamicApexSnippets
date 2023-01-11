@isTest
public with sharing class DynamicSObjectGeneratorTest {
    @IsTest
    static void validTypeCreation() {
        String testType = 'Account';
        SObject testObj;

        try {
            testObj = DynamicSObjectGenerator.createSObject(testType);
        } catch (Exception e) {
        }

        Assert.areEqual(testType, String.valueOf(testObj.getSObjectType()));
        Assert.areNotEqual(null, testObj);
    }

    @IsTest
    static void invalidTypeCreation() {
        String testType = 'SomeInvalidType_____c';
        SObject testObj;

        try {
            testObj = DynamicSObjectGenerator.createSObject(testType);
        } catch (Exception e) {
            Assert.areEqual('Chosen SObject Type does not exist.', e.getMessage());
        }

        Assert.areEqual(null, testObj);
    }
}