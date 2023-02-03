public class AccountTriggerHandler {
    
    //Account After insert
    public static void afterInsert(list<account>newRecords){
        Try{
        //When the account record is inserted then create the account team members
        list<SQX_Team_Members__c> teamMemberList = new list<SQX_Team_Members__c>();
        
        for(account accountRecord:newRecords){
            SQX_Team_Members__c member1 = new SQX_Team_Members__c(Name = 'Team Member 1',Account__c = accountRecord.Id,
                                                                  Contact_Info__c = '',Member_Type__c = null);
             SQX_Team_Members__c member2 = new SQX_Team_Members__c(Name = 'Team Member 2',Account__c = accountRecord.Id,
                                                                  Contact_Info__c = '',Member_Type__c = null);
            teamMemberList.add(member1);
            teamMemberList.add(member2);

            
        }
        if(teamMemberList.size()>0){
            insert teamMemberList;
        }
        //Team members end
        
        }Catch(Exception e){
            System.debug('Exception :=>'+e);
        }
        
    }
    
    //Account before update
    public static void beforeUpdate(list<account>newRecords,map<id,Account>oldMap){
        Try{
        set<id> accountIds = new set<id>();
        list<string> memberTypes = new list<string>();
        memberTypes.add(Utility.TEAM_MEMBER_HR);
        memberTypes.add(Utility.TEAM_MEMBER_ADMIN);
        boolean AccountAdminPermissionSet = AccountTriggerHandler.doesRunningUserHavePermission(Utility.PERSET_ACCOUNT_ADMIN);
        
        //set the accounts records to accountIds list
        for(account accountRecord:newRecords){
            accountIds.add(accountRecord.id);
        }
        Map<id,List<SQX_Team_Members__c>> teamMembersMap = getAccountTeamMembers(accountIds,memberTypes);
        
        for(account acc:newRecords){
            if(acc.Active__c == true && acc.Active__c != oldMap.get(acc.Id).Active__c){
                if(!teamMembersMap.containsKey(acc.Id)){
                    acc.addError('Account not activated. Account does not have team members with HR and Admin');
                }
                else if(!AccountAdminPermissionSet){
                    acc.addError('You don not have permission to activate the account');
                }
            }
        }
         }Catch(Exception e){
            System.debug('Exception :=>'+e);
        }
        
    }
    
    //Prepare the team members map for related accounts
    //inputs: member type list amd account id list
    //output: map for accoun and related teammebers 
    public static Map<id,List<SQX_Team_Members__c>> getAccountTeamMembers(set<id> accountIds,list<string>memberTypes){
        map<id,list<SQX_Team_Members__c>> teamMembersMap = new map<id,list<SQX_Team_Members__c>>();
        for(SQX_Team_Members__c member : [Select id,Member_Type__c,Account__c from SQX_Team_Members__c Where Account__c IN:accountIds And Member_Type__c IN:memberTypes]){
            if(teamMembersMap.get(member.Account__c) != null){
                teamMembersMap.get(member.Account__c).add(member);
            }
            else{
                list<SQX_Team_Members__c> memberList = new list<SQX_Team_Members__c>();
                memberList.add(member);
                teamMembersMap.put(member.Account__c,memberList);
            }
        }
        return teamMembersMap;
    }
    
    //Check the runnig user have permissionset is assigned
    //inputs: permissonset name
    //output: boolean 
    public static Boolean doesRunningUserHavePermission(String permissionsetName){
        List<PermissionSetAssignment> psas = [ select Id from PermissionSetAssignment where PermissionSetId IN ( select Id from PermissionSet where Name = :permissionsetName) and AssigneeId= :UserInfo.getUserId()];
        return psas.size() > 0;
    }
    

}