public class TestController {
    
    //list of the inner class
    public List<innerClass> lstInner{ get;set; }
    //will indicate the row to be deleted
    public String selectedRowIndex{get;set;}
    //no. of rows added/records in the inner class list
    public Integer count = 1;    //{get;set;}
    
    
    public TestController(){
        lstInner = new List<innerClass>();
        addMore();
        selectedRowIndex = '0';
    }
    
    public void Add(){
        count = count+1;
        addMore();
    }
    
    
    public void addMore(){
        //call to the iner class constructor
        innerClass objInnerClass = new innerClass(count);
        //add the record to the inner class list
        lstInner.add(objInnerClass);
        system.debug('stInner—->'+lstInner);
    }
    
    
    /* begin delete */
    public void Del(){
        
        lstInner.remove(Integer.valueOf(selectedRowIndex)-1);
       count = count-1;
        integer i=1;
        
        for(innerClass rec:lstInner){
            rec.recCount = string.valueOf(i);
            i++;
        }
    }
    /*End del*/
    
    
    
    //inner class
    public class innerClass{
        public String recCount{get;set;}
        public string fristName{get;set;}
        public string middleName{get;set;}
        public string lastName{get;set;}
        public string sul{get;set;}
        
        
        public innerClass(Integer intCount){
            recCount = String.valueOf(intCount);
        }
    }
    
}