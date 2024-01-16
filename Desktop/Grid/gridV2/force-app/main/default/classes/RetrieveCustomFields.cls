public with sharing class RetrieveCustomFields {
    // Function to retrieve Custom Field data
    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> retrieveCustomFields() {
        List<Map<String, String>> customFieldList = new List<Map<String, String>>();

        // Set the Salesforce REST API endpoint URL for Custom Fields
        String customFieldRestEndpoint = '/services/data/v58.0/tooling/query/?q=SELECT+Id,DeveloperName,+CreatedDate,+LastModifiedDate,+LastModifiedById+FROM+CustomField';

        // Fetch the user session ID
        String sessionId = fetchUserSessionId();

        // Create an HTTP request for Custom Fields
        HttpRequest customFieldRequest = new HttpRequest();
        customFieldRequest.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + customFieldRestEndpoint);
        customFieldRequest.setMethod('GET');
        customFieldRequest.setHeader('Authorization', 'Bearer ' + sessionId);

        // Create an HTTP object to send the request
        Http http = new Http();

        // Send the request for Custom Fields
        HttpResponse customFieldResponse = http.send(customFieldRequest);

        // Check the response status for Custom Fields
        if (customFieldResponse.getStatusCode() == 200) {
            // The request for Custom Fields was successful, parse the JSON response
            Map<String, Object> customFieldJsonResponse = (Map<String, Object>) JSON.deserializeUntyped(customFieldResponse.getBody());
            List<Object> customFieldRecords = (List<Object>) customFieldJsonResponse.get('records');

            for (Object customFieldRecord : customFieldRecords) {
                Map<String, Object> customFieldRecordMap = (Map<String, Object>) customFieldRecord;

                String customFieldId = (String) customFieldRecordMap.get('Id');
                String customFieldDeveloperName = (String) customFieldRecordMap.get('DeveloperName');
                String customFieldCreatedDate = (String) customFieldRecordMap.get('CreatedDate');
                String customFieldLastModifiedDate = (String) customFieldRecordMap.get('LastModifiedDate');
                String customFieldLastModifiedById = (String) customFieldRecordMap.get('LastModifiedById');

                Map<String, String> customFieldMap = new Map<String, String>();
                customFieldMap.put('Id', customFieldId);
                customFieldMap.put('DeveloperName', customFieldDeveloperName);
                customFieldMap.put('CreatedDate', customFieldCreatedDate);
                customFieldMap.put('LastModifiedDate', customFieldLastModifiedDate);
                customFieldMap.put('LastModifiedById', customFieldLastModifiedById);

                customFieldList.add(customFieldMap);
            }
        }

        return customFieldList;
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
