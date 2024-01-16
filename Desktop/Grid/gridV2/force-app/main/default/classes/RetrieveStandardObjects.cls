public with sharing class RetrieveStandardObjects {
    @AuraEnabled(cacheable=true)
    public static List<EntityDefinition> retrieveStandardObjects(){
        return[SELECT Id, DeveloperName, Label, LastModifiedDate, LastModifiedById 
        FROM EntityDefinition 
        WHERE IsCustomizable = false
        ORDER BY Label 
        LIMIT 2000
        
        ];
    }
}