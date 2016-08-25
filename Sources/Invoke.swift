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
    open class func onceEveryLaunch(label: String, asyncOn queue: DispatchQueue? = nil, handler: @escaping () -> Void) -> () -> Void {
        return whenInvocationsSinceLauch(label: label, asyncOn: queue, are: { $0 == 0 }, handler: handler)
    }
    
    open class func whenInvocationsSinceLauch(label: String, asyncOn queue: DispatchQueue? = nil, are shouldInvoke: @escaping (Int) -> Bool, handler: @escaping () -> Void) -> () -> Void {
        return handleInvocation(invocationsCounter: invocationsCounterSinceLaunch, label: label, asyncOn: queue, are: shouldInvoke, handler: handler)
    }
    
    open class func onceForever(label: String, asyncOn queue: DispatchQueue? = nil, handler: @escaping () -> Void) -> () -> Void {
        return whenInvocationsSinceEver(label: label, asyncOn: queue, are: { $0 == 0 }, handler: handler)
    }
    
    open class func whenInvocationsSinceEver(label: String, asyncOn queue: DispatchQueue? = nil, are shouldInvoke: @escaping (Int) -> Bool, handler: @escaping () -> Void) -> () -> Void {
        return handleInvocation(invocationsCounter: invocationsCounterSinceEver, label: label, asyncOn: queue, are: shouldInvoke, handler: handler)
    }
    
    open class func onceForInstallation(label: String, asyncOn queue: DispatchQueue? = nil, handler: @escaping () -> Void) -> () -> Void {
        return whenInvocationsSinceInstallation(label: label, asyncOn: queue, are: { $0 == 0 }, handler: handler)
    }
    
    open class func whenInvocationsSinceInstallation(label: String, asyncOn queue: DispatchQueue? = nil,are shouldInvoke: @escaping (Int) -> Bool, handler: @escaping () -> Void) -> () -> Void {
        return handleInvocation(invocationsCounter: invocationsCounterSinceInstallation, label: label, asyncOn: queue, are: shouldInvoke, handler: handler)
    }
    
    private class func handleInvocation(invocationsCounter: InvocationCounter, label: String, asyncOn queue: DispatchQueue? = nil, are shouldInvoke: @escaping (Int) -> Bool, handler: @escaping () -> Void) -> () -> Void {
        return {
            let numberOfInvocations = invocationsCounter.numberOfInvocations(of: label)
            defer {
                invocationsCounter.invoked(label: label)
            }
            if shouldInvoke(numberOfInvocations) {
                if let queue = queue {
                    queue.async {
                        handler()
                    }
                } else {
                    handler()
                }
            }
        }
    }
}


// MARK: Timer Based
extension Invoke {
    
    private struct timerUserInfo {
        var label: String?
        var queue: DispatchQueue?
    }
    
    open class func every(label: String, _ timeInterval: TimeInterval, asyncOn queue: DispatchQueue? = nil, handler: @escaping () -> Void) -> (start: () -> Void, stop: () -> Void, release: () -> Void) {
        let userInfo = timerUserInfo(label: label, queue: queue)
        let timer = Timer.scheduledTimer(timeInterval: timeInterval, target: Invoke.self, selector: #selector(Invoke.timerTimedOut(timer:)), userInfo: userInfo, repeats: true)
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
        if let userInfo = timer.userInfo as? timerUserInfo,
            let label = userInfo.label,
            let handler = handlersContainer.getHandler(forKey: label) {
            if let queue = userInfo.queue {
                queue.async {
                    handler()
                }
            }
            else {
                handler()
            }
        }
    }
}





// MARK: Reset Data
extension Invoke {
    open class func reset() {
        invocationsCounterSinceLaunch.reset()
        invocationsCounterSinceInstallation.reset()
    }
}

