public class DisplayAccounts {
    
    public list<account> accountRecords{get;set;}
    
    public DisplayAccounts(){
        accountRecords = new list<account>();
        accountRecords = [Select id,Name,Phone from account Limit 10];
    }
    
    public pagereference downloadExcel(){
        
        return null;
    }
    

}