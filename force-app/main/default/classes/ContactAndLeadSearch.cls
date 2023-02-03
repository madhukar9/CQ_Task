public with sharing class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(string param){
    List<List<Sobject>> searchConLead = [FIND: param IN all fields returning Lead(FirstName, LastName),Contact(FirstName,LastName)];
    return (searchConLead);
   }
  }