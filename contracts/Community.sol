pragma solidity 0.7.0;
pragma experimental ABIEncoderV2;

/**
    @title ZBlock Community Smart Contract
    @author ssozuer
 */
contract Community {
	struct CommunityInfo {
		address founder;
		CommunityDetail detail;
		CommunityType typeInfo;
		CommunityPurpose[] purposes;
		CommunityAddress addressInfo;
		CommunityFundLocking fundLocking;
		CommunityFundReleasing fundReleasing;
	}

	struct CommunityDetail {
		string id;
		string name;
		string description;
		string website;
		string founderName;
		string founderEmail;
		string founderPhone;
	}

	struct CommunityAddress {
		string country;
		string city;
		string addressDetail;
	}

	struct CommunityFundLocking {
		uint256 minLockingDate;
		uint256 maxLockingDate;
	}

	struct CommunityFundReleasing {
		uint256 targetAmount;
		ReleaseFund releaseFund;
		address payable securityManager;
	}

	enum CommunityType {
		ECO_VILLAGE,
		CO_HOUSING,
		INCOME_SHARING,
		SHARED_HOUSE,
		SHARED_FLAT,
		HOMESTEAD
	}

	enum CommunityPurpose {
		PERMACULTURE,
		VEGAN,
		ECO_FRIENDLY,
		RELIGIOUS,
		SELF_SUFFICIENT,
		ANTISPECIST,
		POLITICAL
	}

	enum ReleaseFund { TARGET_100_FUNDED, TARGET_75_FUNDED, TARGET_50_FUNDED }

	CommunityInfo internal community;

	constructor(CommunityInfo memory _communityInfo) {
		require(
			_communityInfo.founder != address(0),
			"Founder ethereum address must be given"
		);
		require(
			bytes(_communityInfo.detail.name).length > 0,
			"Community name must be given"
		);
		require(
			bytes(_communityInfo.detail.description).length > 0,
			"Community description must be given"
		);
		require(
			bytes(_communityInfo.detail.founderName).length > 0,
			"Community founder name must be given"
		);
		require(
			bytes(_communityInfo.detail.founderEmail).length > 0,
			"Community founder email must be given"
		);
		require(
			bytes(_communityInfo.detail.founderPhone).length > 0,
			"Community founder phone must be given"
		);
		require(
			_communityInfo.typeInfo >= CommunityType.ECO_VILLAGE &&
				_communityInfo.typeInfo <= CommunityType.HOMESTEAD,
			"Community type must be be given"
		);
		require(
			_communityInfo.purposes.length > 0,
			"Community purpose tag must be given"
		);
		require(
			bytes(_communityInfo.addressInfo.country).length > 0,
			"Community address country must be given"
		);
		require(
			bytes(_communityInfo.addressInfo.city).length > 0,
			"Community address city must be given"
		);
		require(
			bytes(_communityInfo.addressInfo.addressDetail).length > 0,
			"Community address detail must be given"
		);
		require(
			_communityInfo.fundLocking.minLockingDate > 0,
			"Community min. fund locking must be given"
		);
		require(
			_communityInfo.fundLocking.maxLockingDate > 0,
			"Community max. fund locking must be given"
		);
		require(
			_communityInfo.fundReleasing.targetAmount > 0,
			"Community fund target amount must be given"
		);
		require(
			_communityInfo.fundReleasing.releaseFund >= ReleaseFund.TARGET_100_FUNDED ||
				_communityInfo.fundReleasing.releaseFund <= ReleaseFund.TARGET_50_FUNDED,
			"Community fund releasing target value must be given"
		);
		require(
			_communityInfo.fundReleasing.securityManager != address(0),
			"Community fund release security manager must be given"
		);

		community = _communityInfo;
	}

	function getInfo() public view returns (CommunityInfo memory) {
		return community;
	}
}
