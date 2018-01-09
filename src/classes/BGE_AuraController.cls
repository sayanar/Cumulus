public with sharing class BGE_AuraController {
/*
	public static final String LIKE_OPERATOR = '%';

	@AuraEnabled
	public static Batch__c[] getActiveBatches(String stream) {
		return getBatchRecords(stream);
    }

	@AuraEnabled
	public static Batch__c[] getCompletedBatches(String stream) {
		return getBatchRecords(stream);
    }

	@AuraEnabled
	public static DataImport__c[] getDataImports(Id batchId) {
		return getDataImportRecords(batchId);
    }

	public static Batch__c[] getBatchRecords(String stream) {

		Batch__c[] result = new Batch__c[] {};

		if (!String.isEmpty(stream)) {

			stream = LIKE_OPERATOR + stream + LIKE_OPERATOR;

			result = [SELECT
						Id,
						Name,
						CreatedDate,
						LastModifiedDate,
						Description__c,
						Batch_Status__c
					FROM Batch__c
					WHERE Name
					LIKE :stream];
		}

		return result;
    }

	public static DataImport__c[] getDataImportRecords(Id batchId) {

		DataImport__c[] result = new DataImport__c[] {};

		result = [SELECT
					Account1_City__c,
					Account1_Country__c,
					Account1ImportStatus__c,
					Account1Imported__c,
					Account1_Name__c,
					Account1_Phone__c,
					Account1_State_Province__c,
					Account1_Street__c,
					Account1_Website__c,
					Account1_Zip_Postal_Code__c,
					Account2_City__c,
					Account2_Country__c,
					Account2ImportStatus__c,
					Account2Imported__c,
					Account2_Name__c,
					Account2_Phone__c,
					Account2_State_Province__c,
					Account2_Street__c,
					Account2_Website__c,
					Account2_Zip_Postal_Code__c,
					ApexJobId__c,
					Batch__c,
					Campaign_Member_Status__c,
					Donation_Campaign_Name__c,
					Contact1_Alternate_Email__c,
					Contact1_Birthdate__c,
					Contact1_Firstname__c,
					Contact1_Home_Phone__c,
					Contact1ImportStatus__c,
					Contact1Imported__c,
					Contact1_Lastname__c,
					Contact1_Mobile_Phone__c,
					Contact1_Other_Phone__c,
					Contact1_Personal_Email__c,
					Contact1_Preferred_Email__c,
					Contact1_Preferred_Phone__c,
					Contact1_Salutation__c,
					Contact1_Title__c,
					Contact1_Work_Email__c,
					Contact1_Work_Phone__c,
					Contact2_Alternate_Email__c,
					Contact2_Birthdate__c,
					Contact2_Firstname__c,
					Contact2_Home_Phone__c,
					Contact2ImportStatus__c,
					Contact2Imported__c,
					Contact2_Lastname__c,
					Contact2_Mobile_Phone__c,
					Contact2_Other_Phone__c,
					Contact2_Personal_Email__c,
					Contact2_Preferred_Email__c,
					Contact2_Preferred_Phone__c,
					Contact2_Salutation__c,
					Contact2_Title__c,
					Contact2_Work_Email__c,
					Contact2_Work_Phone__c,
					CreatedById,
					Name,
					Donation_Amount__c,
					Donation_Date__c,
					Donation_Description__c,
					Donation_Donor__c,
					DonationImportStatus__c,
					DonationImported__c,
					Donation_Member_Level__c,
					Donation_Membership_End_Date__c,
					Donation_Membership_Origin__c,
					Donation_Membership_Start_Date__c,
					Donation_Name__c,
					Donation_Possible_Matches__c,
					Donation_Record_Type_Name__c,
					Donation_Stage__c,
					Donation_Type__c,
					FailureInformation__c,
					HomeAddressImportStatus__c,
					HomeAddressImported__c,
					Home_City__c,
					Home_Country__c,
					Home_State_Province__c,
					Home_Street__c,
					Home_Zip_Postal_Code__c,
					HouseholdAccountImported__c,
					Household_Phone__c,
					ImportedDate__c,
					LastModifiedById,
					OwnerId,
					Payment_Check_Reference_Number__c,
					PaymentImportStatus__c,
					Payment_Method__c,
					PaymentImported__c,
					Status__c,
					Payment_Possible_Matches__c
				FROM DataImport__c
				WHERE Batch__c = :batchId];

		return result;
	}*/


	@AuraEnabled
    public static Id saveBatchTemplate (DataImportBatch__c batch, Id templateId) {

		Id result = BGE_TemplateController.saveBatch(batch,templateId);
		return result;
	}

	@AuraEnabled
    public static Id updateBatchTemplate (DataImportBatch__c batch, Id templateId) {

		Id result = BGE_TemplateController.updateBatch(batch,templateId);
		return result;
	}

	@AuraEnabled
    public static Boolean saveTemplate (Batch_Template__c newTemplate, Batch_Template_Field__c[] batchTemplateFields) {

		return BGE_TemplateController.saveTemplate (newTemplate, batchTemplateFields);
	}

	@AuraEnabled
    public static Boolean deleteTemplate (Id templateIdToDelete) {

		return BGE_TemplateController.deleteTemplate (templateIdToDelete);
	}

	@AuraEnabled
    public static Boolean cloneTemplate (Batch_Template__c newTemplate, Batch_Template_Field__c[] batchTemplateFields) {

		return BGE_TemplateController.cloneTemplate (newTemplate, batchTemplateFields);
	}

	@AuraEnabled
    public static Boolean editTemplate (Batch_Template__c newTemplate, Batch_Template_Field__c[] batchTemplateFields, Batch_Template_Field__c[] batchTemplateFieldsToDelete) {

		return BGE_TemplateController.editTemplate (newTemplate, batchTemplateFields, batchTemplateFieldsToDelete);
	}

	@AuraEnabled
    public static Batch_Template_Field__c[] loadTemplateFields (Id templateId) {

		return BGE_TemplateController.loadTemplateFields(templateId);
	}

	@AuraEnabled
    public static Batch_Template__c[] loadTemplates () {

		return BGE_TemplateController.loadTemplates();
	}

	@AuraEnabled
    public static void saveBatch (DataImportBatch__c newBatch) {

		BGE_BatchController.saveBatch(newBatch);
	}

	@AuraEnabled
    public static List<DataImportBatch__c> findByName(String searchKey) {

		return BGE_BatchController.findByName(searchKey);
	}


}