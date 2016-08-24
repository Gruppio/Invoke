//
//  WeakHandlersContainer.swift
//  Invoke
//
//  Created by Gruppioni Michele on 24/08/16.
//
//

import Foundation

final class WeakHandlersContainer: HandlersContainer {
    
    private typealias Handler = () -> Void
    private typealias HandlerBlock = @convention(block) () -> Void
    
    private var handlers = [String : Weak<AnyObject>]()
    
    func getHandler(forKey key: String) -> (() -> Void)? {
        if let weakAnyObject = handlers[key],
            let anyObject = weakAnyObject.object {
            return unsafeBitCast(anyObject, to: HandlerBlock.self) as Handler
        }
        return nil
    }
    
    func add(handler: @escaping () -> Void, forKey key: String) {
        let anyObjectHandler = unsafeBitCast(handler as HandlerBlock, to: AnyObject.self)
        handlers[key] = Weak<AnyObject>(anyObjectHandler)
    }
    
    func removeHandler(forKey key: String) {
        handlers.removeValue(forKey: key)
    }
}
