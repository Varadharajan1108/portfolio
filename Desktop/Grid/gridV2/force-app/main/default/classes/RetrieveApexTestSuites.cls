public with sharing class RetrieveApexTestSuites {
    @AuraEnabled(cacheable=true)
    public static List<ApexTestSuite> retrieveApexTestSuites() {
        // Retrieve data from the AppMenuItem object based on your query
        return [SELECT Id, TestSuiteName, CreatedById, LastModifiedDate, LastModifiedById
                FROM ApexTestSuite];
    }
}
