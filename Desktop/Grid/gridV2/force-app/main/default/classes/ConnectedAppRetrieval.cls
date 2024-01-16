public with sharing class ConnectedAppRetrieval {
    @AuraEnabled(cacheable=true)
    public static List<ConnectedApplication> retrieveConnectedApplications() {
        return [SELECT Id, Name, CreatedDate, LastModifiedDate, LastModifiedById FROM ConnectedApplication];
    }
}
