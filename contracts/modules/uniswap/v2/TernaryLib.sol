// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity >=0.5.0;

/// @title Library for replacing ternary operator with efficient bitwise operations
library TernaryLib {
    /// @notice Equivalent to the ternary operator: `condition ? a : b`
    function ternary(bool condition, uint256 a, uint256 b) internal pure returns (uint256 res) {
        assembly {
            res := xor(b, mul(xor(a, b), condition))
        }
    }

    /// @notice Sorts two uint256 in ascending order
    /// @dev Equivalent to: `a < b ? (a, b) : (b, a)`
    function sort2(uint256 a, uint256 b) internal pure returns (uint256, uint256) {
        return swapIf(b < a, a, b);
    }

    /// @notice Sorts two tokens to return token0 and token1
    /// @param tokenA The first token to sort
    /// @param tokenB The other token to sort
    /// @return token0 The smaller token by address value
    /// @return token1 The larger token by address value
    function sortTokens(address tokenA, address tokenB) internal pure returns (address token0, address token1) {
        assembly {
            let diff := mul(xor(tokenA, tokenB), lt(tokenB, tokenA))
            token0 := xor(tokenA, diff)
            token1 := xor(tokenB, diff)
        }
    }

    /// @notice Swaps two uint256 if `condition` is true
    /// @dev Equivalent to: `condition ? (b, a) : (a, b)`
    function swapIf(bool condition, uint256 a, uint256 b) internal pure returns (uint256, uint256) {
        assembly {
            let diff := mul(xor(a, b), condition)
            a := xor(a, diff)
            b := xor(b, diff)
        }
        return (a, b);
    }
}
