//
//  InvocationCounterSinceInstallationTests.swift
//  Invoke
//
//  Created by Giuseppe Travasoni on 14/08/16.
//
//

import XCTest
@testable import Invoke

class InvocationCounterSinceEverTests: XCTestCase {
    
    let label1 = "label1"
    let label2 = "label2"
    
    func createInvocationCounter(userDefaultsValues: [String : AnyObject]) -> InvocationCounter {
        let userDefaults = UserDefaultsStubbed()
        userDefaults.storedData = userDefaultsValues
        return InvocationCounterSinceEver()
    }
    
    func testAllInvocationsLabelsWithNoInvocations() {
        let userDefaultsValues: [String : AnyObject] = [:]
        let invocationCounter = createInvocationCounter(userDefaultsValues: userDefaultsValues)
        XCTAssertEqual(invocationCounter.allInvocationsLabels.count, 0)
    }
    
    func testAllInvocationsLabelsAfterOneInvocation() {
        let userDefaultsValues: [String : AnyObject] = [:]
        let invocationCounter = createInvocationCounter(userDefaultsValues: userDefaultsValues)
        invocationCounter.invoked(label: label1)
        XCTAssertEqual(invocationCounter.allInvocationsLabels.count, 1)
        XCTAssert(invocationCounter.allInvocationsLabels.contains(label1))
    }
    
    func testAllInvocationsLabelsAfterMultipleInvocations() {
        let userDefaultsValues: [String : AnyObject] = [:]
        let invocationCounter = createInvocationCounter(userDefaultsValues: userDefaultsValues)
        invocationCounter.invoked(label: label1)
        invocationCounter.invoked(label: label2)
        XCTAssertEqual(invocationCounter.allInvocationsLabels.count, 2)
        XCTAssert(invocationCounter.allInvocationsLabels.contains(label1))
        XCTAssert(invocationCounter.allInvocationsLabels.contains(label2))
    }
    
    func testNumberOfInvocationsWithNoInvocations() {
        let userDefaultsValues: [String : AnyObject] = [:]
        let invocationCounter = createInvocationCounter(userDefaultsValues: userDefaultsValues)
        XCTAssertEqual(invocationCounter.numberOfInvocations(of: label1), 0)
    }
    
    func testNumberOfInvocationsAfterOneInvocation() {
        let userDefaultsValues: [String : AnyObject] = [:]
        let invocationCounter = createInvocationCounter(userDefaultsValues: userDefaultsValues)
        invocationCounter.invoked(label: label1)
        XCTAssertEqual(invocationCounter.numberOfInvocations(of: label1), 1)
    }
    
    func testNumberOfInvocationsAfterMultipleInvocation() {
        let userDefaultsValues: [String : AnyObject] = [:]
        let invocationCounter = createInvocationCounter(userDefaultsValues: userDefaultsValues)
        invocationCounter.invoked(label: label1)
        invocationCounter.invoked(label: label1)
        XCTAssertEqual(invocationCounter.numberOfInvocations(of: label1), 2)
    }
    
    func testNumberOfInvocationsAfterDifferentsInvocation() {
        let userDefaultsValues: [String : AnyObject] = [:]
        let invocationCounter = createInvocationCounter(userDefaultsValues: userDefaultsValues)
        invocationCounter.invoked(label: label1)
        invocationCounter.invoked(label: label2)
        invocationCounter.invoked(label: label1)
        invocationCounter.invoked(label: label2)
        XCTAssertEqual(invocationCounter.numberOfInvocations(of: label1), 2)
        XCTAssertEqual(invocationCounter.numberOfInvocations(of: label2), 2)
    }
    
    func testResetWithNoInvocations() {
        let userDefaultsValues: [String : AnyObject] = [:]
        let invocationCounter = createInvocationCounter(userDefaultsValues: userDefaultsValues)
        invocationCounter.reset()
        XCTAssertEqual(invocationCounter.allInvocationsLabels.count, 0)
        XCTAssertEqual(invocationCounter.numberOfInvocations(of: label1), 0)
    }
    
    func testResetAfterOneInvocation() {
        let userDefaultsValues: [String : AnyObject] = [:]
        let invocationCounter = createInvocationCounter(userDefaultsValues: userDefaultsValues)
        invocationCounter.invoked(label: label1)
        invocationCounter.reset()
        XCTAssertEqual(invocationCounter.allInvocationsLabels.count, 0)
        XCTAssertEqual(invocationCounter.numberOfInvocations(of: label1), 0)
    }
    
    func testResetAfterMultipleDifferentInvocations() {
        let userDefaultsValues: [String : AnyObject] = [:]
        let invocationCounter = createInvocationCounter(userDefaultsValues: userDefaultsValues)
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