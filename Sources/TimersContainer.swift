//
//  TimersContainer.swift
//  Invoke
//
//  Created by Gruppioni Michele on 15/08/16.
//
//

import Foundation

class TimersContainer {
    private var timers = [String : Timer]()
    
    func timer(forKey key: String) -> Timer? {
        return timers[key]
    }
    
    func invalidate(timerforKey key: String) {
        if let timer = timer(forKey: key) {
            timer.invalidate()
        }
    }
    
    func add(timer: Timer, for key: String) {
        invalidate(timerforKey: key)
        timers[key] = timer
    }
}
