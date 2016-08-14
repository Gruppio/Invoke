//
//  Invoke.swift
//  Invoke
//
//  Created by Gruppioni Michele on 14/08/16.
//
//

import Foundation

final public class Invoke {
    static var defaults: UserDefaults = UserDefaults.standard
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
}


extension Invoke {
    class func onceForAppLaunch(label: String, handler: () -> Void) -> () -> Void {
        return {
            let numberOfInvocations = Invoke.invocations[label] ?? 0
            defer {
                invocations.updateValue(numberOfInvocations + 1, forKey: label)
            }
            guard numberOfInvocations == 0 else { return }
            handler()
        }
    }
}
