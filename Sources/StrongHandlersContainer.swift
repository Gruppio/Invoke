//
//  StrongHandlersContainer.swift
//  Invoke
//
//  Created by Gruppioni Michele on 23/08/16.
//
//

import Foundation

final class StrongHandlersContainer: HandlersContainer {
    
    private var handlers = [String : () -> Void]()
    
    func getHandler(forKey key: String) -> (() -> Void)? {
        return handlers[key]
    }
    
    func add(handler: @escaping () -> Void, forKey key: String) {
        handlers[key] = handler
    }
    
    func removeHandler(forKey key: String) {
        handlers.removeValue(forKey: key)
    }
}
