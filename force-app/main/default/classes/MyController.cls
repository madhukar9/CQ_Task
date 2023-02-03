public class MyController {
    
    public final Account acct;
    public string greeting{get;set;}
    
    // The extension constructor initializes the private member
    // variable acct by using the getRecord method from the standard
    // controller.
    public MyController(ApexPages.StandardController stdController) {
        this.acct = (Account)stdController.getRecord();
        
    }

    public String getGreeting() {
     
        return 'Hello ' + acct.name + ' (' + acct.id + ')';
      
    }
    
    public string showName(){
        
        return 'Madhukar';
    }
}