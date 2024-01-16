public with sharing class RetrieveCustomApplications {
    // Function to retrieve Custom Application data
    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> retrieveCustomApplications() {
        List<Map<String, String>> customApplicationList = new List<Map<String, String>>();

        // Set the Salesforce REST API endpoint URL for Custom Applications
        String customAppRestEndpoint = '/services/data/v58.0/tooling/query/?q=SELECT+Id,DeveloperName,+CreatedDate,+LastModifiedDate,+LastModifiedById+FROM+CustomApplication';

        // Fetch the user session ID
        String sessionId = fetchUserSessionId();

        // Create an HTTP request for Custom Applications
        HttpRequest customAppRequest = new HttpRequest();
        customAppRequest.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + customAppRestEndpoint);
        customAppRequest.setMethod('GET');
        customAppRequest.setHeader('Authorization', 'Bearer ' + sessionId);

        // Create an HTTP object to send the request
        Http http = new Http();

        // Send the request for Custom Applications
        HttpResponse customAppResponse = http.send(customAppRequest);

        // Check the response status for Custom Applications
        if (customAppResponse.getStatusCode() == 200) {
            // The request for Custom Applications was successful, parse the JSON response
            Map<String, Object> customAppJsonResponse = (Map<String, Object>) JSON.deserializeUntyped(customAppResponse.getBody());
            List<Object> customAppRecords = (List<Object>) customAppJsonResponse.get('records');

            for (Object customAppRecord : customAppRecords) {
                Map<String, Object> customAppRecordMap = (Map<String, Object>) customAppRecord;

                String customAppId = (String) customAppRecordMap.get('Id');
                String customAppDeveloperName = (String) customAppRecordMap.get('DeveloperName');
                String customAppCreatedDate = (String) customAppRecordMap.get('CreatedDate');
                String customAppLastModifiedDate = (String) customAppRecordMap.get('LastModifiedDate');
                String customAppLastModifiedById = (String) customAppRecordMap.get('LastModifiedById');

                Map<String, String> customAppMap = new Map<String, String>();
                customAppMap.put('Id', customAppId);
                customAppMap.put('DeveloperName', customAppDeveloperName);
                customAppMap.put('CreatedDate', customAppCreatedDate);
                customAppMap.put('LastModifiedDate', customAppLastModifiedDate);
                customAppMap.put('LastModifiedById', customAppLastModifiedById);

                customApplicationList.add(customAppMap);
            }
        }

        return customApplicationList;
    }

    // Function to fetch the user session ID
    public static String fetchUserSessionId() {
        String sessionId = '';
        if (Test.isRunningTest()) {
            sessionId = UserInfo.getSessionId().substring(15);
        } else {
            PageReference reportPage = Page.GetSessionId;
            String vfContent = reportPage.getContent().toString();
            Integer startP = vfContent.indexOf('Start_Of_Session_Id') + 'Start_Of_Session_Id'.length();
            Integer endP = vfContent.indexOf('End_Of_Session_Id');
            sessionId = vfContent.substring(startP, endP);
        }

        return sessionId;
    }
}
