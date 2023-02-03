public class AccountPdf {
    public AccountPdf(ApexPages.StandardController c) {
        String yourFileName = 'nameofFile.pdf' ;
        Apexpages.currentPage().getHeaders().put( 'content-disposition', 'inline; filename=' + yourFileName );
    }
}