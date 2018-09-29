//
//  String+Calculator.swift
//
//  Created by WangLei on 2018/8/14.
//  Copyright © 2018 HappyIterating. All rights reserved.
//

import UIKit

extension String {
    
    func size(for font: UIFont) -> CGSize {
        return (self as NSString).boundingRect(with: .zero,
                                               options: .usesLineFragmentOrigin,
                                               attributes: [NSAttributedString.Key.font: font],
                                               context: nil).size
    }
}
