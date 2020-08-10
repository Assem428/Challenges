trigger IsPrimary on Contact (before insert) { 
    Set<Id> AccountIds= new Set<Id>();
     for(Contact con : Trigger.new){
     AccountIds.add(con.AccountId);
 }
 List<Account> accountsWithContacts = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id =:AccountIds];
 for(Contact con : Trigger.new){
     for(Account act: accountsWithContacts){
         if(act.contacts.size()<1){
            con.is_Primary__c = true;
         }
         else if (act.contacts.size()>1 & con.is_Primary__c == true){
             con.addError('you can only have 1 Primary Contact');
         }
     }
 }
}