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
    static var invocationsCounterSinceInstallation: InvocationCounter = InvocationCounterSinceInstallation()
    static var invocationsCounterSinceEver: InvocationCounter = InvocationCounterSinceEver()
    static var handlersContainer: HandlersContainer = StrongHandlersContainer()
    static var timersContainer = TimersContainer()
}


// MARK: Number of Invocation Based
extension Invoke {
    open class func onceEveryLaunch(label: String, handler: @escaping () -> Void) -> () -> Void {
        return whenInvocationsSinceLauch(label: label, are: { $0 == 0 }, handler: handler)
    }
    
    open class func whenInvocationsSinceLauch(label: String, are shouldInvoke: @escaping (Int) -> Bool, handler: @escaping () -> Void) -> () -> Void {
        return handleInvocation(invocationsCounter: invocationsCounterSinceLaunch, label: label, are: shouldInvoke, handler: handler)
    }
    
    open class func onceForever(label: String, handler: @escaping () -> Void) -> () -> Void {
        return whenInvocationsSinceEver(label: label, are: { $0 == 0 }, handler: handler)
    }
    
    open class func whenInvocationsSinceEver(label: String, are shouldInvoke: @escaping (Int) -> Bool, handler: @escaping () -> Void) -> () -> Void {
        return handleInvocation(invocationsCounter: invocationsCounterSinceEver, label: label, are: shouldInvoke, handler: handler)
    }
    
    open class func onceEveryInstallation(label: String, handler: @escaping () -> Void) -> () -> Void {
        return whenInvocationsSinceInstallation(label: label, are: { $0 == 0 }, handler: handler)
    }
    
    open class func whenInvocationsSinceInstallation(label: String, are shouldInvoke: @escaping (Int) -> Bool, handler: @escaping () -> Void) -> () -> Void {
        return handleInvocation(invocationsCounter: invocationsCounterSinceInstallation, label: label, are: shouldInvoke, handler: handler)
    }
    
    private class func handleInvocation(invocationsCounter: InvocationCounter, label: String, are shouldInvoke: @escaping (Int) -> Bool, handler: @escaping () -> Void) -> () -> Void {
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


// MARK: Start Until Stop
extension Invoke {
    open class func untilStopSinceLaunch(label: String, handler: @escaping () -> Void) -> (start: () -> Void, stop: () -> Void) {
        return handleUntilStopInvocation(invocationsCounter: invocationsCounterSinceLaunch, label: label, handler: handler)
    }
    
    open class func untilStopSinceInstallation(label: String, handler: @escaping () -> Void) -> (start: () -> Void, stop: () -> Void) {
        return handleUntilStopInvocation(invocationsCounter: invocationsCounterSinceInstallation, label: label, handler: handler)
    }
    
    open class func untilStopSinceEver(label: String, handler: @escaping () -> Void) -> (start: () -> Void, stop: () -> Void) {
        return handleUntilStopInvocation(invocationsCounter: invocationsCounterSinceEver, label: label, handler: handler)
    }

    private class func handleUntilStopInvocation(invocationsCounter: InvocationCounter, label: String, handler: @escaping () -> Void) -> (start: () -> Void, stop: () -> Void) {
        
        let stopLabel = label + "_stop"
        
        let start: () -> Void = {
            if invocationsCounter.numberOfInvocations(of: stopLabel) == 0 {
                invocationsCounter.invoked(label: label)
                handler()
            }
        }
        
        let stop: () -> Void = {
            invocationsCounter.invoked(label: stopLabel)
        }
        
        return (start: start, stop: stop)
    }
}


// MARK: Timer Based
extension Invoke {
    open class func every(label: String, _ timeInterval: TimeInterval, handler: @escaping () -> Void) -> (start: () -> Void, stop: () -> Void, release: () -> Void) {
        let timer = Timer.scheduledTimer(timeInterval: timeInterval, target: Invoke.self, selector: #selector(Invoke.timerTimedOut(timer:)), userInfo: label, repeats: true)
        timersContainer.add(timer: timer, forKey: label)
        handlersContainer.add(handler: handler, forKey: label)
        
        let start: () -> Void = {
            timersContainer.getTimer(forKey: label)?.fire()
        }
        
        let stop: () -> Void = {
            timersContainer.invalidateTimer(forKey: label)
        }
        
        let release: () -> Void = {
            timersContainer.removeTimer(forKey: label)
            handlersContainer.removeHandler(forKey: label)
        }
        
        return (start: start, stop: stop, release: release)
    }
    
    @objc private class func timerTimedOut(timer: Timer) {
        if let label = timer.userInfo as? String,
            let handler = handlersContainer.getHandler(forKey: label) {
            handler()
        }
    }
}


// MARK: Reset Data
extension Invoke {
    open class func resetAll() {
        invocationsCounterSinceLaunch.resetAll()
        invocationsCounterSinceInstallation.resetAll()
        invocationsCounterSinceEver.resetAll()
    }
    
    open class func resetInvocationsSinceLaunch(label: String) {
        invocationsCounterSinceLaunch.reset(label: label)
    }
    
    open class func resetInvocationsSinceInstallation(label: String) {
        invocationsCounterSinceInstallation.reset(label: label)
    }
    
    open class func resetInvocationsSinceEver(label: String) {
        invocationsCounterSinceEver.reset(label: label)
    }
}

