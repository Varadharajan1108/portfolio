public with sharing class RetrieveAssignmentRules {
    @AuraEnabled(cacheable=true)
    public static List<AssignmentRule> retrieveAssignmentRules() {
        return [SELECT Id, Name, CreatedDate, LastModifiedDate, LastModifiedById FROM AssignmentRule];
}
}