// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

///@title Contract Conqueror ERC20 STandard 

contract BasicToken {
    /// @notice Token details
    string public name;
    string public symbol;
    uint8 public decimals = 18;

    uint256 private _totalSupply;
    uint256 private immutable _cap;
    address public owner;
    bool public paused = false;
    

    /// @dev Balances and allowances
    mapping(address => uint256) private _balances;
    mapping (address => mapping(address => uint256)) private _allowance;

    // @dev Timestamp when each account's tokens unlock

    /// @notice Events for tracking state changes
    event Transfer(address indexed from, address indexed to , uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /// @notice Events for tracking state changes

    /// @dev Restrict function to only the owner
    modifier onlyOwner(){
        require(msg.sender == owner, "Not owner");
        _;
    }

    /// @dev Restrict function if contract is paused

    /// @dev Restrict function if address is time-locked

    /// @notice Constructor to initialize name, symbol, cap, and initial supply
    // / @param _name Token name
    // / @param _symbol Token symbol
    // / @param initialSupply Initial mint amount (in whole tokens)
    // / @param maxCap Maximum supply cap (in whole tokens)
    constructor(string memory _name, string memory _symbol,uint256 initialSupply){
        name = _name;
        symbol = _symbol;
        owner = msg.sender;
        _mint(owner,initialSupply * (10 ** uint256(decimals)));
    }

    /// @notice Transfer tokens from sender to recipient

    
    /// @notice Check balance of a specific address
    function balanceOf(address account) external view returns (uint256) {
        return  _balances[account];
    }

    /// @notice Pause token transfers and actions

    /// @notice Unpause token transfers and actions

    /// @notice Lock an address's tokens until a future time
    /// @param user The address to lock
    /// @param unlockTime The UNIX timestamp until which the address is locked    

    /// @notice Get the unlock timestamp for a user

    /// @notice Mint new tokens (only owner, capped)
    /// @param to The address to receive minted tokens
    /// @param amount The amount to mint (in whole tokens)
    

    /// @notice Burn tokens from caller's balance
    /// @param amount Amount to burn (in smallest unit)

    /// @notice Burn tokens from another account with approval
    /// @param account Address to burn from
    /// @param amount Amount to burn (in smallest unit)

    /// @notice Transfer tokens
    function transfer(address to, uint256 amount) external returns(bool) {
        _transfer(msg.sender, to, amount);
        return true;
        }
    /// @notice Approve a spender
    function approve(address spender, uint256 amount) external returns(bool){
        _approve(msg.sender, spender,  amount);
        return true;
    }
    /// @notice Transfer tokens using allowance
    function transferFrom(address from, address to, uint256 amount) external returns(bool){
        require(_allowance[from][msg.sender]>= amount, "insufficient balance");
        _allowance[from][msg.sender] -= amount;
        _transfer(from, to, amount);
        return true;
    }

    /// @notice Get max token cap
    /// @notice Get total token supply
    function totalsupply() external view returns (uint256){
        return _totalSupply;
    }
    /// @notice Get balance of an address
    /// @notice Get allowance from owner to spender
    function allowance(address tokenOwner, address spender) external view returns(uint256){
        return _allowance[tokenOwner][spender];
    }
    /// @dev Internal mint function (only callable in constructor here)
    function _mint(address to, uint256 amount) internal{
        require(to != address(0),"Invalid address");
        _totalSupply += amount;
        _balances[to] += amount;

        emit Transfer(address(0), to, amount);
    }
    /// @dev Internal burn function
    /// @dev Internal transfer function
    function _transfer(address from, address to, uint256 amount) internal {
        require(to != address(0), "Invalid address");
        require(from != address(0),"Invalid address" );
        require(_balances[from] >= amount," Insufficient balance");
        
        _balances[from] -= amount;
        _balances[to] = amount;
        emit Transfer(from, to, amount);
    }
    /// @dev Internal approve function
    function _approve(address tokenOwner, address spender, uint256 amount)internal{
        require(tokenOwner != address(0), "ERC20: approve from 0x0");
        require(spender != address(0), "ERC20: approve to 0x0");

        _allowance[tokenOwner][spender] = amount;
        emit Approval(tokenOwner, spender, amount);

    }

}