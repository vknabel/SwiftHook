//
//  ConclurerHookTests.swift
//  ConclurerHookTests
//
//  Created by Valentin Knabel on 17.09.15.
//  Copyright (c) 2015 Conclurer GmbH. All rights reserved.
//

import Foundation
import XCTest
import ConclurerHook

private enum RawKey: RawHookKeyType {
    case Default
}

class ConclurerHookTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDelegationHook() {
        let hook: DelegationHook<RawKey> = DelegationHook()
        let key: HookKey<RawKey, (), ()> = HookKey(rawValue: .Default)
        var calledFirst = 0
        hook.add(key: key, closure: { calledFirst++ })
        var calledSecond = 0
        hook.add(key: key, closure: { calledSecond++ })
        hook.perform(key: key, argument: ())
        XCTAssertEqual(0, calledFirst, "Should never call old closure.")
        XCTAssertEqual(1, calledSecond, "Should call new closure once.")
    }
    
    func testSerialHook() {
        let hook: SerialHook<RawKey> = SerialHook()
        let key: HookKey<RawKey, (), ()> = HookKey(rawValue: .Default)
        var calledFirst = 0
        var ref1: AnyObject? = hook.add(key: key, closure: { calledFirst++ })
        _ = ref1
        var calledSecond = 0
        var ref2: AnyObject? = hook.add(key: key, closure: { calledSecond++ })
        _ = ref2
        hook.perform(key: key, argument: ())
        XCTAssertEqual(1, calledFirst, "Should call old closure once.")
        XCTAssertEqual(1, calledSecond, "Should call new closure once.")
        ref1 = nil
        ref2 = nil
        XCTAssertEqual(1, calledFirst, "Freed closures should never be called.")
        XCTAssertEqual(1, calledSecond, "Freed closures should never be called.")
    }
    
}
