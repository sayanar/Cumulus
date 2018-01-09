({
	saveTemplate: function (component, newTemplateRecord, batchTemplateFields, batchTemplateFieldsToDelete) {

		var action;

		if (component.get("v.toCreate")) {
			action = component.get("c.saveTemplate");
			action.setParams({
				"newTemplate": newTemplateRecord,
				"batchTemplateFields": batchTemplateFields
			});
		}
		else if (component.get("v.toClone")) {
			action = component.get("c.cloneTemplate");
			action.setParams({
				"newTemplate": newTemplateRecord,
				"batchTemplateFields": batchTemplateFields
			});
		}
		else if (component.get("v.toEdit")) {
			action = component.get("c.editTemplate");
			action.setParams({
				"newTemplate": newTemplateRecord,
				"batchTemplateFields": batchTemplateFields,
				"batchTemplateFieldsToDelete": batchTemplateFieldsToDelete
			});
		}

		action.setCallback(this, function (response) {

			var state = response.getState();

			if (state === "SUCCESS") {

				var toastEvent = $A.get("e.force:showToast");
				var result = response.getReturnValue();

				if (result) {
					toastEvent.setParams({
						title: "Success!",
						message: "The record has been saved successfully.",
						type: "success",
						duration: 5
					});
				}
				else {
					toastEvent.setParams({
						title: "Warning!",
						message: "Already exists a record with it Name, please change.",
						type: "warning",
						duration: 5
					});
				}
				
				toastEvent.fire();
			}
		});
		$A.enqueueAction(action);
	},

	createObjectData: function (component, event) {
		// get the templateFields from component and add(push) New Object to List
		var rowItemList = component.get("v.templateFields");

		rowItemList.push({
			'sobjectType': 'Batch_Template_Field__c',
			'Name': '',
			'Order__c': 0,
			'Read_Only__c': false,
			'Required__c': false,
			'Sticky_Field__c': false,
			'Sticky_Field_Value__c': '',
			'Sticky_Field_Visibility__c': false
		});
		// set the updated list to attribute (templateFields) again
		component.set("v.templateFields", rowItemList);
		console.log('FIRST ROW ' + component.get("v.templateFields"));
	},
	// helper function for check if first Name is not null/blank on save  
	validateRequired: function (component, event) {
		var isValid = true;
		var allContactRows = component.get("v.templateFields");
		for (var indexVar = 0; indexVar < allContactRows.length; indexVar++) {
			if (allContactRows[indexVar].Name == '') {
				isValid = false;
				alert('First Name Can\'t be Blank on Row Number ' + (indexVar + 1));
			}
		}
		return isValid;
	},
})