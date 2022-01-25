// BigUInteger+Arithmetic.swift
//
// This source file is part of the Swift Math open source project.
//
// Copyright (c) 2022 Logan Richards and the Swift Math project authors.
// Licensed under MIT
//
// See https://github.com/Logarithm-1/MATH/blob/main/LICENSE for license information

extension BigUInteger: AdditiveArithmetic {
    public static var zero: BigUInteger {
        return BigUInteger()
    }
    
    //MARK: - Addition
    /// Adds two values and produces their sum.
    ///
    /// The addition operator (`+`) calculates the sum of its two arguments. For example:
    ///
    ///     1 + 2                   // 3
    ///     -10 + 15                // 5
    ///     -15 + -5                // -20
    ///
    /// - Parameters:
    ///   - lhs: The first value to add.
    ///   - rhs: The second value to add.
    /// - Returns: The sum of two values, `lhs` and `rhs`
    public static func +(lhs: BigUInteger, rhs: BigUInteger) -> BigUInteger {
        //If lhs and rhs have the same sign (are both positive or both negative) add like normal and keep the sign
        let and: BigUInteger = (lhs & rhs) &<< 1
        let xor: BigUInteger = lhs ^ rhs
        
        if(and == 0) {
            return xor
        }
        
        return and + xor
    }
    
    /// Adds two values and stores the result in the left-hand-side variable.
    ///
    /// The sum of the two arguments must be representable in the arguments' type.
    ///
    /// - Parameters:
    ///   - lhs: The first value to add.
    ///   - rhs: The second value to add.
    public static func +=(lhs: inout BigUInteger, rhs: BigUInteger) {
        lhs = lhs + rhs
    }
    
    //MARK: - Subtraction
    /// Subtracts one value from another and produces their difference.
    ///
    /// The subtraction operator (`-`) calculates the difference of its two arguments. For example:
    ///
    ///     8 - 3                   // 5
    ///     -10 - 5                 // -15
    ///     100 - -5                // 105
    ///
    /// - Parameters:
    ///   - lhs: A numeric value.
    ///   - rhs: The value to subtract from `lhs`.
    public static func -(lhs: BigUInteger, rhs: BigUInteger) -> BigUInteger {
        if(rhs == 0) {
            return lhs
        }
        

        if(lhs >= rhs) {
            //Get the borrow bits
            let borrow = (~lhs) & rhs
            
            //Get the difference between left and right
            let left = lhs ^ rhs
            
            //Shift borrow to the left by 1
            let right = borrow &<< 1
            
            return left - right
        } else { //lhs < rhs
            return 0
        }
    }
    
    /// Subtracts the second value from the first and stores the difference in the left-hand-side variable.
    ///
    /// - Parameters:
    ///   - lhs: A numeric value.
    ///   - rhs: The value to subtract from `lhs`.
    public static func -=(lhs: inout BigUInteger, rhs: BigUInteger) {
        lhs = lhs - rhs
    }
}

extension BigUInteger {
    //MARK: - Multiplication
    /// Multiplies two values and produces their product.
    ///
    /// The multiplication operator (`*`) calculates the product of its two
    /// arguments. For example:
    ///
    ///     2 * 3                   // 6
    ///     100 * 21                // 2100
    ///     -10 * 15                // -150
    ///
    /// - Parameters:
    ///   - lhs: The first value to multiply.
    ///   - rhs: The second value to multiply.
    ///
    /// - Note: This function is a requirement of the protocol ``Numeric``
    public static func *(lhs: BigUInteger, rhs: BigUInteger) -> BigUInteger {
        // 1101 * 0011
        // (1101*1) + (1101*10)
        // (1101 &<< 0) + (1101 &<< 1)
        // (1101) + (11010)
        // (100111)
        var product: BigUInteger = 0
        
        for i in 0..<rhs.bitWidth {
            if(rhs[i]) {
                product += lhs &<< BigUInteger(UInt(i))
            }
        }
        
        return product
    }
    
    /// Multiplies two values and stores the result in the left-hand-side variable.
    ///
    /// - Parameters:
    ///   - lhs: The first value to multiply.
    ///   - rhs: The second value to multiply.
    ///
    /// - Note: This function is a requirement of the protocol ``Numeric``
    public static func *=(lhs: inout BigUInteger, rhs: BigUInteger) {
        lhs = lhs * rhs
    }
    
    //MARK: - Division
    /// Returns the quotient of dividing the first value by the second.
    ///
    /// For integer types, any remainder of the division is discarded.
    ///
    ///     let x = 21 / 5
    ///     // x == 4
    ///
    /// - Parameters:
    ///   - lhs: The value to divide.
    ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
    public static func /(lhs: BigUInteger, rhs: BigUInteger) -> BigUInteger {
        return lhs.divided(by: rhs).quotient
    }
    
    /// Divides the first value by the second and stores the quotient in the
    /// left-hand-side variable.
    ///
    /// - Parameters:
    ///   - lhs: The value to divide.
    ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
    public static func /=(lhs: inout BigUInteger, rhs: BigUInteger) {
        lhs = lhs / rhs
    }
    
    //MARK: - Modulus
    /// Returns the remainder of dividing the first value by the second.
    ///
    /// The result of the remainder operator (`%`) has the same sign as `lhs` and
    /// has a magnitude less than `rhs.magnitude`.
    ///
    ///     let x = 22 % 5
    ///     // x == 2
    ///     let y = 22 % -5
    ///     // y == 2
    ///     let z = -22 % -5
    ///     // z == -2
    ///
    /// For any two integers `a` and `b`, their quotient `q`, and their remainder
    /// `r`, `a == b * q + r`.
    ///
    /// - Parameters:
    ///   - lhs: The value to divide.
    ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
    public static func %(lhs: BigUInteger, rhs: BigUInteger) -> BigUInteger {
        return lhs.divided(by: rhs).remainder
    }
    
    /// Divides the first value by the second and stores the remainder in the
    /// left-hand-side variable.
    ///
    /// The result has the same sign as `lhs` and has a magnitude less than
    /// `rhs.magnitude`.
    ///
    ///     var x = 22
    ///     x %= 5
    ///     // x == 2
    ///
    ///     var y = 22
    ///     y %= -5
    ///     // y == 2
    ///
    ///     var z = -22
    ///     z %= -5
    ///     // z == -2
    ///
    /// - Parameters:
    ///   - lhs: The value to divide.
    ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
    public static func %= (lhs: inout BigUInteger, rhs: BigUInteger) {
        lhs = lhs % rhs
    }
    
    internal func divided(by rhs: BigUInteger) -> (quotient: BigUInteger, remainder: BigUInteger) {
        if(rhs == 0) {
            fatalError("Can't divide by zero")
        }
        
        // dividend / divisor = quotient R remainder
        let dividend: BigUInteger = self //FIXME: .magnitude
        let divisor: BigUInteger = rhs //FIXME: .magnitude
        
        var partialDividend: BigUInteger = 1
        var index: Int = dividend.bitWidth - 1 //First bit from left to right
        
        var result: BigUInteger = 0
        
        while(index >= 0) {
            //Increase partialDividend until it is bigger than divisor.
            if(partialDividend < divisor) {
                //Move partial Dividend over one to the left
                partialDividend &<<= 1
                //Move index to the right one
                index -= 1
                //Add in the next dividend bit (at index)
                partialDividend[0] = dividend[index]
                continue
            }
            
            if(partialDividend >= divisor) {
                partialDividend -= divisor
                result += BigUInteger(1) &<< BigUInteger(UInt(index))
                
                continue
            }
        }
        
        //Since index is now -1 (It goes through the while one more time) partialDividend is not moved to the left 1. So to get remainder we must move it back 1 to the right.
        partialDividend &>>= 1
        
        return (quotient: result, remainder: partialDividend)
    }
}


precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ^^ : PowerPrecedence
extension BigUInteger {
    //MARK: - Power
    public static func ^^(lhs: BigUInteger, rhs: BigUInteger) -> BigUInteger {
        var result: BigUInteger = 1
        
        //TODO: Remove toInt()
        for _ in 0..<rhs {
            result *= lhs
        }
        
        return result
    }
}