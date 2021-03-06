// BitwiseTests.swift
//
// This source file is part of the Swift Math open source project.
//
// Copyright (c) 2022 Logan Richards and the Swift Math project authors.
// Licensed under MIT
//
// See https://github.com/Logarithm-1/NumberTheory/blob/main/LICENSE for license information

import XCTest
@testable import BigInteger

final class BitwiseTests: XCTestCase {
    
    //MARK: - Functions
    func testAndOperationBetween(on x: UInt8, _ y: UInt8) {
        let correctValue = x & y
        
        let value = BigInteger(x) & BigInteger(y)
        XCTAssertEqual(value, BigInteger(correctValue))
        
        let uValue = BigUInteger(x) & BigUInteger(y)
        XCTAssertEqual(uValue, BigUInteger(correctValue))
    }
    
    func testOrOperationBetween(on x: UInt8, _ y: UInt8) {
        let correctValue = x | y
        
        let value = BigInteger(x) | BigInteger(y)
        XCTAssertEqual(value, BigInteger(correctValue))
        
        let uValue = BigUInteger(x) | BigUInteger(y)
        XCTAssertEqual(uValue, BigUInteger(correctValue))
    }
    
    func testXorOperationBetween(on x: UInt8, _ y: UInt8) {
        let correctValue = x ^ y
        
        let value = BigInteger(x) ^ BigInteger(y)
        XCTAssertEqual(value, BigInteger(correctValue))
        
        let uValue = BigUInteger(x) ^ BigUInteger(y)
        XCTAssertEqual(uValue, BigUInteger(correctValue))
    }
    
    func testRightOperationBetween(on x: UInt8, _ y: UInt8) {
        let correctValue = x &>> y
        
        let value = BigInteger(x) &>> BigInteger(y)
        XCTAssertEqual(value, BigInteger(correctValue))
        
        let uValue = BigUInteger(x) &>> BigUInteger(y)
        XCTAssertEqual(uValue, BigUInteger(correctValue))
    }
    
    func testLeftOperationBetween(on x: UInt8, _ y: UInt8) {
        let correctValue = x &<< y
        
        let value = BigInteger(x) &<< BigInteger(y)
        XCTAssertEqual(value, BigInteger(correctValue))
        
        let uValue = BigUInteger(x) &<< BigUInteger(y)
        XCTAssertEqual(uValue, BigUInteger(correctValue))
    }
    
    func testAndOperation() {
        testAndOperationBetween(on: 4, 5)
        testAndOperationBetween(on: 243, 32)
        testAndOperationBetween(on: 43, 23)
        testAndOperationBetween(on: 75, 3)
    }
    
    func testOrOperation() {
        testOrOperationBetween(on: 4, 5)
        testOrOperationBetween(on: 243, 32)
        testOrOperationBetween(on: 43, 23)
        testOrOperationBetween(on: 75, 3)
    }
    
    func testXorOperation() {
        testXorOperationBetween(on: 4, 5)
        testXorOperationBetween(on: 243, 32)
        testXorOperationBetween(on: 43, 23)
        testXorOperationBetween(on: 75, 3)
    }
    
    func testRightOperation() {
        testRightOperationBetween(on: 4, 5)
        testRightOperationBetween(on: 243, 5)
        testRightOperationBetween(on: 43, 23)
        testRightOperationBetween(on: 75, 3)
    }
    
    func testLeftOperation() {
        testLeftOperationBetween(on: 4, 5)
        testLeftOperationBetween(on: 51, 1)
        testLeftOperationBetween(on: 43, 2)
        testLeftOperationBetween(on: 75, 1)
    }
}
