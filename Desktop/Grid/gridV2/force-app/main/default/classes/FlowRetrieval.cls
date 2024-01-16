public class FlowRetrieval {

    // Define the Tooling API endpoint
    private static final String TOOLING_API_ENDPOINT = '/services/data/v58.0/tooling/query/?q=';

    // Define the query to retrieve Flow information
    private static final String FLOW_QUERY = 'SELECT Id, DeveloperName, Description, LastModifiedDate FROM FlowDefinition';

    // Define a method to retrieve Flow information
    public static List<FlowDefinition> getFlows() {
        // Construct the full Tooling API query URL
        String queryUrl = TOOLING_API_ENDPOINT + EncodingUtil.urlEncode(FLOW_QUERY, 'UTF-8');

        // Create an HTTP request
        HttpRequest request = new HttpRequest();
        request.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + queryUrl);
        request.setMethod('GET');

        // Set the authentication header (You may need to customize this based on your org's authentication method)
        // Example: request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());

        // Send the request and get the response
        HttpResponse response = new Http().send(request);

        // Parse the response
        List<FlowDefinition> flows = new List<FlowDefinition>();
        if (response.getStatusCode() == 200) {
            // Parse the JSON response into FlowDefinition objects
            flows = (List<FlowDefinition>) JSON.deserialize(
                response.getBody(), List<FlowDefinition>.class);
        } else {
            // Handle errors or exceptions here
            System.debug('HTTP request failed with status code: ' + response.getStatusCode());
            System.debug('Response body: ' + response.getBody());
        }

        return flows;
    }
}
