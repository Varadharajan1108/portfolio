public with sharing class RetrieveEmailNotifications {
    @AuraEnabled(cacheable=true)
    public static List<ApexEmailNotification> retrieveEmailNotifications() {
        

        return [SELECT Id,UserId,CreatedDate,LastModifiedDate,LastModifiedById FROM ApexEmailNotification];
    }
}
