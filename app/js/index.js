var addToLog = function(id, txt) {
	$(id + " .logs").append("<br>" + txt);
};

var numberOfPhotos = 0;

$(document).ready(function() {
	EmbarkJS.Storage.setProvider('ipfs',{server: 'localhost', port: '8545'});

	$("#upload .error").hide();
	EmbarkJS.Storage.ipfsConnection.ping()
		.then(function(){
		})
		.catch(function(err) {
			if(err){
				console.log("IPFS Connection Error => " + err.message);
			}
		});


	
});
