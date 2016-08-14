//
//  Invoke.swift
//  Invoke
//
//  Created by Gruppioni Michele on 14/08/16.
//
//

import Foundation

final public class Invoke {
    private static var invocationsCounterSinceLaunch: InvocationCounter = InvocationCounterSinceLaunch()
    private static var invocationsCounterSinceEver: InvocationCounter = InvocationCounterSinceEver()!
}


// MARK: Reset Data
extension Invoke {
    public class func resetNonPersistantData() {
        invocationsCounterSinceLaunch.reset()
    }
}


// MARK: Lauch based invocations
extension Invoke {
    public class func onceEveryLaunch(label: String, handler: () -> Void) -> () -> Void {
        return whenInvocationsSinceLauch(label: label, are: { $0 == 0 }, handler: handler)
    }
    
    public class func whenInvocationsSinceLauch(label: String,
                                                are shouldInvoke: (Int) -> Bool,
                                                handler: () -> Void) -> () -> Void {
        return whenInvocationsSinceLaunch(invocationsCounter: invocationsCounterSinceLaunch,
                                          label: label,
                                          are: shouldInvoke,
                                          handler: handler)
    }
    
    public class func onceForEver(label: String, handler: () -> Void) -> () -> Void {
        return whenInvocationsSinceEver(label: label, are: { $0 == 0 }, handler: handler)
    }

    public class func whenInvocationsSinceEver(label: String,
                                                are shouldInvoke: (Int) -> Bool,
                                                handler: () -> Void) -> () -> Void {
        return whenInvocationsSinceLaunch(invocationsCounter: invocationsCounterSinceEver,
                                          label: label,
                                          are: shouldInvoke,
                                          handler: handler)
    }
    
    private class func whenInvocationsSinceLaunch(invocationsCounter: InvocationCounter,
                                                  label: String,
                                                  are shouldInvoke: (Int) -> Bool,
                                                  handler: () -> Void) -> () -> Void {
        return {
            let numberOfInvocations = invocationsCounter.numberOfInvocations(of: label)
            defer {
                invocationsCounter.invoked(label: label)
            }
            if shouldInvoke(numberOfInvocations) {
                handler()
            }
        }
    }
}

