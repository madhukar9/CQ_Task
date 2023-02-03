public class myclass2 {
    
    public string name{get;set;}
    public static string firstname{get;set;
                                  }
    public myclass2(){
       // string name = Apexpages.currentPage().getParameters().get('name');	
        //myvoidmethod();
        system.debug(getAllsetname());
    }
    
    
    public Pagereference redirctToUrl(){
        myvoidmethod();
        account acc = [Select id from account limit 1];
        //Pagereference ref = new Pagereference('/apex/myVFPage');
        Pagereference ref = new Pagereference('/'+acc.Id);
        return ref;
    }
    
    
    public static string getFirstName(string myname){
        firstname = 'Aketi '+myname;
        return firstname;
    }
    
    // Date,boolean,string,list<string>,list<id>,list<sobject>,list<innerclass>,map
    public static boolean isValid(){
        
        return true;
    }
    
    
    
    public void myvoidmethod(){
        
        name = 'Madhukar';
        system.debug('*****'+name);
    }
    
    public static list<string> getAllname(){
        list<string> name =new list<string>();
        name.add('Apple');
        name.add('Banana');
        name.add('Banana');
        return name;
    }
    public static set<string> getAllsetname(){
        set<string> name =new set<string>();
        name.add('Apple');
        name.add('Banana');
        name.add('Banana');
        return name;
    }
    
    public static map<string,string> getNamesMAp(){
        map<string,string> name =new map<string,string>();
        name.put('1','B');
        return name;
    }
    
    public static map<id,List<contact>> getAccountContacts(){
        map<id,List<contact>> contactsMap = new map<id,List<contact>>();
        
        for(contact cont:[Select id,AccountId,Name from contact]){
            if(contactsMap.get(cont.AccountId) == null){
                list<contact> conList = new list<contact>();
                conList.add(cont);
                contactsMap.put(cont.AccountId,conList);
            }
            else{
                list<contact> conlist = contactsMap.get(cont.AccountId);
                conlist.add(cont);
                contactsMap.put(cont.AccountId,conlist);
                
				//contactsMap.get(cont.AccountId).add(cont);         
            }
        }
       return contactsMap; 
    }
    
    
}