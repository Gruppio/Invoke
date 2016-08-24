//
//  InvocationCounter.swift
//  Invoke
//
//  Created by Gruppioni Michele on 14/08/16.
//
//

import Foundation

protocol InvocationCounter {
    var allInvocationsLabels: [String] { get }
    func numberOfInvocations(of label: String) -> Int
    func invoked(label: String)
    func reset()
}
