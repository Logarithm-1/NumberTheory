// BigInteger+Integer.swift
//
// This source file is part of the Swift Math open source project.
//
// Copyright (c) 2022 Logan Richards and the Swift Math project authors.
// Licensed under MIT
//
// See https://github.com/Logarithm-1/MATH/blob/main/LICENSE for license information

//MARK: - BinaryInteger
//Conform BigInteger to BinaryInteger

extension BigInteger {    
    
    public typealias Word = Bool
    
    public struct Words: RandomAccessCollection {
        private let value: BigInteger
        
        init(_ value: BigInteger) {
            self.value = value
        }
        
        public var startIndex: Int {
            return 0
        }
        
        public var endIndex: Int {
            return value.source.count
        }
        
        public subscript(_ index: Int) -> Word {
            return value[index]
        }
    }
    
    public var words: Words {
        return Words(self)
    }
}

//MARK: - SignedInteger
//Conform BigInteger to SignedInteger
