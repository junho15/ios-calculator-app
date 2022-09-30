//
//  CalculatorItemQueueTests.swift
//  CalculatorTests
//
//  Created by junho lee on 2022/09/20.
//

import XCTest
@testable import Calculator

final class CalculatorItemQueueTests: XCTestCase {
    var sut: CalculatorItemQueue<Double>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CalculatorItemQueue()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_1_2를_enqueue하고_dequeue하면_1더하기2가_그대로나오는지() {
        // given
        let input: Array<Double> = [1, 2]
        
        // when
        input.forEach { sut.enqueue($0) }
        var result: Array<Double> = []
        for _ in 0...1 {
            result.append(sut.dequeue()!)
        }
        
        // then
        XCTAssertEqual(result, input)
    }
    
    func test_queue에_enqueue한거보다_더dequeue하면_nil을반환하는지() {
        // given
        let input: Double = 1
        
        // when
        sut.enqueue(input)
        sut.dequeue()
        let result: Double? = sut.dequeue()
        
        // then
        XCTAssertNil(result)
    }
}
