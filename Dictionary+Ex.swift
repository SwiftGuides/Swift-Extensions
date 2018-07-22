//
//  Dictionary+Ex.swift
//
//  Created by Augus on 7/22/18.
//  Copyright © 2018 iAugus. All rights reserved.
//

import Foundation

func += <K, V> (lhs: inout [K: V], rhs: [K: V]) {
    for (k, v) in rhs {
        lhs[k] = v
    }
}

func + (_ lhs: [String: Any], _ rhs: [String: Any]) -> [String: Any] {
    return [rhs].reduce(lhs, +)
}
