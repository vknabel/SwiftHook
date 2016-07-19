//
//  Reference.swift
//  SwiftHook
//
//  Created by Valentin Knabel on 17.09.15.
//  Copyright (c) 2015 Valentin Knabe. All rights reserved.
//

class RawReference<T>: RawRepresentable {
    typealias RawValue = T
    let rawValue: RawValue
    
    required init?(rawValue: RawValue) {
        self.rawValue = rawValue
    }
}

class WeakReference<T> {
    weak var reference: RawReference<T>?
    
    init(reference: RawReference<T>) {
        self.reference = reference
    }
}
