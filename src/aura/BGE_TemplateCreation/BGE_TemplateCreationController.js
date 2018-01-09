({
    doInit: function(component, event, helper) {

        var template = component.get('v.template');

        if (template.Id != null) {

            var action = component.get('c.loadTemplateFields');
            action.setParams({
                "templateId": template.Id
            });
            action.setCallback(this, function (response) {
                //store state of response
                var state = response.getState();

                if (state === "SUCCESS") {

                    if (response.getReturnValue() != null) {
                        //set response value in objClassController attribute on component
                        component.set('v.templateFields', response.getReturnValue());
                    }
                }
            });
            $A.enqueueAction(action);

        }
 
        // create a Default RowItem [Contact Instance] on first time Component Load
        // by call this helper function  
        helper.createObjectData(component, event);
    },

    lightningInputOnChange: function(component, event, helper) {

        var templateName = component.find("templateName").get("v.value")

        if (templateName && templateName.length > 2) {
            component.set("v.nextButtonEnabled", true);
        }
    },

    save: function (component, event, helper) {

        var template = component.get('v.template');
        var batchTemplateFields = component.get('v.templateFields');
        var batchTemplateFieldsToDelete = component.get('v.templateFieldsToDelete');

        console.log('NEW FIELDS TO DELETE ' + batchTemplateFieldsToDelete);
        helper.saveTemplate(component, template, batchTemplateFields, batchTemplateFieldsToDelete);
    },

    nextToInitial: function (component, event, helper) {

        $A.createComponent(
            "c:BGE_Initial",
            {},

            function (newComp) {
                var content = component.find("body");
                content.set("v.body", newComp);
            });
    },

    // function for save the Records 
   /*Save: function (component, event, helper) {
        // first call the helper function in if block which will return true or false.
        // this helper function check the "first Name" will not be blank on each row.
        if (helper.validateRequired(component, event)) {
            // call the apex class method for save the Contact List
            // with pass the contact List attribute to method param.  
            var action = component.get("c.saveContacts");
            action.setParams({
                "ListContact": component.get("v.contactList")
            });
            // set call back 
            action.setCallback(this, function (response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    // if response if success then reset/blank the 'contactList' Attribute 
                    // and call the common helper method for create a default Object Data to Contact List 
                    component.set("v.contactList", []);
                    helper.createObjectData(component, event);
                    alert('record Save');
                }
            });
            // enqueue the server side action  
            $A.enqueueAction(action);
        }
    },*/

    // function for create new object Row in Contact List 
    addNewRow: function (component, event, helper) {
        // call the comman "createObjectData" helper method for add new Object Row to List  
        helper.createObjectData(component, event);
    },

    // function for delete the row 
    removeRow: function (component, event, helper) {

        // get the selected row Index for delete, from Lightning Event Attribute  
        var index = event.getParam("indexVar");
        var fieldToDelete = event.getParam("templateFieldToDelete");
        var templateFieldsToDelete = component.get("v.templateFieldsToDelete");

        if (fieldToDelete.Id != undefined) {

            templateFieldsToDelete.push(fieldToDelete);
            component.set("v.templateFieldsToDelete", templateFieldsToDelete);
        }

        console.log('FIELD TO DELETE ' + fieldToDelete.Id);
        console.log('FIELDS TO DELETE ' + component.get("v.templateFieldsToDelete"));
        // get the all List (templateFields attribute) and remove the Object Element Using splice method
        var AllRowsList = component.get("v.templateFields");
        AllRowsList.splice(index, 1);
        // set the templateFields after remove selected row element
        component.set("v.templateFields", AllRowsList);
    },
})