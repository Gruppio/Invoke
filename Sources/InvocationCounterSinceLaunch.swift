//
//  InvocationCounterSinceLaunch.swift
//  Invoke
//
//  Created by Gruppioni Michele on 14/08/16.
//
//

import Foundation

struct InvocationCounterSinceLaunch {
    private let syncronizationQueue = DispatchQueue(label: "com.gruppio.invoke.invocation_counter_since_launch")
    private var _invocations = [String : Int]()
    var invocations: [String : Int] {
        get {
            return syncronizationQueue.sync {
                return _invocations
            }
        }
        set {
            syncronizationQueue.sync {
                _invocations = newValue
            }
        }
    }
}

extension InvocationCounterSinceLaunch: InvocationCounter {
    func numberOfInvocations(of label: String) -> Int {
        return invocations[label] ?? 0
    }
    
    func allInvocationsLabels() -> [String] {
        return Array(invocations.keys)
    }
    
    mutating func invoked(label: String) {
        invocations[label] = numberOfInvocations(of: label) + 1
    }
    
    mutating func reset() {
        invocations.removeAll()
    }
}
