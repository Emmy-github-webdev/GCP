const {Then} = require('@cucumber/cucumber');

function getParameterCaseInsensitive(object, key) {
    const asLowercase = key.toLowerCase();
    return object[Object.keys(object)
      .find(k => k.toLowerCase() === asLowercase)
    ];
  }

Then(/^custom header (.*) should be (.*)$/, {timeout: 30000}, function (customHeader, customValue, callback) {
    var self = this;
    var response = JSON.parse(self.apickli.getResponseObject().body);
    var envReturned = getParameterCaseInsensitive(JSON.parse(response.outputParameters["`Task_2_responseBody`"]).headers, customHeader);
    var assertion = this.apickli.assertResponseCode("200");
	if (envReturned == customValue && assertion.success) {
			callback();
		} else {
			callback(JSON.stringify(assertion));
		}
});