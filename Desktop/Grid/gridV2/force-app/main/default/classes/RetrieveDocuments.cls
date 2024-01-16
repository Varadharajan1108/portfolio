public with sharing class RetrieveDocuments {
    @AuraEnabled(cacheable=true)
    public static List<Document> retrieveDocuments() {
        return [SELECT Id, Name, CreatedById, LastModifiedDate, LastModifiedById FROM Document];
    }
}
