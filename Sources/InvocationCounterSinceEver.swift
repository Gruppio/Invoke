//
//  InvocationCounterSinceEver.swift
//  Invoke
//
//  Created by Gruppioni Michele on 14/08/16.
//
//

import Foundation

class InvocationCounterSinceEver {
    fileprivate let kInvocationPrefix = "invoke"
    
    fileprivate let kInvocationsLabels = "kInvocationsLabels"
    fileprivate let kInvocationsCountPrefix = "kInvocationsLabelsCount."
    
    fileprivate var keychain: KeychainSwift
    
    init() {
        keychain = KeychainSwift(keyPrefix: kInvocationPrefix)
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
        return 0
    }
    
    func invoked(label: String) {
    }
    
    func reset() {
    }
    
}
