//
//  InvokeResetTests.swift
//  Invoke
//
//  Created by Travasoni Giuseppe on 30/08/16.
//
//

import XCTest
@testable import Invoke

class InvokeResetTests: XCTestCase {
    
    let label1 = "label1"
    
    override func setUp() {
        super.setUp()
        Invoke.invocationsCounterSinceLaunch = InvocationCounterMock()
        Invoke.invocationsCounterSinceInstallation = InvocationCounterMock()
        Invoke.invocationsCounterSinceEver = InvocationCounterMock()
    }
    
    func testReset() {
        
        var numberOfInvocations = 0
        
        Invoke.onceEveryInstallation(label: label1) {
            numberOfInvocations += 1
        }()
        
        Invoke.onceEveryLaunch(label: label1) {
            numberOfInvocations += 1
        }()
        
        Invoke.onceForever(label: label1) {
            numberOfInvocations += 1
        }()
        
        XCTAssertEqual(Invoke.invocationsCounterSinceInstallation.numberOfInvocations(of: label1), 1)
        XCTAssertEqual(Invoke.invocationsCounterSinceLaunch.numberOfInvocations(of: label1), 1)
        XCTAssertEqual(Invoke.invocationsCounterSinceEver.numberOfInvocations(of: label1), 1)
        
        Invoke.resetAll()
        
        XCTAssertEqual(Invoke.invocationsCounterSinceInstallation.numberOfInvocations(of: label1), 0)
        XCTAssertEqual(Invoke.invocationsCounterSinceLaunch.numberOfInvocations(of: label1), 0)
        XCTAssertEqual(Invoke.invocationsCounterSinceEver.numberOfInvocations(of: label1), 0)
        XCTAssertEqual(Invoke.invocationsCounterSinceInstallation.allInvocationsLabels.count, 0)
        XCTAssertEqual(Invoke.invocationsCounterSinceLaunch.allInvocationsLabels.count, 0)
        XCTAssertEqual(Invoke.invocationsCounterSinceEver.allInvocationsLabels.count, 0)
        
    }
    
    func testResetSinceInstallation() {
        
        var numberOfInvocations = 0
        
        Invoke.onceEveryInstallation(label: label1) {
            numberOfInvocations += 1
            }()
        
        XCTAssertEqual(Invoke.invocationsCounterSinceInstallation.numberOfInvocations(of: label1), 1)
        
        Invoke.resetInvocationsSinceInstallation(label: label1)
        
        XCTAssertEqual(Invoke.invocationsCounterSinceInstallation.numberOfInvocations(of: label1), 0)
        
    }
    
    func testResetSinceLaunch() {
        
        var numberOfInvocations = 0
        
        Invoke.onceEveryLaunch(label: label1) {
            numberOfInvocations += 1
            }()
        
        XCTAssertEqual(Invoke.invocationsCounterSinceLaunch.numberOfInvocations(of: label1), 1)
        
        Invoke.resetInvocationsSinceLaunch(label: label1)
        
        XCTAssertEqual(Invoke.invocationsCounterSinceLaunch.numberOfInvocations(of: label1), 0)
        
    }
    
    func testResetSinceEver() {
        
        var numberOfInvocations = 0
        
        Invoke.onceForever(label: label1) {
            numberOfInvocations += 1
            }()
        
        XCTAssertEqual(Invoke.invocationsCounterSinceEver.numberOfInvocations(of: label1), 1)
        
        Invoke.resetInvocationsSinceEver(label: label1)
        
        XCTAssertEqual(Invoke.invocationsCounterSinceEver.numberOfInvocations(of: label1), 0)
        
    }
    
}
