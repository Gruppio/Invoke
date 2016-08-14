//
//  InvocationCounter.swift
//  Invoke
//
//  Created by Gruppioni Michele on 14/08/16.
//
//

import Foundation

protocol InvocationCounter {
    func numberOfInvocations(of label: String) -> Int
    func allInvocationsLabels() -> [String]
    mutating func invoked(label: String)
    mutating func reset()
}
