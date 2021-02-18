pragma solidity 0.7.0;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/utils/Pausable.sol";
import "./Community.sol";

/**
    @title ZBlock Foundation SmartContract
    @author ssozuer
 */
contract ZBlock is Pausable {
	/// @dev the owner of the ZBlock smartcontract
	address internal owner;

	/// @dev community smartcontract addresses
	Community[] internal communities;

	/// @dev (communityId => community) map to fast access
	mapping(uint256 => Community) internal communityOf;

	/// @dev community id for each created community
	uint256 internal communityIdCounter;

	event CommunityCreated(
		uint256 indexed communityIndex,
		address indexed communityFounder
	);

	constructor() {
		owner = msg.sender;
		communityIdCounter = 0;
	}

	function newCommunity(Community.CommunityInfo memory _communityInfo)
		public
		whenNotPaused
	{
		require(
			msg.sender == _communityInfo.founder,
			"Community creator must be same with founder address!"
		);

		Community community = new Community(_communityInfo);
		communities.push(community);
		communityOf[communityIdCounter] = community;

		emit CommunityCreated(communityIdCounter, msg.sender);
		communityIdCounter++;
	}

	function communityList() public view returns (Community[] memory) {
		return communities;
	}
}
