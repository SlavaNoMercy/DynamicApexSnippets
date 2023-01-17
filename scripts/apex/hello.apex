String queryStr =
  'SELECT Id, Name, ' +
  '(SELECT LastName, FirstName FROM Contacts LIMIT 3)' +
  ' FROM Account LIMIT 5';

List<SObject> accs = Database.query(queryStr);

for (SObject acc : accs) {
    Object accName = acc.get('Name');
    List<SObject> contacts = acc.getSObjects('Contacts');
    
    for (SObject con : contacts) {
        Object conLastName = con.get('LastName');
        Object conFirstName = con.get('FirstName');

        System.debug('Parent account: ' + accName);
        System.debug('Contact info: ' + conFirstName + ' ' + conLastName);
    }
}

// dynamic SOQL

String accName = 'ShsH';

List<SObject> acc = Database.query('SELECT Id, Name FROM Account WHERE Name = :accName');

System.debug(acc[0]);

// System.debug(Url.getOrgDomainUrl().toExternalForm());

// Event publish from Apex

// NewCustomerEvent__e newCustomerEvent = new NewCustomerEvent__e(
//     AnnualRevenue__c = 10000,
//     CompanyName__c = 'xyz',
//     Confirmed__c = true,
//     CustomerPassword__c = '123456',
//     PrimaryContact__c = 'John',
//     PrimaryContactEmail__c = 'qwerty@some.com',
//     SubscriptionTimeout__c = Date.today(),
//     SubscriptionType__c = 'Gold'
// );

// Eventbus.publish(newCustomerEvent);

String str = 'Salesforce';
System.assert(str.isAlpha());
System.assert(str.isAlphaSpace());
System.assert(str.isAlphanumeric());
System.assert(str.isAlphanumericSpace());

for (String field : VFRemotingManager.getRequiredFields('Account')) {
    System.debug(field);
}

// Query & Search result check
List<String> sObjects = new List<String>();
List<String> fields = new List<String>();
String searchTerm = 'ShsH';
List<List<SObject>> searchResult;

sObjects.add('Account');
sObjects.add('Contact(FirstName,LastName)');

// Correct search
try {
    searchResult = DynamicSObjectGenerator.dynamicSOSL(searchTerm, sObjects);
    System.debug(searchResult);
    sObjects.add('some-');
    System.debug(DynamicSObjectGenerator.dynamicSOSL(searchTerm, sObjects));
} catch (QueryException e) {
    System.debug('exception: ' + e.getMessage());
}

System.debug(searchResult[1][0]);

fields.add('Name');
fields.add('AnnualRevenue');
try {
    System.debug(DynamicSObjectGenerator.dynamicSOQL(sObjects[0], fields));
    fields.add('some-');
    System.debug(DynamicSObjectGenerator.dynamicSOQL(sObjects[0], fields));
} catch (QueryException e) {
    System.debug('exception: ' + e.getMessage());
}
