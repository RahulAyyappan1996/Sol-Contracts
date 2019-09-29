pragma solidity ^0.5.0;


contract Math {

    uint num1;

    uint num2;


    function getAdd (uint _num1, uint _num2) public view returns (uint) {

       uint num3 = _num1 + _num2;

        return num3;

    }

    function getDiff (uint _num1, uint _num2) public view returns (uint) {

       uint num4 = _num1 - _num2;

        return num4;

    }

    function getMul (uint _num1, uint _num2) public view returns (uint) {

       uint num5 = _num1 * _num2;

        return num5;

    }

    function getDiv (uint _num1, uint _num2) public view returns (uint) {

       uint num6 = _num1 / _num2;

        return num6;

    }

}