const { expect } = require("chai");
// describe("verify name",function(){
 
// });





describe("Token contract", function () {
  let Token;
  let hardhatToken;

  beforeEach(async () =>{
    [deployer, user1, user2, ...users] = await ethers.getSigners();
    Token = await ethers.getContractFactory("Token");
    hardhatToken = await Token.deploy();
  }) 

  it("name is correct", async function(){
    expect(await hardhatToken.name()).to.equal("Black Eye Token");
  });

  it("symbol is correct", async function(){
    expect(await hardhatToken.symbol()).to.equal("BET");
  });

  it("Deployment should assign the total supply of tokens to the owner", async function () {
    const ownerBalance = await hardhatToken.balanceOf(deployer.address);
    expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);
  });

  it("test transation 1", async function() {
    await hardhatToken.transfer(user1.address, 0);
    expect(await hardhatToken.balanceOf(user1.address)).to.equal(0);
  });

  it("test transation 2", async function() {
    await hardhatToken.transfer(user1.address, 500);
    expect(await hardhatToken.balanceOf(user1.address)).to.equal(500);
    await hardhatToken.connect(user1).transfer(user2.address, 40);
    expect(await hardhatToken.balanceOf(user2.address)).to.equal(40);
  });

});