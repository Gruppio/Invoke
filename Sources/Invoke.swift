//
//  Invoke.swift
//  Invoke
//
//  Created by Gruppioni Michele on 14/08/16.
//
//

import Foundation

final public class Invoke {
    static var timersContainer = TimersContainer()
    static var invocationsCounterSinceLaunch: InvocationCounter = InvocationCounterSinceLaunch()
    static var invocationsCounterSinceEver: InvocationCounter = InvocationCounterSinceEver()
}


// MARK: Number of Invocation Based
extension Invoke {
    public class func onceEveryLaunch(label: String, handler: @escaping () -> Void) -> () -> Void {
        return whenInvocationsSinceLauch(label: label, are: { $0 == 0 }, handler: handler)
    }
    
    public class func whenInvocationsSinceLauch(label: String,
                                                are shouldInvoke: @escaping (Int) -> Bool,
                                                handler: @escaping () -> Void) -> () -> Void {
        return whenInvocations(invocationsCounter: invocationsCounterSinceLaunch,
                                          label: label,
                                          are: shouldInvoke,
                                          handler: handler)
    }
    
    public class func onceForever(label: String, handler: @escaping () -> Void) -> () -> Void {
        return whenInvocationsSinceEver(label: label, are: { $0 == 0 }, handler: handler)
    }

    public class func whenInvocationsSinceEver(label: String,
                                                are shouldInvoke: @escaping (Int) -> Bool,
                                                handler: @escaping () -> Void) -> () -> Void {
        return whenInvocations(invocationsCounter: invocationsCounterSinceEver,
                                          label: label,
                                          are: shouldInvoke,
                                          handler: handler)
    }
    
    private class func whenInvocations(invocationsCounter: InvocationCounter,
                                                  label: String,
                                                  are shouldInvoke: @escaping (Int) -> Bool,
                                                  handler: @escaping () -> Void) -> () -> Void {
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


// MARK: Timer Based
extension Invoke {
    public class func every(label: String, _ timeInterval: TimeInterval, handler: @escaping () -> Void) -> (start: () -> Void, stop: () -> Void) {
        let start: () -> Void = {
            if #available(OSX 10.12, *) {
                let timer = Timer(timeInterval: timeInterval, repeats: true, block: { _ in
                    handler()
                })
                timersContainer.add(timer: timer, for: label)
            } else {
                // Fallback on earlier versions
            }
        }
        
        let stop: () -> Void = {
            timersContainer.invalidate(timerforKey: label)
        }
        return (start: start, stop: stop)
    }
}





// MARK: Reset Data
extension Invoke {
    public class func reset() {
        invocationsCounterSinceLaunch.reset()
        invocationsCounterSinceEver.reset()
    }
}

