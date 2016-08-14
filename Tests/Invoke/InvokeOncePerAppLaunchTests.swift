//
//  InvokeOncePerAppLaunchTests.swift
//  Invoke
//
//  Created by Gruppioni Michele on 14/08/16.
//
//

import XCTest
@testable import Invoke

class InvokeOncePerAppLaunchTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Invoke.invocations.removeAll()
    }
    
    func testSingleInvocation() {
        var numberOfInvocations = 0
        
        Invoke.onceForAppLaunch(label: "invocation", handler: {
            numberOfInvocations += 1
        })()
        
        XCTAssertEqual(numberOfInvocations, 1)
    }
    
    
    func testMultipleInvocations() {
        var numberOfInvocations = 0
        
        let invocation = Invoke.onceForAppLaunch(label: "invocation") {
            numberOfInvocations += 1
        }
        
        invocation()
        invocation()
        invocation()
        XCTAssertEqual(numberOfInvocations, 1)
    }
    
    
    func testMultipleInvocationsWithSameLabel() {
        var numberOfInvocations = 0
        
        let invocation1 = Invoke.onceForAppLaunch(label: "invocation") {
            numberOfInvocations += 1
        }
        
        let invocation2 = Invoke.onceForAppLaunch(label: "invocation") {
            numberOfInvocations += 2
        }
        
        invocation1()
        invocation1()
        invocation2()
        invocation2()
        XCTAssertEqual(numberOfInvocations, 1)
    }
}
