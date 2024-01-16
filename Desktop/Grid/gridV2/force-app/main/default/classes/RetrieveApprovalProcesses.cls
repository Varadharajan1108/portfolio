public with sharing class RetrieveApprovalProcesses {
   @AuraEnabled(cacheable=true)
   public static List<ProcessDefinition> retrieveApprovalProcesses(){
    return [SELECT Id, Name, CreatedDate, LastModifiedDate, LastModifiedById FROM ProcessDefinition];
   }
}