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
		$("#upload button.uploadFile").click(function() {
		var input = $("#upload input[type=file]");
		EmbarkJS.Storage.uploadFile(input).then(function(hash) {
			var webUrl = "https://ipfs.io/ipfs/" + hash;
			switch (numberOfPhotos) {
				case 0:
					$("img.gallery1").attr('src', webUrl);
					$("img.gallery1").attr('href', webUrl);
					$("img.gallery1").attr('title', "Price: " + 3);
					break;
				case 1:
					$("img.gallery2").attr('src', webUrl);
					$("img.gallery2").attr('href', webUrl);
					$("img.gallery2").attr('title', "Price: " + 3);
					break;
				case 2:
					$("img.gallery3").attr('src', webUrl);
					$("img.gallery3").attr('href', webUrl);
					$("img.gallery3").attr('title', "Price: " + 3);
					break;
				case 3:
					$("img.gallery4").attr('src', webUrl);
					$("img.gallery4").attr('href', webUrl);
					$("img.gallery4").attr('title', "Price: " + 3);
					break;
				default:
					// Nothing
					break;
			}
			numberOfPhotos++;

			$("img.gallery").attr('src', webUrl);
			console.log(hash);

			if (EmbarkJS.isNewWeb3()) {
				StockBlock.methods.setHash(hash).send({from:web3.eth.defaultAccount, gas:500000});
				StockBlock.methods.setPrice().send({from:web3.eth.defaultAccount, gas:500000});
			} else {
				StockBlock.setHash(hash);
				StockBlock.setPrice();
			}
		})
		.catch(function(err) {
			if(err){
				console.log("IPFS uploadFile Error => " + err.message);
			}
		});
	});


	
});
