public class AnimalLocator {
    public static String getAnimalNameById(Integer id) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+id);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
       	/*Map<String,Object> results = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
        system.debug('---->results'+results);
        List<Object> animals = (List<Object>) results.get('animal');
        system.debug('---->animal'+animals);*/
        Map<Integer,String> mapAnimal = new Map<Integer,String>();
        Integer varId;
        String varName;
        JSONParser parser1= JSON.createParser(response.getBody());
        while (parser1.nextToken() != null) {
            if ((parser1.getCurrentToken() == JSONToken.FIELD_NAME) && (parser1.getText() == 'id')) {
                // Get the value.
                parser1.nextToken();
                // Fetch the ids for all animals in JSON Response.
                varId=parser1.getIntegerValue();
                System.debug('---->varId-->'+varID);
                parser1.nextToken();
            }
            if ((parser1.getCurrentToken() == JSONToken.FIELD_NAME) && (parser1.getText() == 'name')) {
                parser1.nextToken();
                // Fetch the names for all animals in JSON Response.
                varName=parser1.getText();
                System.debug('---->varName-->'+varName);
            }
            mapAnimal.put(varId,varName);
        }
        system.debug('---->mapAnimal-->'+mapAnimal);
        return mapAnimal.get(id); 
        
    }
}