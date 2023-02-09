global class SyncProductAndPartsBatch implements Database.Batchable<sobject> {
    
    global database.QueryLocator start (Database.BatchableContext bc){
        
        string query ='Select id,Name,Part_Number__c,Product__c,Active__c From SQX_Part__c Where Active__c = true and Product__c = Null Limit 49999';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, list<SQX_Part__c> partRecords){
        Map<string,SQX_Part__c> partsMap = new Map<string,SQX_Part__c>();
        list<SQX_Part__c>updateParts = new list<SQX_Part__c>();
        for(SQX_Part__c part:partRecords){
            partsMap.put(part.Part_Number__c,part);
        }
        
        map<string,Product2> productMap = getProductRecords(partsMap);
        for(SQX_Part__c part:partRecords){
            if(productMap.get(part.Part_Number__c) != null){
                part.Product__c = productMap.get(part.Part_Number__c).Id;
                updateParts.add(part);
            }
        }
       
        update updateParts;
       
    }
    
    
    //Create Products if not exist and prepare the products map
    //inputs: Map of parts records
    //output: Map of products records
    public static map<string,Product2> getProductRecords( Map<string,SQX_Part__c> partsMap){
        
        map<string,Product2> productMap = new map<string,Product2>();
        list<product2> productList = new list<product2>();
        for(Product2 prod:[Select id,Name,ProductCode from Product2 Where ProductCode IN:partsMap.keySet()]){
            productMap.put(prod.ProductCode,prod);
        }
        
        for(string key:partsMap.keyset()){
            if(productMap.get(key) == null){
                product2 prod = new product2();
                prod.Name = partsMap.get(key).Name;
                prod.ProductCode = partsMap.get(key).Part_Number__c;
                prod.isActive= true;
                productList.add(prod);
            }
        }
        if(productList.size()>0){
            insert productList;
            for(Product2 prod:productList){
                productMap.put(prod.ProductCode,prod);
            }
        }
        
        return productMap;
    }
    
     global void finish(Database.BatchableContext bc){
        
        
    }
    

}