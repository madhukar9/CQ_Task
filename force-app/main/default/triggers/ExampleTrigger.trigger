trigger ExampleTrigger on Contact (after insert, after delete) {
    if (Trigger.isInsert) {
        Integer recordCount = Trigger.New.size();
        // Call a utility method from another class
        String address = 'aketimadhukar@gmail.com';
        String subject = 'Speaker Confirmation';
        String body = 'Thank you for speaking at the conference.';
        String[]  addresses = new String[]{},
            subjects = new String[]{},
                messages = new String[]{};
                    addresses.add(address);
        subjects.add(subject);
        messages.add(body);
        
        EmailManager.sendMail(addresses, subjects, messages);
    }
    else if (Trigger.isDelete) {
        // Process after delete
    }
}