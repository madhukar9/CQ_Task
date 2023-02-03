public class InsertAccount {
    
    public account insertAccount{get;set;}
    
    public InsertAccount(){
        insertAccount = new account();
    }

    public boolean isError{get;set;}
    public void validateFrom(){
        isError = false;
        if(insertAccount.Name ==null || insertAccount.Name == ''){
            isError = true;
        }
        
    }
    
    public pageReference SaveAccount(){
        validateFrom();
        if(isError == false){
            insert insertAccount;
        }
        else{
            
        }
        
        return null;
    }
}