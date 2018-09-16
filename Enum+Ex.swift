//
//  Enum+Ex.swift
//
//  Created by Augus on 11/18/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

import Foundation

@available(iOS, deprecated, message: "please use: allCases instead")
func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
    var i = 0
    return AnyIterator {
        let next = withUnsafePointer(to: &i) {
            $0.withMemoryRebound(to: T.self, capacity: 1) { $0.pointee }
        }
        if next.hashValue != i { return nil }
        i += 1
        return next
    }
}
