//
//  Invoke.swift
//  Invoke
//
//  Created by Gruppioni Michele on 14/08/16.
//
//

import Foundation

open class Invoke {
    static var invocationsCounterSinceLaunch: InvocationCounter = InvocationCounterSinceLaunch()
    static var invocationsCounterSinceEver: InvocationCounter = InvocationCounterSinceEver()
    static var timersContainer = TimersContainer()
    static var handlersContainer = HandlersContainer()
}


// MARK: Number of Invocation Based
extension Invoke {
    open class func onceEveryLaunch(label: String, handler: @escaping () -> Void) -> () -> Void {
        return whenInvocationsSinceLauch(label: label, are: { $0 == 0 }, handler: handler)
    }
    
    open class func whenInvocationsSinceLauch(label: String,
                                                are shouldInvoke: @escaping (Int) -> Bool,
                                                handler: @escaping () -> Void) -> () -> Void {
        return whenInvocations(invocationsCounter: invocationsCounterSinceLaunch,
                                          label: label,
                                          are: shouldInvoke,
                                          handler: handler)
    }
    
    open class func onceForever(label: String, handler: @escaping () -> Void) -> () -> Void {
        return whenInvocationsSinceEver(label: label, are: { $0 == 0 }, handler: handler)
    }

    open class func whenInvocationsSinceEver(label: String,
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
    open class func every(label: String, _ timeInterval: TimeInterval, handler: @escaping () -> Void) -> (start: () -> Void, stop: () -> Void) {
        let start: () -> Void = {
            let timer = Timer.scheduledTimer(timeInterval: timeInterval, target: Invoke.self, selector: #selector(Invoke.timerTimedOut(label:)), userInfo: label, repeats: true)
            timersContainer.add(timer: timer, forKey: label)
        }
        
        let stop: () -> Void = {
        }
        return (start: start, stop: stop)
    }
    
    @objc private class func timerTimedOut(label: String) {
        print(label)
    }
}





// MARK: Reset Data
extension Invoke {
    open class func reset() {
        invocationsCounterSinceLaunch.reset()
        invocationsCounterSinceEver.reset()
    }
}

