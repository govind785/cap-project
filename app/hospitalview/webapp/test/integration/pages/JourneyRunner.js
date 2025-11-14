sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"hospitalview/test/integration/pages/HospitalsList",
	"hospitalview/test/integration/pages/HospitalsObjectPage"
], function (JourneyRunner, HospitalsList, HospitalsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('hospitalview') + '/test/flp.html#app-preview',
        pages: {
			onTheHospitalsList: HospitalsList,
			onTheHospitalsObjectPage: HospitalsObjectPage
        },
        async: true
    });

    return runner;
});

