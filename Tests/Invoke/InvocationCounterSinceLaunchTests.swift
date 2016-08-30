//
//  InvocationCounterSinceLaunchTests.swift
//  Invoke
//
//  Created by Gruppioni Michele on 14/08/16.
//
//

import XCTest
@testable import Invoke

class InvocationCounterSinceLaunchTests: XCTestCase {
    
    let label1 = "label1"
    let label2 = "label2"
    
    func createInvocationCounter() -> InvocationCounter {
        return InvocationCounterSinceLaunch()
    }
    
    func testAllInvocationsLabelsWithNoInvocations() {
        let invocationCounter = createInvocationCounter()
        XCTAssertEqual(invocationCounter.allInvocationsLabels.count, 0)
    }
    
    func testAllInvocationsLabelsAfterOneInvocation() {
        let invocationCounter = createInvocationCounter()
        invocationCounter.invoked(label: label1)
        XCTAssertEqual(invocationCounter.allInvocationsLabels.count, 1)
        XCTAssert(invocationCounter.allInvocationsLabels.contains(label1))
    }
    
    func testAllInvocationsLabelsAfterMultipleInvocations() {
        let invocationCounter = createInvocationCounter()
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
        let invocationCounter = createInvocationCounter()
        invocationCounter.invoked(label: label1)
        XCTAssertEqual(invocationCounter.numberOfInvocations(of: label1), 1)
    }
    
    func testNumberOfInvocationsAfterMultipleInvocation() {
        let invocationCounter = createInvocationCounter()
        invocationCounter.invoked(label: label1)
        invocationCounter.invoked(label: label1)
        XCTAssertEqual(invocationCounter.numberOfInvocations(of: label1), 2)
    }
    
    func testNumberOfInvocationsAfterDifferentsInvocation() {
        let invocationCounter = createInvocationCounter()
        invocationCounter.invoked(label: label1)
        invocationCounter.invoked(label: label2)
        invocationCounter.invoked(label: label1)
        invocationCounter.invoked(label: label2)
        XCTAssertEqual(invocationCounter.numberOfInvocations(of: label1), 2)
        XCTAssertEqual(invocationCounter.numberOfInvocations(of: label2), 2)
    }
    
    func testResetWithNoInvocations() {
        let invocationCounter = createInvocationCounter()
        invocationCounter.resetAll()
        XCTAssertEqual(invocationCounter.allInvocationsLabels.count, 0)
        XCTAssertEqual(invocationCounter.numberOfInvocations(of: label1), 0)
    }
    
    func testResetAfterOneInvocation() {
        let invocationCounter = createInvocationCounter()
        invocationCounter.invoked(label: label1)
        invocationCounter.resetAll()
        XCTAssertEqual(invocationCounter.allInvocationsLabels.count, 0)
        XCTAssertEqual(invocationCounter.numberOfInvocations(of: label1), 0)
    }
    
    func testResetAfterMultipleDifferentInvocations() {
        let invocationCounter = createInvocationCounter()
        invocationCounter.invoked(label: label1)
        invocationCounter.invoked(label: label2)
        invocationCounter.invoked(label: label1)
        invocationCounter.invoked(label: label2)
        invocationCounter.resetAll()
        XCTAssertEqual(invocationCounter.allInvocationsLabels.count, 0)
        XCTAssertEqual(invocationCounter.numberOfInvocations(of: label1), 0)
        XCTAssertEqual(invocationCounter.numberOfInvocations(of: label2), 0)
    }
    
    func testUntilStopSinceLaunch() {
        var invocationCounter = 0
        let untilStop = Invoke.untilStopSinceLaunch(label: label1) {
            invocationCounter += 1
        }
        untilStop.start()
        untilStop.start()
        XCTAssertEqual(invocationCounter, 2)
        untilStop.stop()
        untilStop.start()
        XCTAssertEqual(invocationCounter, 2)
    }
    
}
