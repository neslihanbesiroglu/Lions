public class CaseOriginHandler {

    public static void handleNewCases (List<Case> newCases) {
        // Create a set to store unique origins from new cases
        Set<String> newOrigins = new Set<String>();
        for (Case newCase : newCases) {
            newOrigins.add(newCase.Origin);
        }
        
        // Query for old cases with the same origin
        Map<String, Case> originToOldCase = new Map<String, Case>();
        for (Case oldCase : [SELECT Id, Origin FROM Case WHERE Origin IN :newOrigins]) {
            originToOldCase.put(oldCase.Origin, oldCase);
        }
        
        // Assign the old case as the Parent Case for new cases
        for (Case newCase : newCases) {
            Case oldCase = originToOldCase.get(newCase.Origin);
            if (oldCase != null) {
                newCase.ParentId = oldCase.Id;
            }
        }
    }
}