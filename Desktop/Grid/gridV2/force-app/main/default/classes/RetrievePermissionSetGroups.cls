public with sharing class RetrievePermissionSetGroups {
    @AuraEnabled(cacheable=true)
    public static List<PermissionSetGroup> RetrievePermissionSetGroups() {
        return [SELECT Id, DeveloperName, CreatedDate, LastModifiedDate, LastModifiedById FROM PermissionSetGroup];
    }
}