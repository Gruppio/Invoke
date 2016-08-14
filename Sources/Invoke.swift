//
//  Invoke.swift
//  Invoke
//
//  Created by Gruppioni Michele on 14/08/16.
//
//

import Foundation

final public class Invoke {
    static var defaults: UserDefaults = UserDefaults(suiteName: "Invoke") ?? UserDefaults.standard
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


// MARK: Reset Data
extension Invoke {
    public class func resetNonPersistantData() {
        invocations.removeAll()
    }
}


// MARK: Lauch based invocations
extension Invoke {
    public class func whenInvocationsSinceLauch(label: String,
                                                are shouldInvoke: (Int) -> Bool,
                                                handler: () -> Void) -> () -> Void {
        return {
            let numberOfInvocations = Invoke.invocations[label] ?? 0
            defer {
                invocations.updateValue(numberOfInvocations + 1, forKey: label)
            }
            if shouldInvoke(numberOfInvocations) {
                handler()
            }
        }
    }

    public class func onceEveryLaunch(label: String, handler: () -> Void) -> () -> Void {
        return whenInvocationsSinceLauch(label: label, are: { $0 == 0 }, handler: handler)
    }
}

