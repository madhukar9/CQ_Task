public class myclass1 {
    
    public myclass1(){
       //string name = Apexpages.currentPage().getParameters().get('name');
       // string id = Apexpages.currentPage().getParameters().get('id');
        //system.debug(id+'***name****'+name);
       //newTestMethod();
        
    }
    
    public void reloadmethod(){
        
        System.debug('***reload'); 
    }
    
    public void newTestMethod(){
        
         myclass2 obj  = new myclass2();
        obj.myvoidmethod();
        
       string name = myclass2.getFirstName('Madhukar');
        System.debug('***from class 1'+name); 

    }
    
    public pageReference gotovfpage(){
        string url = '/apex/myVFPage2?name=madhukar';
        pageReference ref = new pageReference(url);
        
        return ref;
    }

}