//
//  InvocationCounterSinceInstallation.swift
//  Invoke
//
//  Created by Travasoni Giuseppe on 24/08/16.
//
//

import Foundation

class InvocationCounterSinceInstallation {
    var defaults: UserDefaults
    let kInvocationsLabels = "invoke.kInvocationsLabels"
    let kInvocationsCountPrefix = "invoke.kInvocationsLabelsCount."
    
    init(defaults: UserDefaults) {
        self.defaults = defaults
    }
    
    convenience init() {
        self.init(defaults: UserDefaults.standard)
    }
}

// MARK: InvocationCounter
extension InvocationCounterSinceInstallation: InvocationCounter {
    
    var allInvocationsLabels: [String] {
        get {
            if let invocationsLabels = defaults.stringArray(forKey: kInvocationsLabels) {
                return invocationsLabels
            }
            else {
                return []
            }
        }
        set {
            defaults.set(newValue, forKey: kInvocationsLabels)
        }
    }
    
    func numberOfInvocations(of label: String) -> Int {
        return defaults.integer(forKey: kInvocationsCountPrefix+label)
    }
    
    func invoked(label: String) {
        if !allInvocationsLabels.contains(label) {
            allInvocationsLabels.append(label)
        }
        defaults.set(numberOfInvocations(of: label) + 1, forKey: kInvocationsCountPrefix+label)
        defaults.synchronize()
    }
    
    func reset() {
        allInvocationsLabels.forEach({ defaults.removeObject(forKey: kInvocationsCountPrefix+$0) })
        defaults.removeObject(forKey: kInvocationsLabels)
        defaults.synchronize()
    }
}
