public with sharing class BGE_TemplateController {

    public static Batch_Template__c templateRecord = new Batch_Template__c();
    public static DataImportBatch__c batchRecord = new DataImportBatch__c();
    public static Id templateId;
    public static String[] templateFieldNames = new String[]{};
    public static Batch_Template_Field__c[] templateFields;
    public static Batch_Template_Field__c[] templateFieldsToDelete;

    public BGE_TemplateController() {

    }

	//@AuraEnabled
    public static Id saveBatch (DataImportBatch__c batch, Id templateId) {

        Id batchId = null;
        batchRecord = batch;
        batchRecord.Batch_Template__c = templateId;

        // Insert batch
        if (batchRecord != null) {

           insert batchRecord;
           batchId = batchRecord.Id;
           System.debug('Batch data ' + batchRecord);
        }
        return batchId;
    }

    public static Id updateBatch (DataImportBatch__c batch, Id templateId) {

        Id batchId = null;
        batchRecord = batch;
        batchRecord.Batch_Template__c = templateId;

        // Insert batch
        if (batchRecord != null) {

           update batchRecord;
           batchId = batchRecord.Id;
        }
        return batchId;
    }

    //@AuraEnabled
    public static Boolean saveTemplate (Batch_Template__c newTemplate, Batch_Template_Field__c[] batchTemplateFields) {

        Boolean isSaved;
        templateRecord = newTemplate;
        templateFields = batchTemplateFields;
        // Insert template
        if (templateRecord != null) {

            try {
                insert templateRecord;
                saveTemplateFields(templateFields, templateRecord.Id);
                isSaved = true;
            }
            catch (Exception ex) {
                isSaved = false;
            }
        }
        return isSaved;
    }

    public static Boolean deleteTemplate (Id templateIdToDelete) {

        Boolean result;
        Batch_Template__c templateToDelete;
        Batch_Template__c[] templates = [SELECT Id FROM Batch_Template__c WHERE Id = :templateIdToDelete LIMIT 1];
        DataImportBatch__c[] batches = [SELECT Id, Batch_Template__c FROM DataImportBatch__c WHERE Batch_Template__c = :templateIdToDelete LIMIT 10000];

        if (!templates.isEmpty() && batches.isEmpty()) {

            templateToDelete = templates[0];

            try {
                delete templateToDelete;
                result = true;
            }
            catch(Exception ex) {
                result = false;
            }
        }
        else {
            result = false;
        }
        return result;
    }

    public static Boolean cloneTemplate (Batch_Template__c newTemplate, Batch_Template_Field__c[] batchTemplateFields) {

        Boolean isSaved;
        templateRecord = newTemplate;
        templateFields = batchTemplateFields;

        Batch_Template__c templateToClone = new Batch_Template__c(Name = templateRecord.Name, Description__c = templateRecord.Description__c);

        // Insert template
        if (templateToClone != null) {

            try {
                insert templateToClone;
                isSaved = true;
                cloneTemplateFields(templateFields, templateToClone.Id);
            }
            catch (Exception ex) {
                isSaved = false;
            }
        }
        return isSaved;
    }

    public static Boolean editTemplate (Batch_Template__c newTemplate, Batch_Template_Field__c[] batchTemplateFields, Batch_Template_Field__c[] batchTemplateFieldsToDelete) {

        Boolean isSaved;
        templateRecord = newTemplate;
        templateFields = batchTemplateFields;
        templateFieldsToDelete = batchTemplateFieldsToDelete;

        // Update template
        if (templateRecord != null) {

            try {
                update templateRecord;
                saveTemplateFields(templateFields, templateRecord.Id);
                deleteTemplateFields(templateFieldsToDelete);
                isSaved = true;
            }
            catch (Exception ex) {
                isSaved = false;
            }
        }
        return isSaved;
    }

    private static void saveTemplateFields (Batch_Template_Field__c[] templateFields, Id templateId) {

        Batch_Template_Field__c[] templateFieldsToSave = new Batch_Template_Field__c[]{};

        for (Batch_Template_Field__c templateField : templateFields) {

            if (templateField.Batch_Template__c  == null) {

                templateField.Batch_Template__c = templateId;   
            }
            templateFieldsToSave.add(templateField);
        }

        if (!templateFieldsToSave.isEmpty()) {
            upsert templateFieldsToSave;
        }
    }

    private static void cloneTemplateFields (Batch_Template_Field__c[] templateFields, Id templateId) {

        Batch_Template_Field__c[] templateFieldsToSave = new Batch_Template_Field__c[]{};
        Batch_Template_Field__c templateToClone;

        for (Batch_Template_Field__c templateField : templateFields) {

            templateToClone =  new Batch_Template_Field__c(Batch_Template__c = templateId,
                                                            Name = templateField.Name,
                                                            Order__c = templateField.Order__c,
                                                            Read_Only__c = templateField.Read_Only__c,
                                                            Required__c = templateField.Required__c,
                                                            Sticky_Field__c = templateField.Sticky_Field__c,
                                                            Sticky_Field_Value__c = templateField.Sticky_Field_Value__c,
                                                            Sticky_Field_Visibility__c = templateField.Sticky_Field_Visibility__c);

            templateFieldsToSave.add(templateToClone);
        }

        if (!templateFieldsToSave.isEmpty()) {
            insert templateFieldsToSave;
        }
    }

    public static Boolean deleteTemplateFields (Batch_Template_Field__c[] templateFieldsToDelete) {

        Boolean result;

        if (!templateFieldsToDelete.isEmpty()) {

            try {
                delete templateFieldsToDelete;
                result = true;
            }
            catch (Exception ex) {
                result = false;
            }
        }

        return result;
    }

    public static Batch_Template_Field__c[] loadTemplateFields (Id templateId) {

        Batch_Template_Field__c[] templateFields = new Batch_Template_Field__c[]{};

        templateFields = [SELECT Id,
                                Name,
                                Order__c,
                                Read_Only__c,
                                Required__c,
                                Sticky_Field__c,
                                Sticky_Field_Value__c,
                                Sticky_Field_Visibility__c,
                                Batch_Template__c
                            FROM Batch_Template_Field__c
                            WHERE Batch_Template__c = :templateId
                            LIMIT 10000];

        if (templateFields.isEmpty()) {
            templateFields = null;
        }

        return templateFields;
    }

    //@AuraEnabled
    public static Batch_Template__c[] loadTemplates () {

        Batch_Template__c[] templates = new Batch_Template__c[]{};

        templates = [SELECT Id, Name, Description__c FROM Batch_Template__c];

        return templates;
    }
}