@isTest
private with sharing class CustomMdtHandlerTest {
    static PersonalConfiguration__mdt mdtRecord;
    static User testUser;

    static {
        mdtRecord = TestDataFactory.createTestMdt();
        testUser = TestDataFactory.createUser();
    }

    @isTest
    static void getMdtRecord() {
        List<PersonalConfiguration__mdt> cMdt = [
            SELECT DeveloperName, ManagerUsername__c
            FROM PersonalConfiguration__mdt
        ];

        Assert.areEqual('adani@sqwww1.com', cMdt[0].ManagerUsername__c);
        Assert.areEqual('TestingManager', cMdt[0].DeveloperName);
    }

    @isTest
    static void getUserByUsernameTest() {
        User userTest = UserQueryManager.getUserByUsername(mdtRecord.ManagerUsername__c);

        Assert.areEqual(testUser.Id, userTest.Id);
        Assert.areEqual(testUser.LastName, userTest.LastName);

        Assert.areEqual('Test User', userTest.LastName);
    }
}