//
//  SerialHook.swift
//  SwiftHook
//
//  Created by Valentin Knabel on 17.09.15.
//  Copyright (c) 2015 Valentin Knabe. All rights reserved.
//

/// This hook accepts many closures and invokes them serial in the current queue.
public class SerialHook<T: HookAction>: Hook {
    /// The type defining valid raw values for keys.
    public typealias Action = T

    private var closures: [T: [AnyObject]]

    public init() {
        closures = [:]
    }

    /// Adds a closure for the given key.
    ///
    /// - parameter event: The hook key with the appropriate type information. Should be save statically.
    /// - parameter closure: The closure to be performed when the hook key will be performed.
    /// - returns: A weak referenced object that holds the closure.
    public func respond<A, R>(to event: HookEvent<Action, A, R>, with action: @escaping (A) -> R) -> AnyObject? {
        let ref = RawReference(rawValue: action)!
        let weak = WeakReference(reference: ref)
        if closures[event.action] != nil {
            closures[event.action]!.append(weak)
        } else {
            closures[event.action] = [weak]
        }
        return ref
    }

    /// Performs all closures for the given key.
    ///
    /// - parameter event: The hook event with the appropriate type information. Should be save statically.
    /// - parameter arguments: The arguments passed for each closure for the given hook key.
    /// - returns: Returns all mapped values. If a conflicting hook key is used an empty array will be returned.
    @discardableResult public func trigger<A, R>(event: HookEvent<Action, A, R>, with argument: A) -> [R] {
        let list: [R] = (closures[event.action] ?? []).compactMap {
            if let wr = $0 as? WeakReference<(A) -> R>,
                let v = wr.reference?.rawValue {
                return v(argument)
            }
            return nil
        }
        return list
    }
}
