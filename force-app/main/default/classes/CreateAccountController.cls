public class CreateAccountController {
    public account accountRecord{get;set;}
    
    
    //Constructor
    public CreateAccountController(){
        accountRecord = new account();
    }
    
    public pagereference saveRecord(){
        insert accountRecord;
        PageReference myVFPage = new PageReference('/'+accountRecord.Id);
        myVFPage.setRedirect(true);
        return myVFPage;
        
    }
    
    

}