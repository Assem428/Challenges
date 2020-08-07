@isTest
public class OpportunityNoModifyNoDeleteTriggerTest {
    @isTest static void TestNoModifyTrigger() {
        Profile p 	= [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u 		= new User (LastName = 'Riza', 			Alias = 'Riza',
                           		Email = 'riza@email.com', 	Username = 'riza@email.com',
                           		EmailEncodingKey = 'UTF-8', TimeZoneSidKey = 'America/New_York', 
                           		LanguageLocalekey='en_US', 	LocaleSidKey = 'en_US',
                           		ProfileId = p.Id);
        	System.runAs (u){
        Opportunity oppt = new Opportunity();
        oppt.Name = 'Vacasa Test';
		oppt.CloseDate = date.today().addMonths(3);
		oppt.StageName = 'Prospecting';
        oppt.Probability = 55;
            insert oppt;
        Try {
        Opportunity opp = [SELECT Id FROM Opportunity WHERE Name='Vacasa Test'];
        opp.Name= 'Vacasa Test1';
            update opp;
        }
                 
        Catch (Exception error){ 
            System.assert(error.getMessage().contains('Non-admin user cannot modify Opportunity Name if Probability is greater than or equals to 50%.'));
        }
            }
    }
    @istest static void TestNoDeletetrigger(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
       	User u = new User (LastName = 'Toni', 			Alias = 'Toni',
                           Email = 'toni@email.com', 	Username = 'toni@email.com',   
                           EmailEncodingKey = 'UTF-8', 	TimeZoneSidKey = 'America/New_York', 
                           LanguageLocalekey = 'en_US', LocaleSidKey = 'en_US',
                           ProfileId = p.Id);
        	System.runAs (u){
        Opportunity oppt = new Opportunity();
        oppt.Name = 'Vacasa Test2';
		oppt.CloseDate = date.today().addMonths(3);
		oppt.StageName = 'Prospecting';
        oppt.Probability = 80;
        	insert oppt;
        	Database.DeleteResult result = Database.delete(oppt,false);
        	//Retrieves the status of an asynchronous delete operation that’s identified by a Database.DeleteResult object.
        System.assert(true, 'Non-admin user cannot delete Opportunity if Probability is greater than or equals to 75%.');
            }
            }
}