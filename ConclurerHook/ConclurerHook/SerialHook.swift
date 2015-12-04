//
//  SerialHook.swift
//  ConclurerHook
//
//  Created by Valentin Knabel on 17.09.15.
//  Copyright (c) 2015 Conclurer GmbH. All rights reserved.
//

/// This hook accepts many closures and invokes them serial in the current queue.
public class SerialHook<T: RawHookKeyType>: HookType {
    
    /// The type defining valid raw values for keys.
    public typealias RawKeyType = T
    
    private var closures: [T: [AnyObject]]
    
    public init() {
        self.closures = [:]
    }
    
    /// Adds a closure for the given key.
    ///
    /// - parameter key: The hook key with the appropriate type information. Should be save statically.
    /// - parameter closure: The closure to be performed when the hook key will be performed.
    /// - returns: A weak referenced object that holds the closure.
    public func add<A, R>(key key: HookKey<RawKeyType, A, R>, closure: A -> R) -> AnyObject? {
        let ref = RawReference(rawValue: closure)!
        let weak = WeakReference(reference: ref)
        if closures[key.rawValue] != nil {
            closures[key.rawValue]!.append(weak)
        } else {
            closures[key.rawValue] = [weak]
        }
        return ref
    }
    
    /// Performs all closures for the given key.
    ///
    /// - parameter key: The hook key with the appropriate type information. Should be save statically.
    /// - parameter arguments: The arguments passed for each closure for the given hook key.
    /// - returns: Returns all mapped values. If a conflicting hook key is used an empty array will be returned.
    public func perform<A, R>(key key: HookKey<RawKeyType, A, R>, argument: A) -> AnySequence<R> {
        let list: [R] = (closures[key.rawValue] ?? []).reduce([]) {
            if let wr = $1 as? WeakReference<A -> R>,
                let v = wr.reference?.rawValue
            {
                return $0 + [v(argument)]
            }
            return $0
        }
        return AnySequence(list)
    }
      
}
