(function () { "use strict";
var client = {};
client.Client = function() {
	console.log("hello");
};
client.Client.main = function() {
	var app = new client.Client();
};
client.Client.main();
})();
