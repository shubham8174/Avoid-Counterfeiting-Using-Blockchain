App = {

    web3Provider: null,
    contracts: {},

    init: async function() {
        return await App.initWeb3();
    },

    initWeb3: function() {
        if(window.web3) {
            App.web3Provider=window.web3.currentProvider;
        } else {
            App.web3Provider=new Web3.proviers.HttpProvider('http://localhost:7545');
        }

        web3 = new Web3(App.web3Provider);
        return App.initContract();
    },

    initContract: function() {

        $.getJSON('product.json',function(data){

            var productArtifact=data;
            App.contracts.product=TruffleContract(productArtifact);
            App.contracts.product.setProvider(App.web3Provider);
        });

        return App.bindEvents();
    },

    bindEvents: function() {

        $(document).on('click','.btn-register',App.registerProduct);
    },

    registerProduct: function(event) {
        event.preventDefault();

        var productInstance;

        var retailerName = document.getElementById('RetailerName').value;
        var retailerBrand = document.getElementById('RetailerBrand').value;
        var retailerCode = document.getElementById('RetailerCode').value;
        var retailerPhoneNumber = document.getElementById('RetailerPhoneNumber').value;
        var retailerManager = document.getElementById('RetailerManager').value;
        var retailerAddress = document.getElementById('RetailerAddress').value;
        var ManufacturerId = document.getElementById('ManufacturerId').value;
       
        
        
        web3.eth.getAccounts(function(error,accounts){

            if(error) {
                console.log(error);
            }

            console.log(accounts);
            var account=accounts[0];
            

            App.contracts.product.deployed().then(function(instance){
                productInstance=instance;
                return productInstance.addRetailer(web3.fromAscii(ManufacturerId),web3.fromAscii(retailerName),web3.fromAscii(retailerBrand), web3.fromAscii(retailerCode), retailerPhoneNumber, web3.fromAscii(retailerManager), web3.fromAscii(retailerAddress), {from:account});
             }).then(function(result){
                console.log(result);
                window.location.reload();
                document.getElementById('retailerName').innerHTML='';
                document.getElementById('retailerBrand').innerHTML='';

            }).catch(function(err){
                console.log(err.message);
            });
        });
    }
};

$(function() {

    $(window).load(function() {
        App.init();
    })
})