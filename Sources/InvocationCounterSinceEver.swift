//
//  InvocationCounterSinceEver.swift
//  Invoke
//
//  Created by Gruppioni Michele on 14/08/16.
//
//

import Foundation

class InvocationCounterSinceEver {
    private var defaults: UserDefaults
    
    init(defaults: UserDefaults) {
        self.defaults = defaults
    }
    
    convenience init?() {
        guard let defaults = UserDefaults(suiteName: "com.gruppio.invoke.invocation_counter_since_ever") else { return nil }
        self.init(defaults: defaults)
    }
}

// MARK: InvocationCounter
extension InvocationCounterSinceEver: InvocationCounter {
    var allInvocationsLabels: [String] {
        return defaults.attributeKeys
    }
    
    func numberOfInvocations(of label: String) -> Int {
        return defaults.integer(forKey: label)
    }
    
    func invoked(label: String) {
        defaults.set(numberOfInvocations(of: label) + 1, forKey: label)
    }
    
    func reset() {
        allInvocationsLabels.forEach() {
            defaults.set(0, forKey: $0)
        }
    }
}
