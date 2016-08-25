//
//  HandlersContainer.swift
//  Invoke
//
//  Created by Gruppioni Michele on 24/08/16.
//
//

import Foundation

protocol HandlersContainer {
    func getHandler(forKey key: String) -> (() -> Void)?
    func add(handler: @escaping () -> Void, forKey key: String)
    func removeHandler(forKey key: String)
}
