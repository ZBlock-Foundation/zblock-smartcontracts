const uuid = require("uuid-random");
const assert = require("chai").assert;
const truffleAssert = require("truffle-assertions");

const catchRevert = require("./exceptionHelpers").catchRevert;
const ZBlock = artifacts.require("ZBlock");
const Community = artifacts.require("Community");

contract("ZBlock", (accounts) => {
  let zblock;
  const owner = accounts[0];
  const communityFounder = accounts[1];
  const securityManager = accounts[2];

  // Community Data
  let communityDetail = {
    id: uuid(),
    name: "Community 1",
    description: "My First Community",
    website: "zblock.herokuapp.com",
    founderName: "John Doe",
    founderEmail: "john@doe.com",
    founderPhone: "00000000000",
  };
  let communityType = 0; // eco-village
  let communityPurposes = [0, 1, 2]; // permaculture, vegan, eco-friendly
  let communityAddress = {
    country: "France",
    city: "Paris",
    addressDetail: "my street",
  };
  let communityFundLocking = {
    minLockingDate: 3, // 3 months
    maxLockingDate: 12, // 12 months
  };
  let communityFundReleasing = {
    targetAmount: 100000, // euros
    releaseFund: 0,
    securityManager: securityManager,
  };

  beforeEach(async () => {
    zblock = await ZBlock.new();
  });

  describe("Creating New Community", () => {
    it("- should able to create new community when all fields are valid.", async () => {
      const communityInfo = {
        founder: communityFounder,
        detail: communityDetail,
        typeInfo: communityType,
        purposes: communityPurposes,
        addressInfo: communityAddress,
        fundLocking: communityFundLocking,
        fundReleasing: communityFundReleasing,
      };

      let tx = await zblock.newCommunity(communityInfo, {
        from: communityFounder,
      });
      truffleAssert.eventEmitted(tx, "CommunityCreated", (ev) => {
        return (
          ev.communityIndex.eq(new web3.utils.BN(0)) &&
          ev.communityFounder === communityFounder
        );
      });
    });
  });

  describe("Getting Communities", () => {
    it("- should able to retrieve all created communities.", async () => {
      const communityInfo = {
        founder: communityFounder,
        detail: communityDetail,
        typeInfo: communityType,
        purposes: communityPurposes,
        addressInfo: communityAddress,
        fundLocking: communityFundLocking,
        fundReleasing: communityFundReleasing,
      };

      await zblock.newCommunity(communityInfo, { from: communityFounder });
      const communities = await zblock.communityList();

      assert.equal(
        communities.length,
        1,
        "fetching all communities is not successfull."
      );
    });
  });
});
