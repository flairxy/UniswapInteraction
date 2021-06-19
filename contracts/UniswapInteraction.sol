// "SPDX-License-Identifier: UNLICENSED"
pragma solidity >=0.7.0;

interface IUniswap {
    function swapExactTokensForETH(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function WETH() external pure returns (address);
}

interface IERC20 {
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    function approve(address spender, uint256 amount) external returns (bool);
}

contract UniswapInteraction {
    IUniswap uniswap; //uniswap pointer

    constructor(address _uniswap) {
        uniswap = IUniswap(_uniswap);
    }

    function swapTOkensForEth(
        address token,
        uint256 amountIn,
        uint256 amountOutMin,
        uint256 deadline
    ) external {
        IERC20(token).transferFrom(msg.sender, address(this), amountIn);
        address[] memory path = new address[](2);
        path[0] = token;
        path[1] = uniswap.WETH(); //returns the address of WETH
        IERC20(token).approve(address(uniswap), amountIn);
        uniswap.swapExactTokensForETH(
            amountIn,
            amountOutMin,
            path,
            msg.sender,
            deadline
        );
    }
}
