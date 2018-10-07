pragma solidity ^0.4.23;

contract Soldex {
  address public owner;
  address private feeRecipient;
  byte constant version = 1; // kick off our contract version

  struct Order {
    uint quantity;  // amount in wei (10^18)
    uint price;     // how do you do decimals like in prices?
    address owner;  // who submitted this order?
  }


  // STATE VARIABLES
  Order[] bidStack;     // how will we order this?
  Order[] offerStack;   // how will we order this?
  // Funds being held to allow bids and offers
  mapping ( bytes32 => uint ) public escrow;
  // for v1, the exchange is just trading with itself so needs a wallet
  mapping ( bytes32 => uint ) public wallet;
  bytes32[] supportedCurrencies;

  // Events:
  // event LogBidReceived( address addr, uint quantity, uint price );
  // LogOfferReceived( address addr, uint quantity, uint price );
  // LogTradeSettled( address buyAddr, address sellAddr, uint quantity, uint price );


  constructor() public {
    owner = msg.sender;
    supportedCurrencies = [bytes32("USD"), bytes32("ETH")];
    for(uint i = 0; i < supportedCurrencies.length; i++){
      escrow[supportedCurrencies[i]] = 0;
      wallet[supportedCurrencies[i]] = 1000000;
    }
  }

  // Modifiers
  // modifier isFeeRecipient(){ require(msg.sender == feeRecipient); _; }

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  modifier sufficientFunds( Order _order) {
    require (msg.value >= _order.price * _order.quantity );
    _;
  }

  function placeBid(uint _quantity, uint _price) public returns(bool){
    // Add bids to the bid stack
    // Add funds to escrow
    return false;
  }

  function placeOffer( uint _quantity, uint _price) public returns(bool){
    // add offers to the offer stack
    // Add funds to the escrow
    return false;
  }

  // Very basic: Assumes quantity and price are the same
  function executeTrade( uint buyQuantity, uint buyPrice, address buyAddress, uint sellQuantity, uint sellPrice, address sellAddress ) public returns(bool){
    // Match the two orders, verifying they match.
    // Subtract wallet funds and escrow funds as appropriate
  }

  // Change who will get all the fees when we cash out
  function reassignFees( address newRecipient ) restricted public returns(address){
    feeRecipient = newRecipient;
    return newRecipient;
  }

  // Cash out
  function cashOut() public returns( bool ){
    // subtract balances
    // send the money back to the recipient
    return false;
  }

}
