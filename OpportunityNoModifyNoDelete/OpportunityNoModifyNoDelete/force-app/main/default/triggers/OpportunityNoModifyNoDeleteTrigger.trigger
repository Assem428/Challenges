//Prevent non-admin users from modifying the Opportunity Name once Probability is greater than 50%
//Prevent non-admin users Opportunity from being deleted if Probability is greater than or equal to 75%
trigger OpportunityNoModifyNoDeleteTrigger on Opportunity (before update, before delete) {
    Id profileId=userinfo.getProfileId();
        String profileName=[Select Id,Name from Profile where Id=:profileId].Name;
        if(Trigger.IsBefore)
    {
            if(Trigger.IsUpdate){
            for(Opportunity opp: Trigger.new){
            Opportunity OldOpp = Trigger.oldMap.get(opp.Id);
            if(opp.Name!=oldOpp.Name && (profileName == 'System Administrator' && opp.Probability >=0.50)) {
            opp.Name.addError('Non-admin user cannot modify Opportunity Name if Probability is greater than or equals to 50%.');
            }
        }
    }
            if (Trigger.isDelete){
            for(Opportunity opp: Trigger.old){
            if(profileName == 'System Administrator' && opp.Probability >=0.75){
            opp.addError('Non-admin user cannot delete Opportunity if Probability is greater than or equals to 75%.');
                }
            }
        }
    }
    }    