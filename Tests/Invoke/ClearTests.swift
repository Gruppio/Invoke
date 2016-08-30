import XCTest
@testable import Invoke

class ClearTests: XCTestCase {
  
  var obj: KeychainSwift!
  
  override func setUp() {
    super.setUp()
    
    obj = KeychainSwift(keyPrefix:"tests")
  }
  
  func testClear() {
    obj.set("hello :)", forKey: "key 1")
    obj.set("hello two", forKey: "key 2")
    
    obj.delete("key 1")
    obj.delete("key 2")
    
    obj.clear()
    
    XCTAssert(obj.getString("key 1") == nil)
    XCTAssert(obj.getString("key 2") == nil)
  }
}

