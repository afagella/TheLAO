pragma solidity 0.5.3;

// WIP - please make comments through PRs! 

// Purpose: The LAO is designed to streamline the funding of Ethereum ventures with legal security.

// Code is currently in testing // please review carefully before deploying for your own purposes!

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     *
     * NOTE: This is a feature of the next version of OpenZeppelin Contracts.
     * @dev Get it via `npm install @openzeppelin/contracts@next`.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     * NOTE: This is a feature of the next version of OpenZeppelin Contracts.
     * @dev Get it via `npm install @openzeppelin/contracts@next`.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * NOTE: This is a feature of the next version of OpenZeppelin Contracts.
     * @dev Get it via `npm install @openzeppelin/contracts@next`.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

/**
 * @dev Interface of the ERC20 standard as defined in the EIP. Does not include
 * the optional functions; to access them see {ERC20Detailed}.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
contract Context {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, which should be used via inheritance.
    constructor () internal { }
    // solhint-disable-previous-line no-empty-blocks

    function _msgSender() internal view returns (address) {
        return msg.sender;
    }

    function _msgData() internal view returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        _owner = _msgSender();
        emit OwnershipTransferred(address(0), _owner);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Returns true if the caller is the current owner.
     */
    function isOwner() public view returns (bool) {
        return _msgSender() == _owner;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     */
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract GuildBank is Ownable {
	using SafeMath for uint256;

	IERC20 private contributionToken; // contribution token contract reference

	event Withdrawal(address indexed receiver, uint256 amount);
	event FundsWithdrawal(address indexed applicant, uint256 fundsRequested);
	event AssetWithdrawal(IERC20 assetToken, address indexed receiver, uint256 amount);
	
	// contributionToken is used to fund ventures and distribute dividends, e.g., wETH or DAI
	constructor(address contributionTokenAddress) public {
    		contributionToken = IERC20(contributionTokenAddress);
	}

    	// pairs to VentureMoloch member ragequit mechanism
	function withdraw(address receiver, uint256 amount) public onlyOwner returns (bool) {
    		emit Withdrawal(receiver, amount);
    		return contributionToken.transfer(receiver, amount);
	}
	
	// pairs to VentureMoloch member dividend claiming mechanism
	function withdrawDividend(address receiver, uint256 amount) public onlyOwner returns (bool) {
    		emit Withdrawal(receiver, amount);
    		return contributionToken.transfer(receiver, amount);
	}
    
        // pairs to VentureMoloch funding proposal mechanism. 
        // Funds are withdrawn on processProposal
	function withdrawFunds(address applicant, uint256 fundsRequested) public onlyOwner returns (bool) {
    		emit FundsWithdrawal(applicant, fundsRequested);
    		return contributionToken.transfer(applicant, fundsRequested);
	}
	
	// onlySummoner in Moloch can withdraw and administer investment tokens
	function adminWithdrawAsset(IERC20 assetToken, address receiver, uint256 amount) public onlyOwner returns(bool) {
		emit AssetWithdrawal(assetToken, receiver, amount);
		return IERC20(assetToken).transfer(receiver, amount);
	}
}

contract VentureMolochLAO { // THE LAO
	using SafeMath for uint256;

	/***************
	GLOBAL CONSTANTS
	***************/
	uint256 public periodDuration; // default = 17280 = 4.8 hours in seconds (5 periods per day)
	uint256 public votingPeriodLength; // default = 35 periods (7 days)
	uint256 public gracePeriodLength; // default = 35 periods (7 days)
	uint256 public abortWindow; // default = 5 periods (1 day)
	uint256 public dilutionBound; // default = 3 - maximum multiplier a YES voter will be obligated to pay in case of mass ragequit
	uint256 public summoningTime; // needed to determine the current period
    
	address private summoner; // Moloch summoner address reference for certain admin controls;
    
	IERC20 public contributionToken; // contribution token contract reference
	IERC20 private tributeToken; // tribute token contract reference 
	GuildBank public guildBank; // guild bank contract reference

	// HARD-CODED LIMITS
	// These numbers are quite arbitrary; they are small enough to avoid overflows when doing calculations
	// with periods or shares, yet big enough to not limit reasonable use cases.
	uint256 constant MAX_VOTING_PERIOD_LENGTH = 10**18; // maximum length of voting period
	uint256 constant MAX_GRACE_PERIOD_LENGTH = 10**18; // maximum length of grace period
	uint256 constant MAX_DILUTION_BOUND = 10**18; // maximum dilution bound
	uint256 constant MAX_NUMBER_OF_SHARES = 10**18; // maximum number of shares that can be minted

	/***************
	EVENTS
	***************/
	event SubmitProposal(
	    uint256 proposalIndex, 
	    address indexed delegateKey, 
	    address indexed memberAddress, 
	    address indexed applicant, 
	    uint256 tributeAmount, 
	    IERC20 tributeToken, 
	    uint256 sharesRequested, 
	    uint256 fundsRequested,
	    string details);
	event SubmitVote(
	    uint256 indexed proposalIndex, 
	    address indexed delegateKey, 
	    address indexed memberAddress, 
	    uint8 uintVote);
	event ProcessProposal(
	        uint256 indexed proposalIndex,
	        address indexed memberAddress, 
	        address indexed applicant, 
	        uint256 tributeAmount,
	        IERC20 tributeToken,
	        uint256 sharesRequested,
	        uint256 fundsRequested,
	        string details,
        	bool didPass);
	event Ragequit(address indexed memberAddress);
	event Abort(uint256 indexed proposalIndex, address applicantAddress);
	event UpdateDelegateKey(address indexed memberAddress, address newDelegateKey);
	event SummonComplete(address indexed summoner, uint256 shares);

	/******************
	INTERNAL ACCOUNTING
	******************/
	uint256 public totalShares = 0; // total shares across all members
	uint256 public totalSharesRequested = 0; // total shares that have been requested in unprocessed proposals
	
	// guild bank accounting in base contribution token
	uint256 public totalContributed = 0; // total member contributions to guild bank
	uint256 public totalDividends = 0; // total dividends that may be claimed by members from guild bank
	uint256 public totalWithdrawals = 0; // total member and funding withdrawals from guild bank
	
	enum Vote {
    	Null, // default value, counted as abstention
    	Yes,
    	No
	}
	
	/*
    	Add-on terms from original Moloch Code: 
		-uint256 tributeAmount,
		-uint256 lastTotalDividends
    	*/
	struct Member {
    	    address delegateKey; // the key responsible for submitting proposals and voting - defaults to member address unless updated
    	    uint256 shares; // the # of shares assigned to this member
    	    bool exists; // always true once a member has been created
    	    uint256 highestIndexYesVote; // highest proposal index # on which the member voted YES
    	    uint256 lastTotalDividends; // tally of member dividend withdrawals
	}
	
    	/*
    	Add-on terms from original Moloch Code: 
		-IERC20 tributeToken,
		-uint256 fundsRequested
    	*/
	struct Proposal {
    	    address proposer; // the member who submitted the proposal
    	    address applicant; // the applicant who wishes to become a member - this key will be used for withdrawals
    	    uint256 tributeAmount; // amount of tokens offered as tribute
    	    IERC20 tributeToken; // the tribute token reference for subscription or alternative contribution
    	    uint256 sharesRequested; // the # of shares the applicant is requesting
    	    uint256 fundsRequested; // the funds requested for applicant 
    	    string details; // proposal details - could be IPFS hash, plaintext, or JSON
    	    uint256 startingPeriod; // the period in which voting can start for this proposal
    	    uint256 yesVotes; // the total number of YES votes for this proposal
    	    uint256 noVotes; // the total number of NO votes for this proposal
    	    bool processed; // true only if the proposal has been processed
    	    bool didPass; // true only if the proposal passed
    	    bool aborted; // true only if applicant calls "abort" before end of voting period
    	    uint256 maxTotalSharesAtYesVote; // the maximum # of total shares encountered at a yes vote on this proposal
    	    mapping (address => Vote) votesByMember; // the votes on this proposal by each member
	}

	mapping (address => Member) public members;
	mapping (address => address) public memberAddressByDelegateKey;
	Proposal[] public ProposalQueue;

	/********
	MODIFIERS
	********/ 
	//onlySummoner is add-on to original Moloch Code. Allows summoner to act as administrator for guild bank.  
	modifier onlySummoner {
    	    require(msg.sender == summoner);
    	_;
	}
    
	modifier onlyMember {
    	    require(members[msg.sender].shares > 0, "Moloch::onlyMember - not a member");
    	_;
	}

	modifier onlyDelegate {
    	    require(members[memberAddressByDelegateKey[msg.sender]].shares > 0, "Moloch::onlyDelegate - not a delegate");
    	_;
	}

	/********
	FUNCTIONS
	********/
	constructor(
    	    address _summoner,
    	    address _contributionToken,
    	    uint256 _periodDuration,
    	    uint256 _votingPeriodLength,
    	    uint256 _gracePeriodLength,
    	    uint256 _abortWindow,
    	    uint256 _dilutionBound
	) public {
    	    require(_summoner != address(0), "Moloch::constructor - summoner cannot be 0");
    	    require(_contributionToken != address(0), "Moloch::constructor - _contributionToken cannot be 0");
    	    require(_periodDuration > 0, "Moloch::constructor - _periodDuration cannot be 0");
    	    require(_votingPeriodLength > 0, "Moloch::constructor - _votingPeriodLength cannot be 0");
    	    require(_votingPeriodLength <= MAX_VOTING_PERIOD_LENGTH, "Moloch::constructor - _votingPeriodLength exceeds limit");
    	    require(_gracePeriodLength <= MAX_GRACE_PERIOD_LENGTH, "Moloch::constructor - _gracePeriodLength exceeds limit");
    	    require(_abortWindow > 0, "Moloch::constructor - _abortWindow cannot be 0");
    	    require(_abortWindow <= _votingPeriodLength, "Moloch::constructor - _abortWindow must be smaller than or equal to _votingPeriodLength");
    	    require(_dilutionBound > 0, "Moloch::constructor - _dilutionBound cannot be 0");
    	    require(_dilutionBound <= MAX_DILUTION_BOUND, "Moloch::constructor - _dilutionBound exceeds limit");

    	summoner = _summoner;
    	
    	// contribution token is the base token for guild bank accounting
    	contributionToken = IERC20(_contributionToken);

    	guildBank = new GuildBank(_contributionToken);

    	periodDuration = _periodDuration;
    	votingPeriodLength = _votingPeriodLength;
    	gracePeriodLength = _gracePeriodLength;
    	abortWindow = _abortWindow;
    	dilutionBound = _dilutionBound;

    	summoningTime = now;

    	members[summoner] = Member(summoner, 1, true, 0, 0);
    	memberAddressByDelegateKey[summoner] = summoner;
    	totalShares = 1;

    	emit SummonComplete(summoner, 1);
	}

	/*****************
	PROPOSAL FUNCTIONS
	*****************/
	function submitProposal(
    	    address applicant,
    	    uint256 tributeAmount,
    	    IERC20 _tributeToken,
    	    uint256 sharesRequested,
    	    uint256 fundsRequested,
    	    string memory details
	)
    	public
    	onlyDelegate
	{
    	require(applicant != address(0), "Moloch::submitProposal - applicant cannot be 0");

    	// Make sure we won't run into overflows when doing calculations with shares.
    	// Note that totalShares + totalSharesRequested + sharesRequested is an upper bound
    	// on the number of shares that can exist until this proposal has been processed.
    	require(totalShares.add(totalSharesRequested).add(sharesRequested) <= MAX_NUMBER_OF_SHARES, "Moloch::submitProposal - too many shares requested");
    	
    	totalSharesRequested = totalSharesRequested.add(sharesRequested);

    	address memberAddress = memberAddressByDelegateKey[msg.sender];
    	
    	tributeToken = IERC20(_tributeToken);
    	
        // collect token tribute from applicant and store it in the Moloch until the proposal is processed
    	require(tributeToken.transferFrom(applicant, address(this), tributeAmount), "Moloch::submitProposal - tribute token transfer failed");
    	
    	// compute startingPeriod for proposal
    	uint256 startingPeriod = max(
            getCurrentPeriod(),
            ProposalQueue.length == 0 ? 0 : ProposalQueue[ProposalQueue.length.sub(1)].startingPeriod
    	).add(1);

    	// create proposal ...
    	Proposal memory proposal = Proposal({
            proposer: memberAddress,
            applicant: applicant,
            tributeAmount: tributeAmount,
            tributeToken: tributeToken,
            sharesRequested: sharesRequested,
            fundsRequested: fundsRequested,
            details: details,
            startingPeriod: startingPeriod,
            yesVotes: 0,
            noVotes: 0,
        	processed: false,
        	didPass: false,
        	aborted: false,
        	maxTotalSharesAtYesVote: 0
    	});

    	// ... and append it to the queue
    	ProposalQueue.push(proposal);

    	uint256 proposalIndex = ProposalQueue.length.sub(1);
    	emit SubmitProposal(
    	    proposalIndex, 
    	    msg.sender, 
    	    memberAddress, 
    	    applicant, 
    	    tributeAmount,
    	    tributeToken,
    	    sharesRequested,
    	    fundsRequested,
    	    details);
	}
    
	function submitVoteonProposal(uint256 proposalIndex, uint8 uintVote) public onlyDelegate {
    	    address memberAddress = memberAddressByDelegateKey[msg.sender];
    	    Member storage member = members[memberAddress];

    	    require(proposalIndex < ProposalQueue.length, "Moloch::submitVote - proposal does not exist");
    	    Proposal storage proposal = ProposalQueue[proposalIndex];

    	    require(uintVote < 3, "Moloch::submitVote - uintVote must be less than 3");
    	    Vote vote = Vote(uintVote);

    	    require(getCurrentPeriod() >= proposal.startingPeriod, "Moloch::submitVote - voting period has not started");
    	    require(!hasVotingPeriodExpired(proposal.startingPeriod), "Moloch::submitVote - proposal voting period has expired");
    	    require(proposal.votesByMember[memberAddress] == Vote.Null, "Moloch::submitVote - member has already voted on this proposal");
    	    require(vote == Vote.Yes || vote == Vote.No, "Moloch::submitVote - vote must be either Yes or No");
    	    require(!proposal.aborted, "Moloch::submitVote - proposal has been aborted");

    	// store vote
    	proposal.votesByMember[memberAddress] = vote;

    	// count vote
    	if (vote == Vote.Yes) {
        	proposal.yesVotes = proposal.yesVotes.add(member.shares);

        	// set highest index (latest) yes vote - must be processed for member to ragequit
        	if (proposalIndex > member.highestIndexYesVote) {
            	member.highestIndexYesVote = proposalIndex;
        	}

        	// set maximum of total shares encountered at a yes vote - used to bound dilution for yes voters
        	if (totalShares > proposal.maxTotalSharesAtYesVote) {
            	proposal.maxTotalSharesAtYesVote = totalShares;
        	}

    	} else if (vote == Vote.No) {
        	proposal.noVotes = proposal.noVotes.add(member.shares);
    	}

    	emit SubmitVote(proposalIndex, msg.sender, memberAddress, uintVote);
	}

	function processProposal(uint256 proposalIndex) public {
    	    require(proposalIndex < ProposalQueue.length, "Moloch::processProposal - proposal does not exist");
    	    Proposal storage proposal = ProposalQueue[proposalIndex];

    	    require(getCurrentPeriod() >= proposal.startingPeriod.add(votingPeriodLength).add(gracePeriodLength),"Moloch::processProposal - proposal is not ready to be processed");
    	    require(proposal.processed == false, "Moloch::processProposal - proposal has already been processed");
    	    require(proposalIndex == 0 || ProposalQueue[proposalIndex.sub(1)].processed, "Moloch::processProposal - previous proposal must be processed");

    	proposal.processed = true;
    	totalSharesRequested = totalSharesRequested.sub(proposal.sharesRequested);
    	
    	bool didPass = proposal.yesVotes > proposal.noVotes;

    	// Make the proposal fail if the dilutionBound is exceeded
    	if (totalShares.mul(dilutionBound) < proposal.maxTotalSharesAtYesVote) {
        	didPass = false;
    	}

    	// PROPOSAL PASSED
    	if (didPass && !proposal.aborted) {

        	proposal.didPass = true;

        	// if the applicant is already a member, add to their existing shares
        	if (members[proposal.applicant].exists) {
            	members[proposal.applicant].shares = members[proposal.applicant].shares.add(proposal.sharesRequested);

        	// the applicant is a new member, create a new record for them
        	} else {
            	// if the applicant address is already taken by a member's delegateKey, reset it to their member address
            	if (members[memberAddressByDelegateKey[proposal.applicant]].exists) {
                	address memberToOverride = memberAddressByDelegateKey[proposal.applicant];
                	memberAddressByDelegateKey[memberToOverride] = memberToOverride;
                	members[memberToOverride].delegateKey = memberToOverride;
            	}

            	// use applicant address as delegateKey by default
            	members[proposal.applicant] = Member(proposal.applicant, proposal.sharesRequested, true, 0, 0);
            	    if (proposal.tributeToken == contributionToken) {
            	    	members[proposal.applicant] = Member(proposal.applicant, proposal.sharesRequested, true, 0, 0);
            	}
            	memberAddressByDelegateKey[proposal.applicant] = proposal.applicant;
        	}

        	// mint new shares
        	totalShares = totalShares.add(proposal.sharesRequested);
        	
            // update total member contribution tally if tribute amount in contribution token
            if (proposal.tributeToken == contributionToken) {
        	totalContributed = totalContributed.add(proposal.tributeAmount);
            }
            
            // update total guild bank withdrawal tally to reflect requested funds disbursement 
        	totalWithdrawals = totalWithdrawals.add(proposal.fundsRequested);
        	
        	// transfer token tribute to guild bank
        	require(
            	proposal.tributeToken.transfer(address(guildBank), proposal.tributeAmount),
            	"Moloch::processProposal - token transfer to guild bank failed"
        	);
        	 
        	// instruct guild bank to transfer requested funds to applicant address
        	require(
            	guildBank.withdrawFunds(proposal.applicant, proposal.fundsRequested),
            	"Moloch::ragequit - withdrawal of tokens from guildBank failed"
        	);
       	 
    	// PROPOSAL FAILED OR ABORTED
    	} else {
        	// return all tribute tokens to the applicant
        	require(
            	proposal.tributeToken.transfer(proposal.applicant, proposal.tributeAmount),
            	"Moloch::processProposal - failing vote token transfer failed"
        	);
    	}

    	emit ProcessProposal(
        	proposalIndex,
        	proposal.proposer,
        	proposal.applicant,
        	proposal.tributeAmount,
        	proposal.tributeToken,
        	proposal.sharesRequested,
        	proposal.fundsRequested,
        	proposal.details,
        	didPass
    	);
	}
    
	function ragequit() public onlyMember {
    	    Member storage member = members[msg.sender];

    	    require(canRagequit(member.highestIndexYesVote), "Moloch::ragequit - cant ragequit until highest index proposal member voted YES on is processed");
    	
    	    // TO-DO // revise fair share withdrawalAmount with safeMath
    	    uint256 withdrawalAmount = (member.shares / totalShares) * (totalContributed + totalDividends - totalWithdrawals);

    	    // burn shares from member records and guild total
    	    totalShares = totalShares.sub(member.shares);
    	    member.shares = 0;
    	
    	    totalWithdrawals = totalWithdrawals.add(withdrawalAmount); // update total guild bank withdrawal tally to reflect raqequit amount

    	    // instruct guild bank to transfer withdrawal amount to ragequitter
    	    require(
                guildBank.withdraw(msg.sender, withdrawalAmount),
        	"Moloch::ragequit - withdrawal of tokens from guildBank failed"
    		);

    	emit Ragequit(msg.sender);
	}
	
	/*
	An applicant can cancel their proposal within Moloch voting grace period.
	Any tribute amount put up for membership and/or guild bank funding will then be returned.
	*/
	function abortProposal(uint256 proposalIndex) public {
    	     require(proposalIndex < ProposalQueue.length, "Moloch::abort - proposal does not exist");
    	     Proposal storage proposal = ProposalQueue[proposalIndex];

    	     require(msg.sender == proposal.applicant, "Moloch::abort - msg.sender must be applicant");
    	     require(getCurrentPeriod() < proposal.startingPeriod.add(abortWindow), "Moloch::abort - abort window must not have passed");
    	     require(!proposal.aborted, "Moloch::abort - proposal must not have already been aborted");

    	uint256 tokensToAbort = proposal.tributeAmount;
    	proposal.tributeAmount = 0;
    	proposal.aborted = true;

    	// return all tribute tokens to the applicant
    	require(
        	proposal.tributeToken.transfer(proposal.applicant, tokensToAbort),
        	"Moloch::abort- failed to return tribute to applicant"
    	);

    	emit Abort(proposalIndex, msg.sender);
	}

	function updateDelegateKey(address newDelegateKey) public onlyMember {
    	     require(newDelegateKey != address(0), "Moloch::updateDelegateKey - newDelegateKey cannot be 0");

    	// skip checks if member is setting the delegate key to their member address
    	if (newDelegateKey != msg.sender) {
        	require(!members[newDelegateKey].exists, "Moloch::updateDelegateKey - cant overwrite existing members");
        	require(!members[memberAddressByDelegateKey[newDelegateKey]].exists, "Moloch::updateDelegateKey - cant overwrite existing delegate keys");
    	}

    	Member storage member = members[msg.sender];
    	    memberAddressByDelegateKey[member.delegateKey] = address(0);
    	    memberAddressByDelegateKey[newDelegateKey] = msg.sender;
    	    member.delegateKey = newDelegateKey;

    	emit UpdateDelegateKey(msg.sender, newDelegateKey);
	}
	
	// Extension to original Moloch Code: allows a Member to withdraw any dividends declared by summoner admin
	function claimDividend() public onlyMember {
            Member storage member = members[msg.sender];

    	// claim fair share of declared member dividend amount
    	uint256 dividendAmount = (member.shares / totalShares) * (totalDividends - member.lastTotalDividends);
    	
    	// instruct guild bank to transfer fair share to member
    	require(
        	guildBank.withdrawDividend(msg.sender, dividendAmount),
        	"Moloch::claimDividend - withdrawal of tokens from guildBank failed"
    	);
    	
    	member.lastTotalDividends = member.lastTotalDividends.add(dividendAmount);
    	totalWithdrawals = totalWithdrawals.add(dividendAmount);
	}
	
	// Extension to original Moloch Code: Summoner admin updates total dividend amount declared for members from guild bank 
	function updateTotalDividends(uint256 newDividendAmount) onlySummoner public {
	    totalDividends = totalDividends.add(newDividendAmount);
    }

	// Extension to original Moloch Code: Summoner withdraws and administers tribute tokens (but not member contributions or dividends)
	function adminWithdrawAsset(IERC20 assetToken, address receiver, uint256 amount) onlySummoner public returns (bool)  {
	    require(assetToken != contributionToken); 
        return guildBank.adminWithdrawAsset(assetToken, receiver, amount);
    }
        
	/***************
	GETTER FUNCTIONS
	***************/
    function max(uint256 x, uint256 y) internal pure returns (uint256) {
           return x >= y ? x : y;
	}

	function getCurrentPeriod() public view returns (uint256) {
    	    return now.sub(summoningTime).div(periodDuration);
	}

	function getProposalQueueLength() public view returns (uint256) {
    	    return ProposalQueue.length;
	}
    
	// can only ragequit if the latest proposal you voted YES on has been processed
	function canRagequit(uint256 highestIndexYesVote) public view returns (bool) {
    	    require(highestIndexYesVote < ProposalQueue.length, "Moloch::canRagequit - proposal does not exist");
    	    return ProposalQueue[highestIndexYesVote].processed;
	}

	function hasVotingPeriodExpired(uint256 startingPeriod) public view returns (bool) {
    	    return getCurrentPeriod() >= startingPeriod.add(votingPeriodLength);
	}

	function getProposalVote(address memberAddress, uint256 proposalIndex) public view returns (Vote) {
    	    require(members[memberAddress].exists, "Moloch::getProposalVote - member doesn't exist");
    	    require(proposalIndex < ProposalQueue.length, "Moloch::getProposalVote - proposal doesn't exist");
    	    return ProposalQueue[proposalIndex].votesByMember[memberAddress];
	}
}
