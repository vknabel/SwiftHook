//
//  DelegationHook.swift
//  SwiftHook
//
//  Created by Valentin Knabel on 17.09.15.
//  Copyright (c) 2015 Valentin Knabe. All rights reserved.
//

/// Hook with from 0 to 1 closures per hook key. An array of return values will be returned.
public class DelegationHook<T: HookAction>: Hook {
    public typealias Action = T

    private var closures: [T: Any]

    public init() {
        closures = [:]
    }

    /// Adds a closure for the given key.
    ///
    /// - parameter event: The hook key with the appropriate type information. Should be save statically.
    /// - parameter closure: The closure to be performed when the hook key will be performed.
    @discardableResult public func respond<A, R>(to event: HookEvent<T, A, R>, with action: @escaping (A) -> R) -> AnyObject? {
        closures[event.action] = action as Any
        return nil
    }

    /// Performs all closures for the given key.
    ///
    /// - parameter event: The hook key with the appropriate type information. Should be save statically.
    /// - parameter arguments: The arguments passed for each closure for the given hook key.
    /// - returns: Returns the mapped value if closure is available.
    @discardableResult public func trigger<A, R>(event: HookEvent<T, A, R>, with argument: A) -> [R] {
        if let callback = closures[event.action] as? (A) -> R {
            return [callback(argument)]
        }
        return []
    }
}
