// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

contract GravatarRegistry {
  //两个事件
  // createGravatar emit
  event NewGravatar(uint id, address owner, string displayName, string imageUrl);
  // updateGravatarName、updateGravatarImage  emit
  event UpdatedGravatar(uint id, address owner, string displayName, string imageUrl);

  struct Gravatar {
    address owner;
    string displayName;
    string imageUrl;
  }

  Gravatar[] public gravatars;

  mapping (uint => address) public gravatarToOwner;
  mapping (address => uint) public ownerToGravatar;

  function createGravatar(string memory _displayName, string memory _imageUrl) public {
     //每账户只能有一个
    require(ownerToGravatar[msg.sender] == 0);   
    gravatars.push(Gravatar(msg.sender, _displayName, _imageUrl));
    //id其实就是长度 从0开始 方便我们从gravatars拿取Gravatar
    uint id = gravatars.length; 
    ownerToGravatar[msg.sender] = id;

    gravatarToOwner[id] = msg.sender;

    emit NewGravatar(id, msg.sender, _displayName, _imageUrl);
  }

  function getGravatar(address owner) public view returns (string memory , string memory) {
    uint id = ownerToGravatar[owner];
    return (gravatars[id].displayName, gravatars[id].imageUrl);
  }

  function updateGravatarName(string memory _displayName) public {
    require(ownerToGravatar[msg.sender] != 0);
    require(msg.sender == gravatars[ownerToGravatar[msg.sender]].owner);

    uint id = ownerToGravatar[msg.sender];

    gravatars[id].displayName = _displayName;
    emit UpdatedGravatar(id, msg.sender, _displayName, gravatars[id].imageUrl);
  }

  function updateGravatarImage(string memory _imageUrl) public {
    require(ownerToGravatar[msg.sender] != 0);
    require(msg.sender == gravatars[ownerToGravatar[msg.sender]].owner);

    uint id = ownerToGravatar[msg.sender];

    gravatars[id].imageUrl =  _imageUrl;
    emit UpdatedGravatar(id, msg.sender, gravatars[id].displayName, _imageUrl);
  }

  // the gravatar at position 0 of gravatars[]
  // is fake
  // it's a mythical gravatar
  // that doesn't really exist
  // dani will invoke this function once when this contract is deployed
  // but then no more
  function setMythicalGravatar() public {
    require(msg.sender == 0x8d3e809Fbd258083a5Ba004a527159Da535c8abA);
    gravatars.push(Gravatar(address(0), " ", " "));
  }
}
