@isTest
public class UnitOfWorkTest {
@isTest static void challengeComplete(){
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
        new Schema.SObjectType[]{
            Account.SObjectType,
            Contact.SObjectType,
            Note.SObjectType
        }
    );

    for (Integer i=0 ; i<100 ; i++) {
        Account a = new Account(Name= 'Test' + i);
        uow.registerNew(a);

        for (Integer j=0 ; j<5 ; j++) {
            Contact c = new Contact(LastName = 'Test'+i + ' ' +j);
            uow.registerNew(c, Contact.AccountId, a);

            Note n = new Note(Body='Test '+i + '' + j, Title='Test'+i+j);
            //uow.registerRelationship(n, Note.ParentId, a);
            //uow.registerNew(n, Note.ParentId, a);
            uow.registerNew(n, Note.ParentId, c);
        }
    }

    uow.commitWork();

    fflib_SObjectUnitOfWork uow2 = new fflib_SObjectUnitOfWork(
        new Schema.SObjectType[]{
            Account.SObjectType,
            Contact.SObjectType,
            Note.SObjectType
        }
    );        

    Id oldAccountId;
    Account a2;
    for (Contact c : [SELECT Id, LastName, AccountId, Account.Name, (SELECT Id, ParentId, Title, Body FROM Notes) FROM Contact Order By AccountId, Id]) {

        if (oldAccountId != c.AccountId) {
            oldAccountId = c.AccountId;
            a2 = new Account(Id=c.AccountId, Name='Test');
            uow2.registerDirty(a2);
        }

            c.LastName = 'Test';
            uow2.registerDirty(c);


            c.Notes[0].Body = 'Test';

            uow2.registerDirty(c.Notes[0]);

    }        

    test.startTest();
    uow2.commitWork();
    //uow.commitWork();
    test.stopTest();

    System.assertEquals(100, [Select Id from Account].size());
    System.assertEquals(500, [Select Id from Contact].size());
    System.assertEquals(500, [Select Id from Note].size());
}
}