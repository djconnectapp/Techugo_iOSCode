//
//  DJConnectTests.swift
//  DJConnectTests
//
//  Created by My Mac on 18/05/21.
//  Copyright © 2021 mac. All rights reserved.
//

import XCTest
@testable import DJConnect

class DJConnectTests: XCTestCase {
    
    func TestString() {
        let sb = UIStoryboard(name: "SignIn", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "SignInVC") as! SignInVC
        var result = vc.validateName(_name: "abcd")
        XCTFail("Result: \(result)")
    }
}
