// SPDX-License-Identifier: Unlicensed
pragma solidity 0.8.18;
interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}
abstract contract Ownable is Context {
    address private _owner;
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    constructor() {
        _transferOwnership(_msgSender());
    }
    modifier onlyOwner() {
        _checkOwner();
        _;
    }
    function owner() public view virtual returns (address) {
        return _owner;
    }
    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}
library SafeMath {
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}
interface IUniswapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);
    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}
interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);
    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}
interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);
    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);
    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);
    function createPair(address tokenA, address tokenB) external returns (address pair);
    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}
contract WagieCoin is IERC20, Ownable {
    using SafeMath for uint256;
    
    string public name = "Wagie Coin";
    string public symbol = "WAGIE";
    uint8 public decimals = 18;
    uint256 public totalSupply = 100_000_000 ether; 
    uint256 public marketingTaxRate = 5; 
    uint256 public liquidityTaxRate = 3; 
    uint256 public reflectionTaxRate = 2; 
    uint256 public rewardsTaxRate = 1; 
    address public marketingWallet = 0xfee24F75A42AFeBCDEF7bf84E1132dB3D909aEE6;
    address public liquidityWallet;
    address public rewardsWallet;
    address public ownerWallet = 0xb6C138aeb9A5e976669C3411d444466b0259F4aD;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    uint256 public minBuyTaxRate; // Hardcoded to 0.1%
    uint256 public maxBuyTaxRate; // 10%
    uint256 public minSellTaxRate = 1; // Hardcoded to 0.1%
    uint256 public maxSellTaxRate = 100; // 10%
    uint256 public maxSellPercent = 100; // Maximum percentage of tokens that can be sold in a single transaction
    bool public tradingEnabled;
    mapping(address => bool) public whitelist;
    uint256 public maxWalletTokens;
    uint256 public maxBuyTokens;
    uint256 public maxSellTokens;
    mapping(address => bool) public excludeFromTxLimits;
    mapping(address => bool) public excludeFromFees;
    mapping(address => bool) public excludeFromRewards;
    mapping(address => bool) public excludeFromMaxWallet;
    mapping(address => bool) public excludeFromReflections;
    address public targetLiquidityWallet;
    bool public walletTransferFeeEnabled;
    uint256 public swapThreshold;
    bool public tradingPaused;
    IUniswapV2Router02 public uniswapRouter;
    address public uniswapPair;

    constructor(address _uniswapRouterAddress) {
        uniswapRouter = IUniswapV2Router02(_uniswapRouterAddress);
        uniswapPair = IUniswapV2Factory(uniswapRouter.factory()).getPair(address(this), uniswapRouter.WETH());
    }

    function balanceOf(address account) external view override returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) external override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) external view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) external override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) external override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()] - amount);
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) external returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender] + addedValue);
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) external returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender] - subtractedValue);
        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "Transfer from the zero address");
        require(recipient != address(0), "Transfer to the zero address");
        require(_balances[sender] >= amount, "Insufficient balance");

        if (sender != owner() && recipient != owner()) {
            require(!tradingPaused, "Trading is paused");
            require(whitelist[sender] || whitelist[recipient], "Sender or recipient is not whitelisted");
            require(!_isExcludedFromTxLimits(sender), "Sender is excluded from transaction limits");
            require(!_isExcludedFromTxLimits(recipient), "Recipient is excluded from transaction limits");

            // Check if it's a sell transaction
            if (sender != owner() && recipient == uniswapPair) {
                uint256 maxSellAmount = maxWalletTokens.mul(maxSellPercent).div(100);
                require(amount <= maxSellAmount, "Amount exceeds max sell limit");
            }

            uint256 marketingTax = amount.mul(marketingTaxRate).div(100);
            uint256 liquidityTax = amount.mul(liquidityTaxRate).div(100);
            uint256 reflectionTax = amount.mul(reflectionTaxRate).div(100);
            uint256 rewardsTax = amount.mul(rewardsTaxRate).div(100);
            uint256 netAmount = amount.sub(marketingTax).sub(liquidityTax).sub(reflectionTax).sub(rewardsTax);

            _balances[sender] = _balances[sender].sub(amount);
            _balances[recipient] = _balances[recipient].add(netAmount);
            _balances[marketingWallet] = _balances[marketingWallet].add(marketingTax);
            _balances[liquidityWallet] = _balances[liquidityWallet].add(liquidityTax);
            _balances[rewardsWallet] = _balances[rewardsWallet].add(rewardsTax);

            emit Transfer(sender, recipient, netAmount);
            emit Transfer(sender, marketingWallet, marketingTax);
            emit Transfer(sender, liquidityWallet, liquidityTax);
            emit Transfer(sender, rewardsWallet, rewardsTax);
        } else {
            _balances[sender] = _balances[sender].sub(amount);
            _balances[recipient] = _balances[recipient].add(amount);
            emit Transfer(sender, recipient, amount);
        }
    }

    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "Approve from the zero address");
        require(spender != address(0), "Approve to the zero address");
        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _isExcludedFromTxLimits(address account) internal view returns (bool) {
        return excludeFromTxLimits[account];
    }

    function setTargetLiquidityWallet(address _wallet) external onlyOwner {
        targetLiquidityWallet = _wallet;
    }

    function changeMarketingWallet(address newMarketingWallet) external onlyOwner {
        require(newMarketingWallet != address(0), "Invalid marketing wallet address");
        marketingWallet = newMarketingWallet;
    }

    function setMaxSellTaxRate(uint256 _maxSellTaxRate) external onlyOwner {
    require(_maxSellTaxRate >= minSellTaxRate, "Max sell tax rate cannot be less than min sell tax rate");
    maxSellTaxRate = _maxSellTaxRate;
    }

    function enableTrading() external onlyOwner {
        tradingEnabled = true;
    }
    function addToWhitelist(address _address) external onlyOwner {
        whitelist[_address] = true;
    }
    function setMaxWalletTokens(uint256 _maxTokens) external onlyOwner {
        maxWalletTokens = _maxTokens;
    }

    function setMaxSellTokens(uint256 _maxTokens) external onlyOwner {
        maxSellTokens = _maxTokens;
    }
    function excludeFromTransactionLimits(address _address) external onlyOwner {
        excludeFromTxLimits[_address] = true;
    }

    function setBuyTaxRates(uint256 _marketingTaxRate, uint256 _liquidityTaxRate, uint256 _reflectionTaxRate, uint256 _rewardsTaxRate) external onlyOwner {
        require(_marketingTaxRate + _liquidityTaxRate + _reflectionTaxRate + _rewardsTaxRate <= 100, "Tax rates exceed 100%");
        marketingTaxRate = _marketingTaxRate;
        liquidityTaxRate = _liquidityTaxRate;
        reflectionTaxRate = _reflectionTaxRate;
        rewardsTaxRate = _rewardsTaxRate;
    }
    function setSellTaxRates(uint256 _marketingTaxRate, uint256 _liquidityTaxRate, uint256 _reflectionTaxRate, uint256 _rewardsTaxRate) external onlyOwner {
        require(_marketingTaxRate + _liquidityTaxRate + _reflectionTaxRate + _rewardsTaxRate <= 100, "Tax rates exceed 100%");
        marketingTaxRate = _marketingTaxRate;
        liquidityTaxRate = _liquidityTaxRate;
        reflectionTaxRate = _reflectionTaxRate;
        rewardsTaxRate = _rewardsTaxRate;
    }
    function setSwapThreshold(uint256 _swapThreshold) external onlyOwner {
        swapThreshold = _swapThreshold;
    }
    function enableWalletTransferFee() external onlyOwner {
        walletTransferFeeEnabled = true;
    }
    function disableWalletTransferFee() external onlyOwner {
        walletTransferFeeEnabled = false;
    }
    function recoverTokens(address tokenAddress, uint256 tokenAmount) external onlyOwner {
        require(tokenAddress != address(this), "Cannot recover contract's own tokens");
        if (tokenAddress == address(0)) {
            payable(owner()).transfer(tokenAmount);
        } else {
            IERC20(tokenAddress).transfer(owner(), tokenAmount);
        }
    }

function swapTokensForEth(uint256 tokenAmount) public {
    require(tradingEnabled, "Trading is not enabled yet"); // Add any necessary checks
    
    address[] memory path = new address[](2);
    path[0] = address(this);
    path[1] = uniswapRouter.WETH(); // Use the router instance here
    
    // Approve the Uniswap Router to spend tokens on behalf of the contract
    _approve(address(this), address(uniswapRouter), tokenAmount);
    
    // Perform the token-to-ETH swap
    uniswapRouter.swapExactTokensForETHSupportingFeeOnTransferTokens(
        tokenAmount,
        0,
        path,
        address(this), // Send ETH to this contract
        block.timestamp
    );
}



    function excludeFromFee(address _address) external onlyOwner {
        excludeFromFees[_address] = true;
    }

    function excludeFromReward(address _address) external onlyOwner {
        excludeFromRewards[_address] = true;
    }

    function excludeFromReflection(address _address) external onlyOwner {
        excludeFromReflections[_address] = true;
    }
}
