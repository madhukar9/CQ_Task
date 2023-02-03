trigger AccountAddressTrigger on Account (before insert,before update) {
    if (Trigger.isInsert && Trigger.isBefore) {
        for(Account a : Trigger.New) {
            If (a.Match_Billing_Address__c == true && a.BillingPostalCode!=Null) {
                a.ShippingPostalCode = a.BillingPostalCode;
            }
        }
    }
}