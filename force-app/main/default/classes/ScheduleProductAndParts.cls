global class ScheduleProductAndParts implements Schedulable{
    
	public void execute(System.SchedulableContext context){
        String ProfileName = [Select Profile.Name from User Where Id=:UserInfo.getUserId() Limit 1].Profile.Name;
        if(ProfileName == 'System Administrator' && doesRunningUserHavePermission(Utility.PERSET_CQ_PRODUCT_ADMIN)){
            Database.executeBatch(new SyncProductAndPartsBatch(), 100);
        }
    }
    
    //Check the runnig user have permissionset is assigned
    //inputs: permissonset name
    //output: boolean 
    public static Boolean doesRunningUserHavePermission(String permissionsetName){
        List<PermissionSetAssignment> psas = [ select Id from PermissionSetAssignment where PermissionSetId IN ( select Id from PermissionSet where Name = :permissionsetName) and AssigneeId= :UserInfo.getUserId()];
        return psas.size() > 0;
    }
}