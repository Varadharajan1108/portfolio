public with sharing class RetrieveDashboardData {
    @AuraEnabled (Cacheable=true)
    public static List<Dashboard> retrieveDashboardData(){
       return [SELECT Id, DeveloperName, CreatedDate, LastModifiedDate, LastModifiedById FROM Dashboard];
    }
}