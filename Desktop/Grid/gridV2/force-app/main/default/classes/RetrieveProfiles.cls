public with sharing class RetrieveProfiles {
    @AuraEnabled(cacheable=true)
    public static List<Profile> retrieveProfiles() {
        return [SELECT Id, Name, CreatedDate, LastModifiedDate, LastModifiedById FROM Profile];
    }
}
