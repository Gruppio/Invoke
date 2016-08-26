//
//  InvocationCounterSinceEver.swift
//  Invoke
//
//  Created by Gruppioni Michele on 14/08/16.
//
//

import Foundation

final class InvocationCounterSinceEver {
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
            return keychain.getStringArray(kInvocationsLabels) ?? []
        }
        set {
            keychain.set(newValue, forKey: kInvocationsLabels)
        }
    }
    
    func numberOfInvocations(of label: String) -> Int {
        let invocationCountLabel = createInvocationCountLabel(with: label)
        return Int(keychain.getString(invocationCountLabel) ?? "0") ?? 0
    }
    
    func invoked(label: String) {
        if !allInvocationsLabels.contains(label) {
            allInvocationsLabels.append(label)
        }
        
        let invocationCountLabel = createInvocationCountLabel(with: label)
        keychain.set(String(numberOfInvocations(of: label) + 1), forKey: invocationCountLabel)
    }
    
    func reset(label: String) {
        if allInvocationsLabels.contains(label) {
            allInvocationsLabels = allInvocationsLabels.filter({$0 != label})
            let invocationCountLabel = createInvocationCountLabel(with: label)
            keychain.delete(invocationCountLabel)
        }
    }
        
    private func createInvocationCountLabel(with label: String) -> String {
        return kInvocationsCountPrefix + label
    }

}
