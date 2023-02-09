@IsTest
public class SyncProductAndPartsBatchTest {
	 private static String accountName = 'Sample';
    
    @TestSetup
    static void setupData(){
        Profile profilerecord = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        //Create user
        user usr = TestDataUtility.createUser(profilerecord.id,'testuser@sqx.com');
        
        list<PermissionSet> PermissionSetList = [SELECT Id FROM PermissionSet WHERE Label =:Utility.PERSET_ACCOUNT_ADMIN LIMIT 1];
        if(PermissionSetList.size()>0){
            PermissionSetAssignment ps = new PermissionSetAssignment();
            ps.AssigneeId = usr.id;
            ps.PermissionSetId = PermissionSetList[0].Id; 
            insert ps;
        }
        
     }
    
    @IsTest
    static void testPartsWithProducts(){
        
        User u1 = [SELECT id from User where userName='testuser@sqx.com' LIMIT 1];
        System.runas(u1) {
            Product2 product = TestDataUtility.createProduct('Samsung','12345',true);
            SQX_Part__c part = TestDataUtility.createPart('Samsung','12345',null,true);
            Test.startTest();
            Database.executeBatch(new SyncProductAndPartsBatch());
            Test.stopTest();
            SQX_Part__c partUpdatedRecord = getPartRecord(part.id);
            system.debug('****partUpdatedRecord*****'+partUpdatedRecord);
			System.assertEquals(product.Id,partUpdatedRecord.Product__c);         
        }
        
        
    }
    
    public static SQX_Part__c getPartRecord(string id){
        return [Select id,Name,Part_Number__c,Product__c,Product__r.ProductCode,Active__c From SQX_Part__c where id=:id];
    }
    
    @IsTest
    static void testPartsWithOutProducts(){
        
        User u1 = [SELECT id from User where userName='testuser@sqx.com' LIMIT 1];
        System.runas(u1) {
            
            SQX_Part__c part = TestDataUtility.createPart('Samsung','12345',null,true);
            Test.startTest();
            Database.executeBatch(new SyncProductAndPartsBatch());
            Test.stopTest();
            SQX_Part__c partUpdatedRecord = getPartRecord(part.id);
            System.assertEquals(true,partUpdatedRecord.Product__c != null);         
        }
        
        
    }
    
    
    
    
}