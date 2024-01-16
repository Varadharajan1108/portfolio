public with sharing class DataController {
     
    @AuraEnabled (cacheable=true)
    public static List<ApexClass> retrieveData(){
        // Updated SOQL query to select fields from the "MetaAPI__c" object
        return [SELECT Id, Name, CreatedDate, LastModifiedDate, LastModifiedById 
        FROM ApexClass
        LIMIT 2000];

}
}
