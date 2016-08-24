//
//  TimersContainer.swift
//  Invoke
//
//  Created by Gruppioni Michele on 15/08/16.
//
//

import Foundation

final class TimersContainer {
    private var timers = [String : Timer]()
    
    func getTimer(forKey key: String) -> Timer? {
        return timers[key]
    }
    
    func invalidateTimer(forKey key: String) {
        timers[key]?.invalidate()
    }
    
    func add(timer: Timer, forKey key: String) {
        invalidateTimer(forKey: key)
        timers[key] = timer
    }
    
    func removeTimer(forKey key: String) {
        invalidateTimer(forKey: key)
        timers.removeValue(forKey: key)
    }
 }
