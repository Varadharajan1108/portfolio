public with sharing class RetriveDuplicatRules {
   @AuraEnabled(cacheable=true)
   public static List<DuplicateRule> retrieveDuplicateRules(){
    return[SELECT Id, DeveloperName, CreatedDate, LastModifiedDate, LastModifiedById FROM DuplicateRule];

    }
}