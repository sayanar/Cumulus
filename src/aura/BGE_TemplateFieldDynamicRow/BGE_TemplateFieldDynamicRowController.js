({
	addNewRow: function (component, event, helper) {
		// fire the AddNewRowEvt Lightning Event 
		/*var message = "Please review the following fields:\n";
		var fields = [];
		var result = helper.checkFieldsPopulation(component, message, fields);

		if (result) {*/
			component.getEvent("AddRowEvent").fire();
		//}
	},

	removeRow: function (component, event, helper) {
		// fire the DeleteRowEvt Lightning Event and pass the deleted Row Index to Event parameter/attribute
		component.getEvent("DeleteRowEvent").setParams({ "indexVar": component.get("v.rowIndex"), "templateFieldToDelete": component.get("v.TemplateFieldInstance") }).fire();
	},

})