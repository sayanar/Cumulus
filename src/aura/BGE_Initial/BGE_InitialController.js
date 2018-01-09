({

	nextToContinueBatch : function(component, event, helper) {

        $A.createComponent(
            "c:BGE_BatchContainer",
            {
                'showBatchSelection': true,
                'showProgressBar': false
            },

            function(newComp) {
            var content = component.find("body");
            content.set("v.body", newComp);
        });
    },

	nextToCreateBatch : function(component, event, helper) {

        $A.createComponent(
            "c:BGE_BatchContainer",
            {
                'showBatchCreation': true,
                'showProgressBar': true,
                'processStage': 'createBatchStage'
            },

            function(newComp) {
            var content = component.find("body");
            content.set("v.body", newComp);
        });
    },

	nextToCreateTemplate : function(component, event, helper) {

        $A.createComponent(
            "c:BGE_BatchContainer",
            {
                'showTemplateCreation': true,
                'showProgressBar': true
            },

            function(newComp) {
            var content = component.find("body");
            content.set("v.body", newComp);
        });
    },

})