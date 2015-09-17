//
//  DelegationHook.swift
//  ConclurerHook
//
//  Created by Valentin Knabel on 17.09.15.
//  Copyright (c) 2015 Conclurer GmbH. All rights reserved.
//

import Foundation

/// Hook with from 0 to 1 closures per hook key. An array of return values will be returned.
public class DelegationHook<T: RawHookKeyType>: HookType {
    
    public typealias RawKeyType = T
    
    private var closures: [T: Any]
    
    public init() {
        self.closures = [:]
    }
    
    /// Adds a closure for the given key.
    ///
    /// :param: key The hook key with the appropriate type information. Should be save statically.
    /// :param: closure The closure to be performed when the hook key will be performed.
    public func add<A, R>(#key: HookKey<T, A, R>, closure: A -> R) -> () {
        closures[key.rawValue] = closure as Any
    }
    
    /// Performs all closures for the given key.
    ///
    /// :param: key The hook key with the appropriate type information. Should be save statically.
    /// :param: arguments The arguments passed for each closure for the given hook key.
    /// :returns: Returns the mapped value if closure is available.
    public func perform<A, R>(#key: HookKey<T, A, R>, argument: A) -> R? {
        if let c = closures[key.rawValue] as? A -> R {
            return c(arguments)
        }
        return nil
    }
    
}
