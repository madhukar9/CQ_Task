@IsTest
public class ScheduleProductAndPartsTest {
    private static String accountName = 'Sample';
    
    @TestSetup
    static void setupData(){
        Profile profilerecord = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        //Create user
        user usr = TestDataUtility.createUser(profilerecord.id,'testuser@sqx.com');
        list<PermissionSet> PermissionSetList = [SELECT Id FROM PermissionSet WHERE Label =:Utility.PERSET_CQ_PRODUCT_ADMIN LIMIT 1];
        if(PermissionSetList.size()>0){
            PermissionSetAssignment ps = new PermissionSetAssignment();
            ps.AssigneeId = usr.id;
            ps.PermissionSetId = PermissionSetList[0].Id; 
            insert ps;
        }
        
    }
    
    @IsTest
    static void testSchedulePartsWithProducts(){
        
        User u1 = [SELECT id from User where userName='testuser@sqx.com' LIMIT 1];
        System.runas(u1) {
            Product2 product = TestDataUtility.createProduct('Samsung','12345',true);
            SQX_Part__c part = TestDataUtility.createPart('Samsung','12345',null,true);
            Test.startTest();
            Datetime dt = Datetime.now().addMinutes(1);
            String CRON_EXP = '0 '+ dt.minute() + ' * ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year();
            String jobId = System.schedule('Sample_Heading', CRON_EXP, new ScheduleProductAndParts () );   
            
            
            // Get the information from the CronTrigger API object
            CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
                              NextFireTime
                              FROM CronTrigger WHERE id = :jobId];
            
            // Verify the expressions are the same
            System.assertEquals(CRON_EXP, 
                                ct.CronExpression);
            
            // Verify the job has not run
            System.assertEquals(0, ct.TimesTriggered);
            Test.stopTest();
            
        }
        
        
    }
    
    public static SQX_Part__c getPartRecord(string id){
        return [Select id,Name,Part_Number__c,Product__c,Product__r.ProductCode,Active__c From SQX_Part__c where id=:id];
    }
    
    
}