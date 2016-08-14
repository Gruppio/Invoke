//
//  Invoke.swift
//  Invoke
//
//  Created by Gruppioni Michele on 14/08/16.
//
//

import Foundation

final class Invoke {
    private static var _invocations = [String : Int]()
    private static let syncronizationQueue = DispatchQueue(label: "com.gruppio.invoke")
    class var invocations: [String : Int] {
        get {
            return _invocations
        }
    }
    static var defaults: UserDefaults = UserDefaults.standard
}

extension Invoke {
    class func onceForAppLaunch(label: String, handler: () -> Void) -> () -> Void {
        return {
            guard let numberOfInvocations = Invoke.invocations[label] else { return }
            guard numberOfInvocations == 0 else { return }
            
            
        }
    }
}
