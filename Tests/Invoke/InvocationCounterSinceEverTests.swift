//
//  InvocationCounterSinceEverTests.swift
//  Invoke
//
//  Created by Gruppioni Michele on 14/08/16.
//
//

import XCTest
@testable import Invoke
/*
class InvocationCounterSinceEverTests: XCTestCase {
    
    let label1 = "label1"
    let label2 = "label2"
    
    func createInvocationCounter() -> InvocationCounter {
        return InvocationCounterSinceEver()!
    }
    
    func testAllInvocationsLabelsWithNoInvocations() {
        let invocationCounter = createInvocationCounter()
        XCTAssertEqual(invocationCounter.allInvocationsLabels.count, 0)
    }
    
    func testAllInvocationsLabelsAfterOneInvocation() {
        var invocationCounter = createInvocationCounter()
        invocationCounter.invoked(label: label1)
        XCTAssertEqual(invocationCounter.allInvocationsLabels.count, 1)
        XCTAssertEqual(invocationCounter.allInvocationsLabels.first!, label1)
    }
    
    func testAllInvocationsLabelsAfterMultipleInvocations() {
        var invocationCounter = createInvocationCounter()
        invocationCounter.invoked(label: label1)
        invocationCounter.invoked(label: label2)
        XCTAssertEqual(invocationCounter.allInvocationsLabels.count, 2)
        XCTAssert(invocationCounter.allInvocationsLabels.contains(label1))
        XCTAssert(invocationCounter.allInvocationsLabels.contains(label2))
    }
    
    func testNumberOfInvocationsWithNoInvocations() {
        let invocationCounter = createInvocationCounter()
        XCTAssertEqual(invocationCounter.numberOfInvocations(of: label1), 0)
    }
    
    func testNumberOfInvocationsAfterOneInvocation() {
        var invocationCounter = createInvocationCounter()
        invocationCounter.invoked(label: label1)
        XCTAssertEqual(invocationCounter.numberOfInvocations(of: label1), 1)
    }
    
    func testNumberOfInvocationsAfterMultipleInvocation() {
        var invocationCounter = createInvocationCounter()
        invocationCounter.invoked(label: label1)
        invocationCounter.invoked(label: label1)
        XCTAssertEqual(invocationCounter.numberOfInvocations(of: label1), 2)
    }
    
    func testNumberOfInvocationsAfterDifferentsInvocation() {
        var invocationCounter = createInvocationCounter()
        invocationCounter.invoked(label: label1)
        invocationCounter.invoked(label: label2)
        invocationCounter.invoked(label: label1)
        invocationCounter.invoked(label: label2)
        XCTAssertEqual(invocationCounter.numberOfInvocations(of: label1), 2)
        XCTAssertEqual(invocationCounter.numberOfInvocations(of: label2), 2)
    }
    
    func testResetWithNoInvocations() {
        var invocationCounter = createInvocationCounter()
        invocationCounter.reset()
        XCTAssertEqual(invocationCounter.allInvocationsLabels.count, 0)
        XCTAssertEqual(invocationCounter.numberOfInvocations(of: label1), 0)
    }
    
    func testResetAfterOneInvocation() {
        var invocationCounter = createInvocationCounter()
        invocationCounter.invoked(label: label1)
        invocationCounter.reset()
        XCTAssertEqual(invocationCounter.allInvocationsLabels.count, 0)
        XCTAssertEqual(invocationCounter.numberOfInvocations(of: label1), 0)
    }
    
    func testResetAfterMultipleDifferentInvocations() {
        var invocationCounter = createInvocationCounter()
        invocationCounter.invoked(label: label1)
        invocationCounter.invoked(label: label2)
        invocationCounter.invoked(label: label1)
        invocationCounter.invoked(label: label2)
        invocationCounter.reset()
        XCTAssertEqual(invocationCounter.allInvocationsLabels.count, 0)
        XCTAssertEqual(invocationCounter.numberOfInvocations(of: label1), 0)
        XCTAssertEqual(invocationCounter.numberOfInvocations(of: label2), 0)
    }
    
}
*/
