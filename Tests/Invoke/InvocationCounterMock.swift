//
//  InvocationCounterMock.swift
//  Invoke
//
//  Created by Gruppioni Michele on 26/08/16.
//
//

import Foundation
@testable import Invoke

class InvocationCounterMock {
    var invocations: [String : Int]
    
    init(invocations: [String : Int]) {
        self.invocations = invocations
    }
    
    convenience init() {
        self.init(invocations: [String : Int]())
    }
}

// MARK: InvocationCounter
extension InvocationCounterMock: InvocationCounter {
    var allInvocationsLabels: [String] {
        return Array(invocations.keys)
    }
    
    func numberOfInvocations(of label: String) -> Int {
        return invocations[label] ?? 0
    }
    
    func invoked(label: String) {
        invocations[label] = numberOfInvocations(of: label) + 1
    }
    
    func reset(label: String) {
        invocations.removeValue(forKey: label)
    }
}
