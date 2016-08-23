//
//  UserDefaultsStubbed.swift
//  Invoke
//
//  Created by Gruppioni Michele on 15/08/16.
//
//

import Foundation

public class UserDefaultsStubbed : UserDefaults {
    
    var storedData = [String : Any]()
    
    public override var attributeKeys: [String] {
        return Array(storedData.keys)
    }
    
    public override func object(forKey defaultName: String) -> Any? {
        return storedData[defaultName]
    }
        
    public override func removeObject(forKey defaultName: String) {
        storedData.removeValue(forKey: defaultName)
    }
    
    public override func string(forKey defaultName: String) -> String? {
        return storedData[defaultName] as? String
    }
    
    public override func array(forKey defaultName: String) -> [Any]? {
        return storedData[defaultName] as? [Any]
    }

    public override func dictionary(forKey defaultName: String) -> [String : Any]? {
        return storedData[defaultName] as? [String : Any]
    }

    public override func data(forKey defaultName: String) -> Data? {
        return storedData[defaultName] as? Data
    }

    public override func stringArray(forKey defaultName: String) -> [String]? {
        return storedData[defaultName] as? [String]
    }

    public override func integer(forKey defaultName: String) -> Int {
        return storedData[defaultName] as? Int ?? 0
    }
    
    public override func float(forKey defaultName: String) -> Float {
        return storedData[defaultName] as? Float ?? 0.0
    }
    
    public override func double(forKey defaultName: String) -> Double {
        return storedData[defaultName] as? Double ?? 0.0
    }
    
    public override func bool(forKey defaultName: String) -> Bool {
        return storedData[defaultName] as? Bool ?? false
    }
    
    @available(OSX 10.6, *)
    public override func url(forKey defaultName: String) -> URL? {
        return storedData[defaultName] as? URL
    }
    
    public override func set(_ value: Any?, forKey defaultName: String) {
        storedData[defaultName] = value
    }
    
    public override func set(_ value: Int, forKey defaultName: String) {
        storedData[defaultName] = value
    }
    
    public override func set(_ value: Float, forKey defaultName: String) {
        storedData[defaultName] = value
    }
    
    public override func set(_ value: Double, forKey defaultName: String) {
        storedData[defaultName] = value
    }
    
    public override func set(_ value: Bool, forKey defaultName: String) {
        storedData[defaultName] = value
    }
    
    @available(OSX 10.6, *)
    public override func set(_ url: URL?, forKey defaultName: String) {
        storedData[defaultName] = url
    }
    
    public override func dictionaryRepresentation() -> [String : Any] {
        return storedData
    }
    
    public override func synchronize() -> Bool {
        return true
    }
}
