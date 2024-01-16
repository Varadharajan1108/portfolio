public with sharing class RetrieveCustomObject {
    @AuraEnabled(cacheable=true)
    public static List<EntityDefinition> retrieveCustomObjects(){
        return[SELECT Id, DeveloperName, LastModifiedDate, LastModifiedById 
        FROM EntityDefinition 
        WHERE DurableId LIKE '01I%' 
        ORDER BY Label 
        LIMIT 2000
        ];
    }
}