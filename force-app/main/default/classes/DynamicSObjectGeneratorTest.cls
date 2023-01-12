@isTest
public with sharing class DynamicSObjectGeneratorTest {
    @IsTest
    static void validTypeCreation() {
        String testType = 'Account';
        SObject testObj;

        try {
            testObj = DynamicSObjectGenerator.createSObject(testType);
        } catch (Exception e) {
        } finally {
            Assert.areEqual(testType, String.valueOf(testObj.getSObjectType()));
            Assert.areEqual(new Account(), testObj);
        }    
    }

    @IsTest
    static void invalidTypeCreation() {
        String testType = 'SomeInvalidType_____c';
        SObject testObj;

        try {
            testObj = DynamicSObjectGenerator.createSObject(testType);
        } catch (Exception e) {
            Assert.areEqual('Following type is not defined: ' + testType, e.getMessage());
        } finally {
            Assert.areEqual(null, testObj);
        }
    }

    @IsTest
    static void nullParameterTest(){
        SObject testObj;

        try {
            testObj = DynamicSObjectGenerator.createSObject(null);
        } catch (Exception e) {
            Assert.areEqual('Following type is not defined: null', e.getMessage());
        } finally {
            Assert.areEqual(null, testObj);
        }        
    }
}