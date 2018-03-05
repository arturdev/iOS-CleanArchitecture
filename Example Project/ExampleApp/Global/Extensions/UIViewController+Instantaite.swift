//
//  UIViewController+Instantaite.swift
//  StoryBook
//
//  Created by Artur Mkrtchyan on 2/7/18.
//  Copyright © 2018 Develandoo. All rights reserved.
//

import UIKit

extension UIViewController {
    /**
        Usage:
        ```
        let vc = MyCustomViewController.instantiateFromStoryboard("MyStoryboard")
        ```
        - parameter name: Name of the storyboard from which you want to instantiate
        - returns: Object of type MyCustomViewController from MyStoryboard.storyboard file
     */
    static func instantiateFromStoryboard(_ name: String = "Main", _ identifier: String? = nil) -> Self {
        func instantiateFromStoryboardHelper<T>(_ name: String) -> T {
            let storyboard = UIStoryboard(name: name, bundle: nil)
            let id = identifier ?? String(describing: self)
            let controller = storyboard.instantiateViewController(withIdentifier: id) as! T
            return controller
        }
        return instantiateFromStoryboardHelper(name)
    }
}

