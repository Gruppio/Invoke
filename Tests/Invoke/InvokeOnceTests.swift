//
//  InvokeOnceTests.swift
//  Invoke
//
//  Created by Gruppioni Michele on 14/08/16.
//
//

import XCTest
@testable import Invoke

class InvokeOnceTests: XCTestCase {
    
    let label1 = "label1"
    let label2 = "label2"
    
    let failHandler: () -> Void = {
        XCTFail()
    }

    
    override func setUp() {
        super.setUp()
        Invoke.invocationsCounterSinceLaunch = InvocationCounterMock()
        Invoke.invocationsCounterSinceInstallation = InvocationCounterMock()
        Invoke.invocationsCounterSinceEver = InvocationCounterMock()
    }
    
    // MARK: Once Every Launch
    func testSingleInvocationOnceEveryLauch() {
        singleInvocation(invokeOnce: Invoke.onceEveryLaunch)
    }
    
    
    func testMultipleInvocationsOnceEveryLauch() {
        multipleInvocations(invokeOnce: Invoke.onceEveryLaunch)
    }
    
    
    func testMultipleInvocationsWithSameLabelOnceEveryLauch() {
        multipleInvocationsWithSameLabel(invokeOnce: Invoke.onceEveryLaunch)
    }
    
    // MARK: Once Every Installation
    func testSingleInvocationOnceEveryInstallation() {
        singleInvocation(invokeOnce: Invoke.onceEveryInstallation)
    }
    
    
    func testMultipleInvocationsOnceEveryInstallation() {
        multipleInvocations(invokeOnce: Invoke.onceEveryInstallation)
    }
    
    
    func testMultipleInvocationsWithSameLabelOnceEveryInstallation() {
        multipleInvocationsWithSameLabel(invokeOnce: Invoke.onceEveryInstallation)
    }
    
    // MARK: Once Forever
    func testSingleInvocationOnceForever() {
        singleInvocation(invokeOnce: Invoke.onceForever)
    }
    
    
    func testMultipleInvocationsOnceForever() {
        multipleInvocations(invokeOnce: Invoke.onceForever)
    }
    
    
    func testMultipleInvocationsWithSameLabelOnceForever() {
        multipleInvocationsWithSameLabel(invokeOnce: Invoke.onceForever)
    }

    // MARK: Test Methods
    func singleInvocation(invokeOnce: ((String, @escaping () -> Void) -> () -> Void)) {
        var numberOfInvocations = 0
        
        invokeOnce(label1, {
            numberOfInvocations += 1
        })()
        
        XCTAssertEqual(numberOfInvocations, 1)
    }
    
    func multipleInvocations(invokeOnce: ((String, @escaping () -> Void) -> () -> Void)) {
        var numberOfInvocations = 0
        
        let invocation = invokeOnce(label2) {
            numberOfInvocations += 1
        }
        
        invocation()
        invocation()
        invocation()
        XCTAssertEqual(numberOfInvocations, 1)
    }
    
    func multipleInvocationsWithSameLabel(invokeOnce: ((String, @escaping () -> Void) -> () -> Void)) {
        var numberOfInvocations = 0
        
        let invocation1 = invokeOnce(label1) {
            numberOfInvocations += 1
        }
        
        let invocation2 = invokeOnce(label1) {
            numberOfInvocations += 2
        }
        
        invocation1()
        invocation1()
        invocation2()
        invocation2()
        XCTAssertEqual(numberOfInvocations, 1)
    }
    
}
