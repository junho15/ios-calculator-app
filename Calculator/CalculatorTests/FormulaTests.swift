//
//  FormulaTests.swift
//  CalculatorTests
//
//  Created by junho lee on 2022/09/23.
//

import XCTest
@testable import Calculator

final class FormulaTests: XCTestCase {
    var sut: Formula!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Formula()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func test_operands와operators각각에_1과2와_더하기를_enque하면_result에서3을반환하는지() {
        // given
        sut.operands.enqueue(1)
        sut.operands.enqueue(2)
        sut.operators.enqueue(.add)
        
        // when
        let result: Double = sut.result()!
        
        // then
        XCTAssertEqual(result, 3)
    }
    
    func test_operands와operators각각에_2와3과2_곱하기와빼기를_enque하면_4를반환하는지() {
        // given
        sut.operands.enqueue(2)
        sut.operands.enqueue(3)
        sut.operands.enqueue(2)
        sut.operators.enqueue(.multiply)
        sut.operators.enqueue(.subtract)
        
        // when
        let result: Double = sut.result()!
        
        // then
        XCTAssertEqual(result, 4)
    }
    
    func test_operands와operators각각에_1과0_나누기를_enque하면_nil을반환하는지() {
        // given
        sut.operands.enqueue(1)
        sut.operands.enqueue(0)
        sut.operators.enqueue(.divide)
        
        // when
        let result: Double? = sut.result()
        
        // then
        XCTAssertNil(result)
    }
    
    func test_operands와operators가_빈상태이면_nil을반환하는지() {
        // given
        
        // when
        let result: Double? = sut.result()
        
        // then
        XCTAssertNil(result)
    }
}
