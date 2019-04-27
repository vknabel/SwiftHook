//
//  HookKey.swift
//  SwiftHook
//
//  Created by Valentin Knabel on 17.09.15.
//  Copyright (c) 2015 Valentin Knabe. All rights reserved.
//

/// Represents a key for hooks. Hook keys are meant to be stored statically with an extension for reuse.
/// Creating two hook keys with the same raw values but different types lead to undefined behavior.
public struct HookEvent<RK: HookAction, AT, RT>: Hashable {
    /// The action of a hook.
    public typealias Action = RK
    /// The type for a closure's arguments.
    public typealias ArgumentType = AT
    /// The type returned by closures.
    public typealias ReturnType = RT
    /// The type closures have to conform.
    public typealias ClosureType = (AT) -> RT

    /// The underlying raw value. Should be unique.
    public let action: Action

    public init(action: Action) {
        self.action = action
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(action)
    }
}

public func == <RK, AT, RT>(lhs: HookEvent<RK, AT, RT>, rhs: HookEvent<RK, AT, RT>) -> Bool {
    return lhs.action == rhs.action
}
