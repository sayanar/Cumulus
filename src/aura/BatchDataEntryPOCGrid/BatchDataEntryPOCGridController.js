({

    /*
    batchDataImport : function(component, event, helper) {
		
        helper.batchDataImportHelper(component, event, helper);
	},*/
    /*
    doInitAction : function(component, event, helper) {
        console.log('SET BATCH ID');
        var action = component.get("c.setBatchId");
        action.setParams({ "pBatchId": component.get("v.batchId") });
       	action.setCallback( this, function(response) {
        	var state = response.getState();
            if (state === "SUCCESS") {
            
               	console.log(response.getReturnValue());
	        }
    	});
       	$A.enqueueAction(action);
	},*/
    
    nextToValidateAndCommit : function(component, event, helper) {
        alert('CONTINUE TO VALIDATION');
        helper.continueToValidationHelper(component);
		alert("SET COMPONENT");
        component.set("v.processStage", "commitBatchStage");
        
        /*
        $A.createComponent(
            "c:BGE_ValidateANDCommit",
            {
                'showBatchCreation': true,
                'showProgressBar': true
            },
			//alert("FUNCTION");
            function(newComp) {

                var content = component.find("body");

            	content.set("v.body", newComp);
 	       });*/
    },

    nextToBatchSelection : function(component, event, helper) {
		
		$A.createComponent(
			"c:BGE_BatchSelection",
			{},

			function(newComp) {
			var content = component.find("body");
			content.set("v.body", newComp);
		});
	},
    
})