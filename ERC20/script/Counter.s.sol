// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {BasicToken} from "../src/Erc20.sol";

contract CounterScript is Script {
    BasicToken public counter;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        counter = new BasicToken("BasicToken", "CT", 1000);

        vm.stopBroadcast();
    }
}
