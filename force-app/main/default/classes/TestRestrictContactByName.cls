@isTest	public class TestRestrictContactByName {	
    @isTest static void testContactTrigger() {
        Test.StartTest();	        
        Contact c = new Contact(LastName = 'INVALIDNAME');	        
        Database.SaveResult result = Database.insert(c, false);	        
        System.assert(!result.isSuccess());	        
        System.assert(result.getErrors().size() > 0);	        
        Test.StopTest();	    
    }	  	
}