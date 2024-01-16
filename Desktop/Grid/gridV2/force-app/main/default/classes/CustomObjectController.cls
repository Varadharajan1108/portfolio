public with sharing class CustomObjectController {
    @AuraEnabled(cacheable=true)
    public static List<String> getCustomObjectNames() {
        List<String> objectNames = new List<String>();
        for(Schema.SObjectType objType : Schema.getGlobalDescribe().values()) {
            if (objType.getDescribe().isCustom()) {
                objectNames.add(objType.getDescribe().getName());
            }
        }
        return objectNames;
    }
}
