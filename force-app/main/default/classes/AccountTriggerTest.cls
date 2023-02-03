@IsTest
public class AccountTriggerTest {
    private static String accountName = 'Sample';
    
    @TestSetup
    static void setupData(){
        Profile profilerecord = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        //Create user
        user usr = TestDataUtility.createUser(profilerecord.id,'testuser@sqx.com');
        user usr2 = TestDataUtility.createUser(profilerecord.id,'testuser@sqx2.com');
        list<PermissionSet> PermissionSetList = [SELECT Id FROM PermissionSet WHERE Label =:Utility.PERSET_ACCOUNT_ADMIN LIMIT 1];
        if(PermissionSetList.size()>0){
            PermissionSetAssignment ps = new PermissionSetAssignment();
            ps.AssigneeId = usr2.id;
            ps.PermissionSetId = PermissionSetList[0].Id; 
            insert ps;
        }
     }
    
    @IsTest
    static void testAccountwithTeammembers(){
        
        //Create sample account record
        Account sampleAccount = TestDataUtility.createAccount(accountName,false);
        Test.startTest();
        User u1 = [SELECT id from User where userName='testuser@sqx.com' LIMIT 1];
        System.runas(u1) {
            insert sampleAccount;
            list<SQX_Team_Members__c>teamMembers = [Select id from SQX_Team_Members__c Where Account__c=:sampleAccount.id];
            System.AssertEquals(true,teamMembers.size()>0);
        }
        Test.stopTest();
        
    }
    
    @IsTest
    static void testAccountActivateWithoutTeamMembers(){
        
        //Create sample account record
        Account sampleAccount = TestDataUtility.createAccount(accountName,true);
        Test.startTest();
        User u1 = [SELECT id from User where userName='testuser@sqx.com' LIMIT 1];
        System.runas(u1) {
            try {
                sampleAccount.Active__c = true;
                update sampleAccount;
                System.assert(false, 'fail the test if no exception thrown ');
            }
            catch (DmlException e) {
                System.assertEquals(true,e.getMessage().contains('Account not activated. Account does not have team members with HR and Admin'));         
            }
            
            
        }
        Test.stopTest();
        
    }
    
    @IsTest
    static void testAccountActivateWithoutPermissonSet(){
        
        //Create sample account record
        Account sampleAccount = TestDataUtility.createAccount(accountName,true);
        Test.startTest();
        User u1 = [SELECT id from User where userName='testuser@sqx.com' LIMIT 1];
        System.runas(u1) {
            try {
                list<SQX_Team_Members__c>teamMembers = [Select id from SQX_Team_Members__c Where Account__c=:sampleAccount.id];
                if(teamMembers.size()>0){
                    teamMembers[0].Member_Type__c = 'HR';
                    teamMembers[1].Member_Type__c = 'Admin';
                    update teamMembers;
                }
                sampleAccount.Active__c = true;
                update sampleAccount;
                System.assert(false, 'fail the test if no exception thrown ');
            }
            catch (DmlException e) {
                System.assertEquals(true,e.getMessage().contains('You don not have permission to activate the account'));         
            }
        }
        Test.stopTest();
        
    }
    
    @IsTest
    static void testAccountActivateWithPermissonSetAndTeamMembers(){
        
        //Create sample account record
        Account sampleAccount = TestDataUtility.createAccount(accountName,true);
        Test.startTest();
        User u1 = [SELECT id from User where userName='testuser@sqx2.com' LIMIT 1];
        
        System.runas(u1) {
            
                list<SQX_Team_Members__c>teamMembers = [Select id from SQX_Team_Members__c Where Account__c=:sampleAccount.id];
                if(teamMembers.size()>0){
                    teamMembers[0].Member_Type__c = 'HR';
                    teamMembers[1].Member_Type__c = 'Admin';
                    update teamMembers;
                }
                sampleAccount.Active__c = true;
                update sampleAccount;
               
            
        }
        Test.stopTest();
        
    }
}