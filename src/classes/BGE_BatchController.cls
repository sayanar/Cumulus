public with sharing class BGE_BatchController {

	public static DataImportBatch__c batchRecord = new DataImportBatch__c();

	public BGE_BatchController() {

	}

//	@AuraEnabled
    public static void saveBatch (DataImportBatch__c newBatch) {

        batchRecord = newBatch;

        // Insert batch
        if (batchRecord != null) {

           //insert batchRecord;
           System.debug('Batch data ' + batchRecord);
        }   
    }

//    @AuraEnabled
    public static List<DataImportBatch__c> findByName(String searchKey) {

        String trimText = searchKey.trim();
        String name = '%' + trimText + '%';
        List<DataImportBatch__c> result = null;

        // Find all the statuses in the BGE_Status_list__c custom setting.
        Map<String, BGE_Status_list__c> statusesMap = BGE_Status_list__c.getAll();

        // Create a Set of statuses to filter the query.
        Set<String> statusesSet  = statusesMap.keySet();

        // If the user had input text.
        if (!String.isEmpty(trimText)) {

            // Query for a List of Batches filtered by status and the text the user had input.
            result = [SELECT Id, Name, CreatedDate, Batch_Description__c, Batch_Template__c FROM DataImportBatch__c WHERE Name LIKE :name and Status__c IN: statusesSet LIMIT 10];
        }

        return result;
    }

    public void updateBatch (Id batchId, Id templateId) {

        DataImportBatch__c[] batches = [SELECT Id, Batch_Template__c FROM DataImportBatch__c WHERE Id = :batchId LIMIT 1];

        DataImportBatch__c batch = batches[0];

        Batch_Template__c[] templates = [SELECT Id FROM Batch_Template__c WHERE Id = :templateId LIMIT 1];
        Batch_Template__c template = templates[0];

        batch.Batch_Template__c = template.Id;

        update batch;

    }
}