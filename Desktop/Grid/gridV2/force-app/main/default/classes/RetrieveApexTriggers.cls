public with sharing class RetrieveApexTriggers {
   
    @AuraEnabled(cacheable=true)
    public static  List<ApexTrigger> retrieveApexTriggers() {
       
    return [SELECT Id, Name,CreatedDate, CreatedById, LastModifiedDate, LastModifiedById FROM ApexTrigger];

}

}