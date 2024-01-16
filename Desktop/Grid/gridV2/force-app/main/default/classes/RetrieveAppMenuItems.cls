public with sharing class RetrieveAppMenuItems {
    @AuraEnabled(cacheable=true)
    public static List<AppMenuItem> retrieveAppMenuItem() {
        // Retrieve data from the AppMenuItem object based on your query
        return [SELECT Id, Name, CreatedDate, LastModifiedDate, LastModifiedById FROM AppMenuItem];
    }
}