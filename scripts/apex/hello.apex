String queryStr =
  'SELECT Id, Name, ' +
  '(SELECT LastName, FirstName FROM Contacts LIMIT 3)' +
  ' FROM Account LIMIT 5';

SObject [] accs = Database.query(queryStr);

for (SObject acc : accs) {
    Object accName = acc.get('Name');
    SObject [] contacts = acc.getSObjects('Contacts');
    
    for (SObject con : contacts) {
        Object conLastName = con.get('LastName');
        Object conFirstName = con.get('FirstName');

        System.debug('Parent account: ' + accName);
        System.debug('Contact info: ' + conFirstName + ' ' + conLastName);
    }
}

// dynamic SOQL

String accName = 'ShsH';

SObject acc = Database.query('SELECT Id, Name FROM Account WHERE Name = :accName');

System.debug(acc);

// System.debug(Url.getOrgDomainUrl().toExternalForm());

// Event publish from Apex

Order_Event__e event = new Order_Event__e(
    Has_Shipped__c = false,
    Order_Number__c = '745003-6'
);

Eventbus.publish(event);