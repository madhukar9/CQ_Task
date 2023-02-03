@isTest
public class TestDataUtility {
    
    public static user createUser(string profileId,string userName){
        User usr = new User(Alias = 'aa', Email='testuser111@testorg.com',
                            EmailEncodingKey='UTF-8', FirstName='yhsl',LastName='test', LanguageLocaleKey='en_US',
                            LocaleSidKey='en_US', ProfileId = profileId,
                            TimeZoneSidKey='America/Los_Angeles', UserName=userName);
        insert usr;
        return usr;
    }
 
    public static Account createAccount(String name, Boolean doInsert) {
        Account acc = new Account(name = name);
        if(doInsert) {
            insert acc;
        }
        return acc;
    }
}