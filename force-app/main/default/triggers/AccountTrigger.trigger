trigger AccountTrigger on Account (after insert,before update) {
	
    if(trigger.isInsert && trigger.isAfter){
        AccountTriggerHandler.afterInsert(trigger.new);
    }
    
     if(trigger.isUpdate && trigger.isBefore){
       AccountTriggerHandler.beforeUpdate(trigger.new,trigger.oldMap);
     }
    
    
}