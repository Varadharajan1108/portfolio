public with sharing class GetFlowDetailsController {

    // flowCount returns the count of the flow.
      @AuraEnabled
      public static Integer flowCount(){
        try {
          Integer flowcountval = [SELECT count() FROM FlowDefinitionView WITH SECURITY_ENFORCED];
          return flowcountval;
        } catch (Exception e) {
          throw new AuraHandledException(e.getMessage());
        }
      }
    }