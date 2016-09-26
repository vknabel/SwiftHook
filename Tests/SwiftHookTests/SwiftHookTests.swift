//
//  SwiftHookTests.swift
//  SwiftHookTests
//
//  Created by Valentin Knabel on 17.09.15.
//  Copyright (c) 2015 Valentin Knabe. All rights reserved.
//

import Foundation
import XCTest
import SwiftHook

private enum RawKey: RawHookKeyType {
    case Default
}

class SwiftHookTests: XCTestCase {

    static var allTests: [(String, (TestCase) -> () -> ())] {
        return [
            ("testDelegationHook", testDelegationHook),
            ("testSerialHook", testSerialHook)
        ]
    }

    func testDelegationHook() {
        let hook: DelegationHook<RawKey> = DelegationHook()
        let key: HookKey<RawKey, (), ()> = HookKey(rawValue: .Default)
        var calledFirst = 0
        hook.add(key: key, with: { calledFirst += 1 })
        var calledSecond = 0
        hook.add(key: key, with: { calledSecond += 1 })
        hook.performAction(forKey: key, with: ())
        XCTAssertEqual(0, calledFirst, "Should never call old closure.")
        XCTAssertEqual(1, calledSecond, "Should call new closure once.")
    }

    func testSerialHook() {
        let hook: SerialHook<RawKey> = SerialHook()
        let key: HookKey<RawKey, (), ()> = HookKey(rawValue: .Default)
        var calledFirst = 0
        var ref1: AnyObject? = hook.add(key: key, with: { calledFirst += 1 })
        _ = ref1
        var calledSecond = 0
        var ref2: AnyObject? = hook.add(key: key, with: { calledSecond += 1 })
        _ = ref2
        hook.performAction(forKey: key, with: ())
        XCTAssertEqual(1, calledFirst, "Should call old closure once.")
        XCTAssertEqual(1, calledSecond, "Should call new closure once.")
        ref1 = nil
        ref2 = nil
        XCTAssertEqual(1, calledFirst, "Freed closures should never be called.")
        XCTAssertEqual(1, calledSecond, "Freed closures should never be called.")
    }

}
