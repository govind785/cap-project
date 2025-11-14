sap.ui.define([
    "sap/m/MessageToast",
    "sap/m/Dialog",
    "sap/m/Button",
    "sap/m/List",
    "sap/m/StandardListItem"
], function (MessageToast, Dialog, Button, List, StandardListItem) {
    "use strict";

    return {
        onCustomButtonPress: function () {
            MessageToast.show("Fetching hospital data...");

            $.ajax({
                url: "/odata/v4/hospital/Hospitals",
                method: "GET",
                dataType: "json",
                success: function (oData) {
                    if (oData && oData.value && oData.value.length > 0) {
                        const hospitalRecords = oData.value;
                        let selectedHospitalId = null;

                        // ✅ Create a selectable list
                        const oList = new List({
                            mode: "SingleSelect", // allows one selection
                            items: hospitalRecords.map(function (hospital) {
                                return new StandardListItem({
                                    title: hospital.name,
                                    description: `ID: ${hospital.ID}`,
                                    type: "Active",
                                    customData: [
                                        new sap.ui.core.CustomData({
                                            key: "hospitalId",
                                            value: hospital.ID
                                        })
                                    ]
                                });
                            }),
                            selectionChange: function (oEvent) {
                                const selectedItem = oEvent.getParameter("listItem");
                                selectedHospitalId = selectedItem.getCustomData()[0].getValue();
                                MessageToast.show("Selected Hospital ID: " + selectedHospitalId);
                            }
                        });

                        // ✅ Create dialog with Submit button
                        const oDialog = new Dialog({
                            title: "Select Hospital to Submit",
                            contentWidth: "450px",
                            content: [oList],
                            beginButton: new Button({
                                text: "Submit",
                                type: "Emphasized",
                                press: function () {
                                    if (!selectedHospitalId) {
                                        MessageToast.show("⚠ Please select a hospital first!");
                                        return;
                                    }

                                    // Build the POST payload
                                    const payload = {
                                        HospitalID: selectedHospitalId,
                                        Action: "SubmitFromDialog"
                                    };

                                    MessageToast.show("Submitting hospital ID: " + selectedHospitalId + "...");

                                    // POST request
                                    $.ajax({
                                        url: "/odata/v4/hospital/Submissions", // make sure this exists in your CAP service
                                        method: "POST",
                                        contentType: "application/json",
                                        data: JSON.stringify(payload),
                                        success: function () {
                                            MessageToast.show("✅ Submission successful!");
                                            oDialog.close();
                                        },
                                        error: function (xhr, status, error) {
                                            MessageToast.show("❌ Submission failed: " + status);
                                        }
                                    });
                                }
                            }),
                            endButton: new Button({
                                text: "Cancel",
                                press: function () {
                                    oDialog.close();
                                }
                            })
                        });

                        oDialog.open();

                    } else {
                        MessageToast.show("No hospitals found.");
                    }
                },
                error: function (xhr, status, error) {
                    console.error("❌ ERROR:", status, error);
                    MessageToast.show("Failed to fetch hospital data!");
                }
            });
        }
    };
});
