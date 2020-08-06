public class AccountHasAnOpportunityClass {
    public static void AccountHasAnOpportunityMethod(List <Opportunity> oppt){         
    	Set<Id> AccountIds = new Set <Id>();
        List<Account> AccountsToUpdate= new List<Account>(); 
        for(Opportunity opp: oppt){ 
        AccountIds.add(opp.AccountId); 
            }
    List <Account> AccountsToUpdateCheckbox =   [SELECT Id, 
                                               (SELECT Id FROM Opportunities WHERE AccountId!=Null) 
                                               FROM Account 
                                                WHERE Id in :AccountIds];
    
       for(Account acc: AccountsToUpdateCheckbox){
        Account objectAccount= new Account(Id=acc.Id);
        if(acc.opportunities.size()>0) 
        objectAccount.Account_has_an_Opportunity__c=true;          
        else
        objectAccount.Account_has_an_Opportunity__c=false;
        AccountsToUpdate.add(objectAccount);        
    }
  update AccountsToUpdate;
    }
}
