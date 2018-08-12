//
//  UITableView+Ex.swift
//
//  Created by Augus on 1/7/17.
//  Copyright © 2017 iAugus. All rights reserved.
//

import UIKit

extension UITableView {

    func cellForRow(at location: CGPoint) -> UITableViewCell? {

        guard let indexPath = indexPathForRow(at: location) else { return nil }

        return cellForRow(at: indexPath)
    }
}

extension UITableView {

    func reloadData(with animation: UITableView.RowAnimation) {
        reloadSections(IndexSet(integersIn: 0 ..< numberOfSections), with: animation)
    }

    func reloadVisibleRows(with animation: UITableView.RowAnimation = .none) {
        
        guard let ips = indexPathsForVisibleRows else { return }

        reloadRows(at: ips, with: animation)
    }
}
