//
//  InvokeEveryTests.swift
//  Invoke
//
//  Created by Gruppioni Michele on 23/08/16.
//
//

import XCTest
@testable import Invoke

class InvokeEveryTests: XCTestCase {
    
    func testBase() {
        let timer = Invoke.every(label: "suca", 0.1) {
            print("Suca2")
        }
        
        timer.start()
        
        sleep(1)
        print("Aaaaasasajchgsidvghdivehfivuehivuehvlehvoeuywghvoeiruygvhieuyhvieuyohvuyiehvfiephvihpfipvuhirpuwvbhwipfhebvihpw")
        
        sleep(1)
        print("Aaaaasasajchgsidvghdivehfivuehivuehvlehvoeuywghvoeiruygvhieuyhvieuyohvuyiehvfiephvihpfipvuhirpuwvbhwipfhebvihpw")
        
        sleep(1)
        print("Aaaaasasajchgsidvghdivehfivuehivuehvlehvoeuywghvoeiruygvhieuyhvieuyohvuyiehvfiephvihpfipvuhirpuwvbhwipfhebvihpw")
    }
    
    func testA() {
        print("Aaaaasasajchgsidvghdivehfivuehivuehvlehvoeuywghvoeiruygvhieuyhvieuyohvuyiehvfiephvihpfipvuhirpuwvbhwipfhebvihpw")
        print("Aaaaasasajchgsidvghdivehfivuehivuehvlehvoeuywghvoeiruygvhieuyhvieuyohvuyiehvfiephvihpfipvuhirpuwvbhwipfhebvihpw")
        print("Aaaaasasajchgsidvghdivehfivuehivuehvlehvoeuywghvoeiruygvhieuyhvieuyohvuyiehvfiephvihpfipvuhirpuwvbhwipfhebvihpw")
        print("Aaaaasasajchgsidvghdivehfivuehivuehvlehvoeuywghvoeiruygvhieuyhvieuyohvuyiehvfiephvihpfipvuhirpuwvbhwipfhebvihpw")
    }
}
