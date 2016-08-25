//
//  InvokeOncePerAppLaunchTests.swift
//  Invoke
//
//  Created by Gruppioni Michele on 14/08/16.
//
//

import XCTest
@testable import Invoke

class InvokeOnceEveryLaunchTests: XCTestCase {
    
    let queueName = "custom.queue"
    
    override func setUp() {
        super.setUp()
        Invoke.reset()
    }
    
    func testSingleInvocation() {
        
        var numberOfInvocations = 0
        Invoke.onceEveryLaunch(label: "invocation1", handler: {
            numberOfInvocations += 1
        })()
        
        XCTAssertEqual(numberOfInvocations, 1)
    }
    
    func testSingleAsyncInvocation() {
        
        let asyncExpectation = expectation(description: "longRunningFunction")
        
        var numberOfInvocations = 0
        
        Invoke.onceEveryLaunch(label: "asyncInvocation1", asyncOn: DispatchQueue(label: queueName), handler: {
            numberOfInvocations += 1
            XCTAssertEqual(DispatchQueue.currentLabel, self.queueName)
            asyncExpectation.fulfill()
        })()
        
        waitForExpectations(timeout: 5) { error in
            XCTAssertEqual(numberOfInvocations, 1)
        }
    }
    
    
    func testMultipleInvocations() {
        var numberOfInvocations = 0
        
        let invocation = Invoke.onceEveryLaunch(label: "invocation2") {
            numberOfInvocations += 1
        }
        
        invocation()
        invocation()
        invocation()
        XCTAssertEqual(numberOfInvocations, 1)
    }
    
    
    func testMultipleInvocationsWithSameLabel() {
        var numberOfInvocations = 0
        
        let invocation1 = Invoke.onceEveryLaunch(label: "invocation") {
            numberOfInvocations += 1
        }
        
        let invocation2 = Invoke.onceEveryLaunch(label: "invocation") {
            numberOfInvocations += 2
        }
        
        invocation1()
        invocation1()
        invocation2()
        invocation2()
        XCTAssertEqual(numberOfInvocations, 1)
    }
}

extension DispatchQueue {
    class var currentLabel: String {
        return String(validatingUTF8: __dispatch_queue_get_label(nil))!
    }
}
