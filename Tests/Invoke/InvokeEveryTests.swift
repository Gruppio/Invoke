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
        
        var handlerInvoked = 0
        let timer = Invoke.every(label: label, 0.1) {
            handlerInvoked += 1
        }
        
        timer.start()
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.25))
        
        XCTAssertEqual(handlerInvoked, 3)
        timer.stop()
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.25))
        
        XCTAssertEqual(handlerInvoked, 3)
        timer.release()
        timer.start()
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.25))
        
        XCTAssertEqual(handlerInvoked, 3)
        
    }
}
