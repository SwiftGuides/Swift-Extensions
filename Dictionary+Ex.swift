//
//  Dictionary+Ex.swift
//
//  Created by Augus on 7/22/18.
//  Copyright © 2018 iAugus. All rights reserved.
//

import Foundation

// MARK: - Combine two dictionary

/* or just use reduce 😄
 let d1: [String: Any] = [:]
 let d2: [String: Any] = [:]
 let d3 = [d1, d2].reduce([:], +)
 */

func += <K, V> (lhs: inout [K: V], rhs: [K: V]) {
    for (k, v) in rhs {
        lhs[k] = v
    }
}

func + (_ lhs: [String: Any], _ rhs: [String: Any]) -> [String: Any] {
    var temp = lhs
    temp += rhs
    return temp
}
