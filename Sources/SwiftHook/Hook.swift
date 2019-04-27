//
//  HookType.swift
//  SwiftHook
//
//  Created by Valentin Knabel on 17.09.15.
//  Copyright (c) 2015 Valentin Knabe. All rights reserved.
//

/// This protocol marks hooks by type. Since there is no way to represent all different types of hooks with one protocol, you need to implement some additional methods. Please compare DelegationHook and SerialHook before implementing your own.
public protocol Hook {
    associatedtype Action: HookAction

    func respond<A, R>(to event: HookEvent<Action, A, R>, with action: @escaping (A) -> R) -> AnyObject?
    func trigger<A, R>(event: HookEvent<Action, A, R>, with argument: A) -> [R]
}

/// Raw values for hook keys must conform to this protocol.
public protocol HookAction: Hashable {}
