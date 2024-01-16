public with sharing class RetrievePermissionSets {
   @AuraEnabled (Cacheable=true)
   public static List<PermissionSet> retrievePermissionSets(){
    return[SELECT Id, Name, CreatedDate, LastModifiedDate, LastModifiedById FROM PermissionSet];
    

    }
}