//
//  InvocationCounterSinceInstallation.swift
//  Invoke
//
//  Created by Travasoni Giuseppe on 24/08/16.
//
//

import Foundation

class InvocationCounterSinceInstallation {
    fileprivate var defaults: UserDefaults
    fileprivate let kInvocationsLabels = "invoke.kInvocationsLabels"
    fileprivate let kInvocationsCountPrefix = "invoke.kInvocationsLabelsCount."
    
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
            return defaults.stringArray(forKey: kInvocationsLabels) ?? []
        }
        set {
            defaults.set(newValue, forKey: kInvocationsLabels)
        }
    }
    
    func numberOfInvocations(of label: String) -> Int {
        return defaults.integer(forKey: kInvocationsCountPrefix+label)
    }
    
    func invoked(label: String) {
        let invocationCountLabel = createInvocationCountLabel(with: label)
        defaults.set(numberOfInvocations(of: label) + 1, forKey: invocationCountLabel)
        
        if !allInvocationsLabels.contains(label) {
            allInvocationsLabels.append(label)
        }
    }
    
    func reset(label: String) {
        if allInvocationsLabels.contains(label) {
            let invocationCountLabel = createInvocationCountLabel(with: label)
            allInvocationsLabels = allInvocationsLabels.filter({$0 != label})
            defaults.removeObject(forKey: invocationCountLabel)
        }
    }
    
    private func createInvocationCountLabel(with label: String) -> String {
        return kInvocationsCountPrefix + label
    }
}
