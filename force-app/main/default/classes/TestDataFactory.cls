@isTest
public class TestDataFactory {
    public static List<Account> createAccountsWithOpps(Integer numAccts, Integer numOppsPerAcct) {
        List<Account> accts = new List<Account>();
        
        for (Integer i = 0; i < numAccts; i++) {
            Account a = new Account(Name = 'TestAccount' + i);
            accts.add(a);
        }

        insert accts;
        
        List<Opportunity> opps = new List<Opportunity>();

        for (Integer j = 0; j < numAccts; j++) {
            Account acct = accts[j];

            for (Integer k = 0; k < numOppsPerAcct; k++) {
                opps.add(
                    new Opportunity(
                        Name = acct.Name + ' Opportunity ' + k,
                        StageName = 'Prospecting',
                        CloseDate = System.today().addMonths(1),
                        Discount_Percent__c = 15,
                        AccountId = acct.Id
                    )
                );
            }
        }

        insert opps;
        return accts;
    }

    public static PersonalConfiguration__mdt createTestMdt() {
        String orgId = UserInfo.getOrganizationId();

        PersonalConfiguration__mdt customMdt = new PersonalConfiguration__mdt(
            DeveloperName = 'TestInstance',
            ManagerUsername__c = 'testuser@test.com' + orgId + '.org'
        );

        return customMdt;
    }

    public static User createUser() {
        String orgId = UserInfo.getOrganizationId();
        Profile pf = [
            SELECT Id
            FROM Profile
            WHERE Name = 'System Administrator'
        ];

        User testUsr = new User(
            firstname = 'Abstract',
            lastName = 'Test User',
            email = 'uniqueName@test' + orgId + '.org',
            Username = 'testuser@test.com' + orgId + '.org',
            EmailEncodingKey = 'ISO-8859-1',
            Alias = 'ABC',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            LanguageLocaleKey = 'en_US',
            ProfileId = pf.Id
        );

        insert testUsr;
        return testUsr;
    }
}