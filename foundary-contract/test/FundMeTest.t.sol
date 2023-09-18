// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";

// To run tests with logs
// forge test -vv

contract FundMeTest is Test {
    FundMe fundMe;

    // This (FundMeTest) contract has created this FundMe contract
    // so the owner of it is FundMeTest
    function setUp() external {
        fundMe = new FundMe();
    }

    function testMinDollarIsFive() public {
        assertEq(fundMe.MIN_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public {
        address owner = fundMe.i_owner();
        address sender = msg.sender;

        console.log("sender", sender);

        console.log("owner", owner);
        console.log("this", address(this));

        // Otherwise msg.sender came from forge test as caller
        // assertEq(fundMe.i_owner(), msg.sender); !!

        assertEq(fundMe.i_owner(), address(this));
    }

    function testPriceFeedVersionIsAccurate() public {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }

    // function testMsgSenderShouldFund() public {
    //     // Arrange
    //     uint initialBalance = address(this).balance;
    //     uint valueToSend = 1 ether; // or any value you want to test with

    //     console.log("initialBalance", initialBalance);
    //     console.log("valueToSend", valueToSend);

    //     // Act
    //     fundMe.fund{value: valueToSend}();

    //     // Assert

    //     console.log(address(fundMe).balance, initialBalance + valueToSend);
    //     console.log(fundMe.addressToAmountFunded(address(this)), valueToSend);
    //     assertEq(valueToSend, 1000000000000000000);
    //     // assertEq(address(fundMe).balance, initialBalance + valueToSend);
    //     // assertEq(fundMe.addressToAmountFunded(address(this)), valueToSend);
    // }
}
