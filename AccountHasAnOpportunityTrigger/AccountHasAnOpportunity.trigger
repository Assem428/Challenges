trigger AccountHasAnOpportunity on Opportunity (after insert, after update, after delete) {
    
    if(Trigger.isInsert || Trigger.isUpdate) {
        AccountHasAnOpportunityClass.AccountHasAnOpportunityMethod(Trigger.new);        
        }

    if(Trigger.isDelete){
        AccountHasAnOpportunityClass.AccountHasAnOpportunityMethod(Trigger.old);
   
        }
}