// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

contract product {

    uint256 retailerCount;
    uint256 productCount;

    struct retailer{
        uint256 retailerId;
        bytes32 retailerName;
        bytes32 retailerBrand;
        bytes32 retailerCode;
        uint256 retailerNum;
        bytes32 retailerManager;
        bytes32 retailerAddress;
    }
    mapping(uint=>retailer) public retailers;

    struct productItem{
        uint256 productId;
        bytes32 productSN;
        bytes32 productName;
        bytes32 productBrand;
        uint256 productCost;
        bytes32 productStatus;
    }

    mapping(uint256=>productItem) public productItems;
    mapping(bytes32=>uint256) public productMap;
    mapping(bytes32=>bytes32) public productsManufactured;
    mapping(bytes32=>bytes32) public productsForSale;
    mapping(bytes32=>bytes32) public productsSold;
    mapping(bytes32=>bytes32[]) public productsWithRetailer;
    mapping(bytes32=>bytes32[]) public productsWithCustomer;
    mapping(bytes32=>bytes32[]) public retailerWithManufacturer;


    

    function addRetailer(bytes32 _manufacturerId, bytes32 _retailerName, bytes32 _retailerBrand, bytes32 _retailerCode,
    uint256 _retailerNum, bytes32 _retailerManager, bytes32 _retailerAddress) public{
        retailers[retailerCount] = retailer(retailerCount, _retailerName, _retailerBrand, _retailerCode,
        _retailerNum, _retailerManager, _retailerAddress);
        retailerCount++;

        retailerWithManufacturer[_manufacturerId].push(_retailerCode);
    }


    function viewRetailer () public view returns(uint256[] memory, bytes32[] memory, bytes32[] memory, bytes32[] memory, uint256[] memory, bytes32[] memory, bytes32[] memory) {
        uint256[] memory ids = new uint256[](retailerCount);
        bytes32[] memory snames = new bytes32[](retailerCount);
        bytes32[] memory sbrands = new bytes32[](retailerCount);
        bytes32[] memory scodes = new bytes32[](retailerCount);
        uint256[] memory snums = new uint256[](retailerCount);
        bytes32[] memory smanagers = new bytes32[](retailerCount);
        bytes32[] memory saddress = new bytes32[](retailerCount);
        
        for(uint i=0; i<retailerCount; i++){
            ids[i] = retailers[i].retailerId;
            snames[i] = retailers[i].retailerName;
            sbrands[i] = retailers[i].retailerBrand;
            scodes[i] = retailers[i].retailerCode;
            snums[i] = retailers[i].retailerNum;
            smanagers[i] = retailers[i].retailerManager;
            saddress[i] = retailers[i].retailerAddress;
        }
        return(ids, snames, sbrands, scodes, snums, smanagers, saddress);
    }

    

    function addProduct(bytes32 _manufactuerID, bytes32 _productName, bytes32 _productSN, bytes32 _productBrand,
    uint256 _productCost) public{
        productItems[productCount] = productItem(productCount, _productSN, _productName, _productBrand,
        _productCost, "Available");
        productMap[_productSN] = productCount;
        productCount++;
        productsManufactured[_productSN] = _manufactuerID;
    }


    function viewProductItems () public view returns(uint256[] memory, bytes32[] memory, bytes32[] memory, bytes32[] memory, uint256[] memory, bytes32[] memory) {
        uint256[] memory pids = new uint256[](productCount);
        bytes32[] memory pSNs = new bytes32[](productCount);
        bytes32[] memory pnames = new bytes32[](productCount);
        bytes32[] memory pbrands = new bytes32[](productCount);
        uint256[] memory pcosts = new uint256[](productCount);
        bytes32[] memory pstatus = new bytes32[](productCount);
        
        for(uint i=0; i<productCount; i++){
            pids[i] = productItems[i].productId;
            pSNs[i] = productItems[i].productSN;
            pnames[i] = productItems[i].productName;
            pbrands[i] = productItems[i].productBrand;
            pcosts[i] = productItems[i].productCost;
            pstatus[i] = productItems[i].productStatus;
        }
        return(pids, pSNs, pnames, pbrands, pcosts, pstatus);
    }

    

    function manufacturerSellProduct(bytes32 _productSN, bytes32 _retailerCode) public{
        productsWithRetailer[_retailerCode].push(_productSN);
        productsForSale[_productSN] = _retailerCode;

    }

    function retailerSellProduct(bytes32 _productSN, bytes32 _customerCode) public{   
        bytes32 pStatus;
        uint256 i;
        uint256 j=0;

        if(productCount>0) {
            for(i=0;i<productCount;i++) {
                if(productItems[i].productSN == _productSN) {
                    j=i;
                }
            }
        }

        pStatus = productItems[j].productStatus;
        if(pStatus == "Available") {
            productItems[j].productStatus = "NA";
            productsWithCustomer[_customerCode].push(_productSN);
            productsSold[_productSN] = _customerCode;
        }


    }


    function queryProductsList(bytes32 _retailerCode) public view returns(uint256[] memory, bytes32[] memory, bytes32[] memory, bytes32[] memory, uint256[] memory, bytes32[] memory){
        bytes32[] memory productSNs = productsWithRetailer[_retailerCode];
        uint256 k=0;

        uint256[] memory pids = new uint256[](productCount);
        bytes32[] memory pSNs = new bytes32[](productCount);
        bytes32[] memory pnames = new bytes32[](productCount);
        bytes32[] memory pbrands = new bytes32[](productCount);
        uint256[] memory pcosts = new uint256[](productCount);
        bytes32[] memory pstatus = new bytes32[](productCount);

        
        for(uint i=0; i<productCount; i++){
            for(uint j=0; j<productSNs.length; j++){
                if(productItems[i].productSN==productSNs[j]){
                    pids[k] = productItems[i].productId;
                    pSNs[k] = productItems[i].productSN;
                    pnames[k] = productItems[i].productName;
                    pbrands[k] = productItems[i].productBrand;
                    pcosts[k] = productItems[i].productCost;
                    pstatus[k] = productItems[i].productStatus;
                    k++;
                }
            }
        }
        return(pids, pSNs, pnames, pbrands, pcosts, pstatus);
    }

    function queryRetailersList (bytes32 _manufacturerCode) public view returns(uint256[] memory, bytes32[] memory, bytes32[] memory, bytes32[] memory, uint256[] memory, bytes32[] memory, bytes32[] memory) {
        bytes32[] memory retailerCodes = retailerWithManufacturer[_manufacturerCode];
        uint256 k=0;
        uint256[] memory ids = new uint256[](retailerCount);
        bytes32[] memory snames = new bytes32[](retailerCount);
        bytes32[] memory sbrands = new bytes32[](retailerCount);
        bytes32[] memory scodes = new bytes32[](retailerCount);
        uint256[] memory snums = new uint256[](retailerCount);
        bytes32[] memory smanagers = new bytes32[](retailerCount);
        bytes32[] memory saddress = new bytes32[](retailerCount);
        
        for(uint i=0; i<retailerCount; i++){
            for(uint j=0; j<retailerCodes.length; j++){
                if(retailers[i].retailerCode==retailerCodes[j]){
                    ids[k] = retailers[i].retailerId;
                    snames[k] = retailers[i].retailerName;
                    sbrands[k] = retailers[i].retailerBrand;
                    scodes[k] = retailers[i].retailerCode;
                    snums[k] = retailers[i].retailerNum;
                    smanagers[k] = retailers[i].retailerManager;
                    saddress[k] = retailers[i].retailerAddress;
                    k++;
                    break;
               }
            }
        }

        return(ids, snames, sbrands, scodes, snums, smanagers, saddress);
    }

    function getPurchaseHistory(bytes32 _customerCode) public view returns (bytes32[] memory, bytes32[] memory, bytes32[] memory){
        bytes32[] memory productSNs = productsWithCustomer[_customerCode];
        bytes32[] memory retailerCodes = new bytes32[](productSNs.length);
        bytes32[] memory manufacturerCodes = new bytes32[](productSNs.length);
        for(uint i=0; i<productSNs.length; i++){
            retailerCodes[i] = productsForSale[productSNs[i]];
            manufacturerCodes[i] = productsManufactured[productSNs[i]];
        }
        return (productSNs, retailerCodes, manufacturerCodes);
    }

    

    function verifyProduct(bytes32 _productSN, bytes32 _customerCode) public view returns(bool){
        if(productsSold[_productSN] == _customerCode){
            return true;
        }
        else{
            return false;
        }
    }
}