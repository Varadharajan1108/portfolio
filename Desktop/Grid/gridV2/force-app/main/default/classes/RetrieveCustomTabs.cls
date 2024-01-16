public with sharing class RetrieveCustomTabs {
    // Function to retrieve Custom Tab data
    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> retrieveCustomTabs() {
        List<Map<String, String>> customTabList = new List<Map<String, String>>();

        // Set the Salesforce REST API endpoint URL for Custom Tabs
        String customTabRestEndpoint = '/services/data/v58.0/tooling/query/?q=SELECT+Id,DeveloperName,+CreatedDate,+LastModifiedDate,+LastModifiedById+FROM+CustomTab';

        // Fetch the user session ID
        String sessionId = fetchUserSessionId();

        // Create an HTTP request for Custom Tabs
        HttpRequest customTabRequest = new HttpRequest();
        customTabRequest.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + customTabRestEndpoint);
        customTabRequest.setMethod('GET');
        customTabRequest.setHeader('Authorization', 'Bearer ' + sessionId);

        // Create an HTTP object to send the request
        Http http = new Http();

        // Send the request for Custom Tabs
        HttpResponse customTabResponse = http.send(customTabRequest);

        // Check the response status for Custom Tabs
        if (customTabResponse.getStatusCode() == 200) {
            // The request for Custom Tabs was successful, parse the JSON response
            Map<String, Object> customTabJsonResponse = (Map<String, Object>) JSON.deserializeUntyped(customTabResponse.getBody());
            List<Object> customTabRecords = (List<Object>) customTabJsonResponse.get('records');

            for (Object customTabRecord : customTabRecords) {
                Map<String, Object> customTabRecordMap = (Map<String, Object>) customTabRecord;

                String customTabId = (String) customTabRecordMap.get('Id');
                String customTabDeveloperName = (String) customTabRecordMap.get('DeveloperName');
                String customTabCreatedDate = (String) customTabRecordMap.get('CreatedDate');
                String customTabLastModifiedDate = (String) customTabRecordMap.get('LastModifiedDate');
                String customTabLastModifiedById = (String) customTabRecordMap.get('LastModifiedById');

                Map<String, String> customTabMap = new Map<String, String>();
                customTabMap.put('Id', customTabId);
                customTabMap.put('DeveloperName',customTabDeveloperName);
                customTabMap.put('CreatedDate', customTabCreatedDate);
                customTabMap.put('LastModifiedDate', customTabLastModifiedDate);
                customTabMap.put('LastModifiedById', customTabLastModifiedById);

                customTabList.add(customTabMap);
            }
        }

        return customTabList;
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
