public with sharing class AuraComponentRetrieval {

    // Define the Tooling API endpoint
    private static final String TOOLING_API_ENDPOINT = '/services/data/v58.0/tooling/query/?q=';

    // Define the query to retrieve Aura components
    private static final String AURA_COMPONENT_QUERY = 'SELECT Id, DeveloperName, CreatedDate, LastModifiedDate,LastModifiedById FROM AuraDefinitionBundle';

    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> retrieveAuraComponents() {
        // Construct the full Tooling API query URL
        String queryUrl = TOOLING_API_ENDPOINT + EncodingUtil.urlEncode(AURA_COMPONENT_QUERY, 'UTF-8');

        // Fetch the user session ID
        String sessionId = fetchUserSessionId();

        // Create an HTTP request
        HttpRequest request = new HttpRequest();
        request.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + queryUrl);
        request.setMethod('GET');

        // Set the authentication header with the session ID (you may need to customize this based on your org's authentication method)
        request.setHeader('Authorization', 'Bearer ' + sessionId);

        // Create an HTTP object to send the request
        Http http = new Http();

        // Send the request and get the response
        HttpResponse response = http.send(request);

        // Parse the response into a list of Map<String, String> objects
        List<Map<String, String>> auraComponents = new List<Map<String, String>>();
        if (response.getStatusCode() == 200) {
            // Parse the JSON response into a list of maps
            auraComponents = parseAuraComponents(response.getBody());
        } else {
            // Handle errors or exceptions here
            System.debug('HTTP request failed with status code: ' + response.getStatusCode());
            System.debug('Response body: ' + response.getBody());
        }

        return auraComponents;
    }

    // Helper method to parse the Aura components from the JSON response
    private static List<Map<String, String>> parseAuraComponents(String jsonResponse) {
        List<Map<String, String>> auraComponents = new List<Map<String, String>>();
        Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(jsonResponse);

        if (responseMap.containsKey('records')) {
            List<Object> records = (List<Object>) responseMap.get('records');
            for (Object record : records) {
                Map<String, Object> recordMap = (Map<String, Object>) record;
                Map<String, String> auraComponent = new Map<String, String>();
                auraComponent.put('Id', (String) recordMap.get('Id'));
                auraComponent.put('Name', (String) recordMap.get('DeveloperName'));
                auraComponent.put('CreatedDate', (String) recordMap.get('CreatedDate'));
                auraComponent.put('LastModifiedDate', (String) recordMap.get('LastModifiedDate'));
                auraComponent.put('LastModifiedById', (String) recordMap.get('LastModifiedById'));

                auraComponents.add(auraComponent);
            }
        }

        return auraComponents;
    }

    // Implement the fetchUserSessionId method as before
   
    public static String fetchUserSessionId() {
        String sessionId = '';
        if (Test.isRunningTest()) {
            sessionId = UserInfo.getSessionId().substring(15);
        } else {
            PageReference reportPage = Page.GetSessionId;
            String vfContent = reportPage.getContent().toString();
            System.debug('vfContent ' + vfContent);
            Integer startP = vfContent.indexOf('Start_Of_Session_Id') + 'Start_Of_Session_Id'.length();
            Integer endP = vfContent.indexOf('End_Of_Session_Id');
            sessionId = vfContent.substring(startP, endP);
        }

        return sessionId;
    }
    }
