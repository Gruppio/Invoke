//
//  Invoke.swift
//  Invoke
//
//  Created by Gruppioni Michele on 14/08/16.
//
//

import Foundation

final public class Invoke {
    static var invocationsCounterSinceLaunch: InvocationCounter = InvocationCounterSinceLaunch()
}


// MARK: Reset Data
extension Invoke {
    public class func resetNonPersistantData() {
        invocationsCounterSinceLaunch.reset()
    }
}


// MARK: Lauch based invocations
extension Invoke {
    public class func whenInvocationsSinceLauch(label: String,
                                                are shouldInvoke: (Int) -> Bool,
                                                handler: () -> Void) -> () -> Void {
        return {
            let numberOfInvocations = invocationsCounterSinceLaunch.numberOfInvocations(of: label)
            defer {
                invocationsCounterSinceLaunch.invoked(label: label)
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

/*
// MARK: Persistant invocations
extension Invoke {
    public class func whenInvocationsSinceEver(label: String,
                                               are shouldInvoke: (Int) -> Bool,
                                               handler: () -> Void) -> () -> Void {
        return {
            let
        }
    }
}
*/
