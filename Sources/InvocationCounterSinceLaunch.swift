//
//  InvocationCounterSinceLaunch.swift
//  Invoke
//
//  Created by Gruppioni Michele on 14/08/16.
//
//

import Foundation

class InvocationCounterSinceLaunch {
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

// MARK: InvocationCounter
extension InvocationCounterSinceLaunch: InvocationCounter {
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
