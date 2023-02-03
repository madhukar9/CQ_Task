public class displayImageExtension {
    String recId;
    
    public displayImageExtension() {
        recId = '0016F00003Vw5tL';    
    }
    
    public String getFileId() {
        String fileId = '';
        List<Attachment> attachedFiles = [select Id from Attachment where parentId =:recId order By LastModifiedDate DESC limit 1];
        if( attachedFiles != null && attachedFiles.size() > 0 ) {
            fileId = attachedFiles[0].Id;
        }
        return fileId;    
    }
}