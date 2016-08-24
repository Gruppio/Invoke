//
//  InvocationCounterSinceEver.swift
//  Invoke
//
//  Created by Gruppioni Michele on 14/08/16.
//
//

import Foundation

class InvocationCounterSinceEver {
    let kInvocationsLabels = "invoke.kInvocationsLabels"
    let kInvocationsCountPrefix = "invoke.kInvocationsLabelsCount."
}

// MARK: InvocationCounter
extension InvocationCounterSinceEver: InvocationCounter {
    var allInvocationsLabels: [String] {
        return []
    }
    
    func numberOfInvocations(of label: String) -> Int {
        return 0
    }
    
    func invoked(label: String) {
    }
    
    func reset() {
    }
    
}
