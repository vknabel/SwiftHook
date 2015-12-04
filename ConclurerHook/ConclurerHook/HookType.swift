//
//  HookType.swift
//  ConclurerHook
//
//  Created by Valentin Knabel on 17.09.15.
//  Copyright (c) 2015 Conclurer GmbH. All rights reserved.
//

/// This protocol marks hooks by type. Since there is no way to represent all different types of hooks with one protocol, you need to implement some additional methods. Please compare DelegationHook and SerialHook before implementing your own.
public protocol HookType {
    typealias RawKeyType: RawHookKeyType
    
    func add<A, R>(key key: HookKey<RawKeyType, A, R>, closure: A -> R) -> AnyObject?
    func perform<A, R>(key key: HookKey<RawKeyType, A, R>, argument: A) -> AnySequence<R>
}

/// Raw values for hook keys must conform to this protocol.
public protocol RawHookKeyType: Hashable { }
