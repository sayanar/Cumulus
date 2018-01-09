({
	nextToTemplateSelection: function (component, event, helper) {

		$A.createComponent(
			"c:BGE_TemplateSelection",
			{},

			function (newComp) {
				var content = component.find("body");
				content.set("v.body", newComp);
			});
	},

	nextToEnterData: function (component, event, helper) {

		var batchId = component.get("v.batchId");
		console.log('BATCH TO ENTRY DATA 2' + batchId);
		if (batchId != null) {

			$A.createComponent(
				"c:BatchDataEntryPOCGrid",
				{ "batchId": component.get("v.batchId") },


				function (newComp) {
					var content = component.find("body");
					content.set("v.body", newComp);
				});
		}
	},

	handleUploadFinished: function (cmp, event) {
		// Get the list of uploaded files
		alert('TEST');
		var uploadedFiles = event.getParam("files");
		alert("Files uploaded : " + uploadedFiles.length);
	}


})