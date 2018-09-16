//
//  Comparable+Ex.swift
//
//  Created by Augus on 2018/8/8.
//  Copyright © 2018 iAugus. All rights reserved.
//

import Foundation

extension Comparable {
    func clamped(lower: Self, upper: Self) -> Self {
        return min(max(self, lower), upper)
    }
}
