//
//  InvokeEveryTests.swift
//  Invoke
//
//  Created by Gruppioni Michele on 23/08/16.
//
//

import XCTest
@testable import Invoke

class InvokeEveryTests: XCTestCase {
    
    let label = "invoke_every_test"
    
    func testTimerInvocationsWorks() {
        var handlerInvoked = false
        let timer = Invoke.every(label: label, 0.000001) {
            handlerInvoked = true
        }
        
        timer.start()
        XCTAssertEqual(handlerInvoked, true)
    }
}
