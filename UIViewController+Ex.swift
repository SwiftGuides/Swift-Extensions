//
//  UIViewController+Ex.swift
//
//  Created by Augus on 9/30/15.
//  Copyright © 2015 iAugus. All rights reserved.
//

import UIKit


// MARK: - 

extension UIViewController {

    var isModal: Bool {
        if presentingViewController != nil {
            return true
        } else if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        return false
    }
}


// MARK: - Top bar (status bar + navigation bar)

extension UIViewController {
    
    var statusBarFrame: CGRect {
        return view.window?.convert(UIApplication.shared.statusBarFrame, to: view) ?? CGRect.zero
    }
    
    var topBarHeight: CGFloat {
        var navBarHeight: CGFloat {
            guard let bar = navigationController?.navigationBar else { return 0 }
            return view.window?.convert(bar.frame, to: view).height ?? 0
        }
        let statusBarHeight = view.window?.convert(UIApplication.shared.statusBarFrame, to: view).height ?? 0
        return statusBarHeight + navBarHeight
    }
    
    /**
     While trying to present a new controller, current controller' bar may disappear temporary.
     But I still need the real height of top bar.
     - Why not set a constant (64.0 or 32.0)? Apple may change the constant in some device in the future.
    */
    func topBarHeightWhenTemporaryDisappear() -> CGFloat {
        let key = "kASTopBarHeightWhenTemporaryDisappear"
        if UserDefaults.standard.value(forKey: key) == nil {
            UserDefaults.standard.setValue(topBarHeight, forKey: key)
        }
        else if topBarHeight != 0 && topBarHeight != UserDefaults.standard.value(forKey: key) as! CGFloat {
            UserDefaults.standard.setValue(topBarHeight, forKey: key)
        }
        return UserDefaults.standard.value(forKey: key) as! CGFloat
    }
    
}


// MARK: - Keyboard notification

extension UIViewController {
    func keyboardWillChangeFrameNotification(_ notification: Notification, scrollBottomConstant: NSLayoutConstraint) {
        let duration = (notification as NSNotification).userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber
        let curve = (notification as NSNotification).userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber
        let keyboardBeginFrame = ((notification as NSNotification).userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let keyboardEndFrame = ((notification as NSNotification).userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let screenHeight = UIScreen.main.bounds.height
        let isBeginOrEnd = keyboardBeginFrame.origin.y == screenHeight || keyboardEndFrame.origin.y == screenHeight
        
        let offset: CGFloat

        #if swift(>=3.2)
            if #available(iOS 11.0, *) {
                offset = additionalSafeAreaInsets.bottom
            } else {
                offset = bottomLayoutGuide.length
            }
        #else
            offset = bottomLayoutGuide.length
        #endif

        let heightOffset = keyboardBeginFrame.origin.y - keyboardEndFrame.origin.y - (isBeginOrEnd ? offset : 0)
        
        UIView.animate(withDuration: duration.doubleValue,
            delay: 0,
            options: UIView.AnimationOptions(rawValue: UInt(curve.intValue << 16)),
            animations: { () in
                scrollBottomConstant.constant = scrollBottomConstant.constant + heightOffset
                self.view.layoutIfNeeded()
            },
            completion: nil
        )
    }
    
}


// MARK: - Dismiss view controller

extension UIViewController {

    @IBAction func dismissAnimated() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissWithoutAnimation() {
        dismiss(animated: false, completion: nil)
    }

    @IBAction func popViewControllerAnimated() {
        _ = navigationController?.popViewController(animated: true)
    }

    @IBAction func popViewControllerWithoutAnimation() {
        _ = navigationController?.popViewController(animated: false)
    }
}


// MARK: - 

extension Selector {
    static let dismissAnimated                   = #selector(UIViewController.dismissAnimated)
    static let dismissWithoutAnimation           = #selector(UIViewController.dismissWithoutAnimation)
    static let popViewControllerAnimated         = #selector(UIViewController.popViewControllerAnimated)
    static let popViewControllerWithoutAnimation = #selector(UIViewController.popViewControllerWithoutAnimation)
}


// MAEK: - Edge dismiss gesture

extension UIViewController {
    
    func configureScreenEdgeDismissGesture(_ edges: UIRectEdge = .left, animated: Bool = true, alsoForPad: Bool = true) {
        let action = animated ? #selector(dismissAnimated) : #selector(dismissWithoutAnimation)
        configureScreenEdgeGestures(edges, alsoForPad: alsoForPad, action: action)
    }

    func configureScreenEdgePopGesture(_ edges: UIRectEdge = .left, animated: Bool = true, alsoForPad: Bool = true) {
        let action = animated ? #selector(popViewControllerAnimated) : #selector(popViewControllerWithoutAnimation)
        configureScreenEdgeGestures(edges, alsoForPad: alsoForPad, action: action)
    }

    func configureScreenEdgeGestures(_ edges: UIRectEdge = .left, alsoForPad: Bool = true, action: Selector) {

        if UIDevice.current.userInterfaceIdiom == .pad && !alsoForPad { return }

        view.isUserInteractionEnabled = true

        func left() {
            let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: action)
            gesture.edges = .left
            view.addGestureRecognizer(gesture)
        }

        func right() {
            let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: action)
            gesture.edges = .right
            view.addGestureRecognizer(gesture)
        }

        if edges == .left {
            left()
        } else if edges == .right {
            right()
        } else if edges == [.left, .right] {
            left()
            right()
        }
    }

    /// one of these two parameters must not be nil
    func configureEdgeGestures(leftEdgeAction: Selector? = nil, rightEdgeAction: Selector? = nil, alsoForPad: Bool = true) {
        if let la = leftEdgeAction {
            configureScreenEdgeGestures(.left, alsoForPad: alsoForPad, action: la)
        }
        if let ra = rightEdgeAction {
            configureScreenEdgeGestures(.right, alsoForPad: alsoForPad, action: ra)
        }
    }
}
