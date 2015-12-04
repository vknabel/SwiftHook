//
//  DelegationHook.swift
//  ConclurerHook
//
//  Created by Valentin Knabel on 17.09.15.
//  Copyright (c) 2015 Conclurer GmbH. All rights reserved.
//

/// Hook with from 0 to 1 closures per hook key. An array of return values will be returned.
public class DelegationHook<T: RawHookKeyType>: HookType {
    
    public typealias RawKeyType = T
    
    private var closures: [T: Any]
    
    public init() {
        self.closures = [:]
    }
    
    /// Adds a closure for the given key.
    ///
    /// - parameter key: The hook key with the appropriate type information. Should be save statically.
    /// - parameter closure: The closure to be performed when the hook key will be performed.
    public func add<A, R>(key key: HookKey<T, A, R>, closure: A -> R) -> AnyObject? {
        closures[key.rawValue] = closure as Any
        return nil
    }
    
    /// Performs all closures for the given key.
    ///
    /// - parameter key: The hook key with the appropriate type information. Should be save statically.
    /// - parameter arguments: The arguments passed for each closure for the given hook key.
    /// - returns: Returns the mapped value if closure is available.
    public func perform<A, R>(key key: HookKey<T, A, R>, argument: A) -> AnySequence<R> {
        if let c = closures[key.rawValue] as? A -> R {
            return AnySequence(GeneratorOfOne(c(argument)))
        }
        return AnySequence(GeneratorOfOne(nil))
    }
    
}
