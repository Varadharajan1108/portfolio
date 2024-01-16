public with sharing class RetrieveLWCComponents {
    @AuraEnabled(cacheable=true)
    public static String fetchUserSessionId() {
        String sessionId = '';
        if (Test.isRunningTest()) {
            sessionId = UserInfo.getSessionId().substring(15);
        } else {
            PageReference reportPage = Page.GetSessionId; // Replace 'GetSessionId' with your actual Visualforce page name
            String vfContent = reportPage.getContent().toString();
            Integer startP = vfContent.indexOf('Start_Of_Session_Id') + 'Start_Of_Session_Id'.length();
            Integer endP = vfContent.indexOf('End_Of_Session_Id');
            sessionId = vfContent.substring(startP, endP);
        }
        return sessionId;
    }

    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> retrieveLWCComponents() {
        List<Map<String, String>> LWCList = new List<Map<String, String>>();
        map<string,string> datamap=new map<string,string>();
        // Set the Salesforce REST API endpoint URL for LWC components
        String lwcRestEndpoint = '/services/data/v58.0/tooling/query/?q=Select+Id,DeveloperName,CreatedDate,LastModifiedDate,LastModifiedById+from+LightningComponentBundle';

        // Fetch the user session ID
        String sessionId = fetchUserSessionId();

        // Create an HTTP request for LWC components
        HttpRequest lwcRequest = new HttpRequest();
        lwcRequest.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + lwcRestEndpoint);
        lwcRequest.setMethod('GET');
        lwcRequest.setHeader('Authorization', 'Bearer ' + sessionId);

        // Create an HTTP object to send the request
        Http http = new Http();

        // Send the request for LWC components
        HttpResponse lwcResponse = http.send(lwcRequest);

        // Check the response status for LWC components
        if (lwcResponse.getStatusCode() == 200) {
            // The request for LWC components was successful, parse the JSON response
            Map<String, Object> lwcJsonResponse = (Map<String, Object>) JSON.deserializeUntyped(lwcResponse.getBody());
            List<Object> lwcRecords = (List<Object>) lwcJsonResponse.get('records');

            for (Object lwcRecord : lwcRecords) {
                Map<String, Object> lwcRecordMap = (Map<String, Object>) lwcRecord;
                String lwcId = (String) lwcRecordMap.get('Id');
                String lwcDeveloperName = (String) lwcRecordMap.get('DeveloperName');
                String lwcCreatedDate = (String) lwcRecordMap.get('CreatedDate');
                String lwcLastModifiedDate = (String) lwcRecordMap.get('LastModifiedDate');
                String lwcLastModifiedById = (String) lwcRecordMap.get('LastModifiedById');


                Map<String, String> lwcMap = new Map<String, String>();
                lwcMap.put('Id', lwcId);
                lwcMap.put('DeveloperName', lwcDeveloperName);
                lwcMap.put('CreatedDate', lwcCreatedDate);
                lwcMap.put('LastModifiedDate', lwcLastModifiedDate);
                lwcMap.put('LastModifiedById', lwcLastModifiedById);


                LWCList.add(lwcMap);
            }
        }
        
        return LWCList;
    }
}
