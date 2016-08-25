//
//  Weak.swift
//  Invoke
//
//  Created by Gruppioni Michele on 24/08/16.
//
//

import Foundation

final class Weak<T: AnyObject> {
    weak var object: AnyObject?
    
    init(_ object: AnyObject) {
        self.object = object
    }
}
