public with sharing class ApexPageController {
    @AuraEnabled(cacheable=true)
    public static List<ApexPage> retrieveApexPages() {
        
        return [SELECT Id, Name, CreatedDate, LastModifiedDate, LastModifiedById FROM ApexPage];
    }
}
