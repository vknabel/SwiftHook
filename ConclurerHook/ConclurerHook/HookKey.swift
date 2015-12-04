//
//  HookKey.swift
//  ConclurerHook
//
//  Created by Valentin Knabel on 17.09.15.
//  Copyright (c) 2015 Conclurer GmbH. All rights reserved.
//

/// Represents a key for hooks. Hook keys are meant to be stored statically with an extension for reuse.
/// Creating two hook keys with the same raw values but different types lead to undefined behavior.
public struct HookKey<RK: RawHookKeyType, AT, RT>: Hashable {
    /// The type for the raw value of a hook.
    public typealias RawValue = RK
    /// The type for a closure's arguments.
    public typealias ArgumentType = AT
    /// The type returned by closures.
    public typealias ReturnType = RT
    /// The type closures have to conform.
    public typealias ClosureType = AT -> RT
    
    /// The underlying raw value. Should be unique.
    public let rawValue: RawValue
    
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    public var hashValue: Int {
        return rawValue.hashValue
    }
}

public func ==<RK, AT, RT>(lhs: HookKey<RK, AT, RT>, rhs: HookKey<RK, AT, RT>) -> Bool {
    return lhs.rawValue == rhs.rawValue
}
