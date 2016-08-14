//
//  InvocationCounter.swift
//  Invoke
//
//  Created by Gruppioni Michele on 14/08/16.
//
//

import Foundation

protocol InvocationCounter {
    func numberOfInvocations(of label: String) -> Int
    func invoked(label: String)
    func allInvocationsLabels() -> [String]
    func reset()
}

struct InvocationCounterSinceLaunch {
    private static let syncronizationQueue = DispatchQueue(label: "com.gruppio.invoke")
    
    private static var _invocations = [String : Int]()
    class var invocations: [String : Int] {
        get {
            return syncronizationQueue.sync {
                return _invocations
            }
        }
        set {
            syncronizationQueue.async {
                _invocations = newValue
            }
        }

}
