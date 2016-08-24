//
//  HandlersContainer.swift
//  Invoke
//
//  Created by Gruppioni Michele on 23/08/16.
//
//

import Foundation

final class HandlersContainer {
    
    private typealias Handler = () -> Void
    private typealias HandlerBlock = @convention(block) () -> Void
    
    private var handlers = NSHashTable<AnyObject>.weakObjects()
    
    func getHandler(forKey key: String) -> (() -> Void)? {
        if let value = handlers.value(forKey: key) {
            return unsafeBitCast(value, to: HandlerBlock.self) as Handler
        }
        return nil
    }
    
    func add(handler: @escaping () -> Void, forKey key: String) {
        let anyObjectHandler = unsafeBitCast(handler as HandlerBlock, to: AnyObject.self)
        handlers.setValue(anyObjectHandler, forKeyPath: key)
    }
    
    func removeHandler(forKey key: String) {
        handlers.setNilValueForKey(key)
    }
}

/*
 var block : @convention(block) (NSString!) -> Void = {
 (string : NSString!) -> Void in
 println("test")
 }
 
 ctx.setObject(unsafeBitCast(block, AnyObject.self), forKeyedSubscript: "test")
 http://stackoverflow.com/questions/24595692/swift-blocks-not-working
 */

/*
 class ClosureContainer {
 private var _closure: AnyObject
 
 init(closure: @escaping () -> Void) {
 self._closure = unsafeBitCast(closure as HandlerBlock, to: AnyObject.self)
 }
 
 var closure: () -> Void {
 return unsafeBitCast(_closure, to: HandlerBlock.self) as Handler
 }
 }
 */
