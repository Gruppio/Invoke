//
//  InvocationCounterSinceEver.swift
//  Invoke
//
//  Created by Gruppioni Michele on 14/08/16.
//
//

import Foundation

class InvocationCounterSinceEver {
    
    fileprivate let kInvocationsLabels = "kInvocationsLabels"
    fileprivate let kInvocationsCountPrefix = "kInvocationsLabelsCount."
    
    fileprivate var keychain: KeychainSwift
    
    init(keychainPrefix: String? = nil) {
        keychain = KeychainSwift(keyPrefix: keychainPrefix ?? "invoke")
    }
    
}

// MARK: InvocationCounter
extension InvocationCounterSinceEver: InvocationCounter {
    
    var allInvocationsLabels: [String] {
        get {
            if let invocationsLabels = keychain.getStringArray(kInvocationsLabels) {
                return invocationsLabels
            }
            else {
                return []
            }
        }
        set {
            keychain.set(newValue, forKey: kInvocationsLabels)
        }
    }
    
    func numberOfInvocations(of label: String) -> Int {
        if let numberOfInvocationString = keychain.getString(kInvocationsCountPrefix+label),
            let numberOfInvocations = Int(numberOfInvocationString) {
            return numberOfInvocations
        }
        else {
            return 0
        }
    }
    
    func invoked(label: String) {
        if !allInvocationsLabels.contains(label) {
            allInvocationsLabels.append(label)
        }
        keychain.set(String(numberOfInvocations(of: label) + 1), forKey: kInvocationsCountPrefix+label)
    }
    
    func reset() {
        allInvocationsLabels.forEach({ keychain.delete(kInvocationsCountPrefix+$0) })
        keychain.delete(kInvocationsLabels)
        keychain.clear()
    }
    
}
