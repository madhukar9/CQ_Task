public class ContactSearch {

    public static List<Contact> searchForContacts (String lastName, String postalCode){
    	List<Contact> con = new List<Contact>(); 
        con = [SELECT Id FROM Contact WHERE (LastName =: lastName AND MailingPostalCode =: postalCode )];
        
        return con;
    }
}