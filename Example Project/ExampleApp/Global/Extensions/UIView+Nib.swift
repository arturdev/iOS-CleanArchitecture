//
//  UIView+Nib.swift
//  StoryBook
//
//  Created by Artur Mkrtchyan on 2/7/18.
//  Copyright © 2018 Develandoo. All rights reserved.
//

import UIKit

extension UIView {
    /**
       Call this method to instantiate an instance of Self's class from the xib of same name.
     
       Usage:
       ```
       let view = MyCustomView.loadFromNib()
       ```
     - returns: An object of type MyCustomView from MyCustomView.xib file
    */
    static func loadFromNib() -> Self {
        func instanceFromNib<T: UIView>() -> T {
            let bundle = Bundle(for: T.self)
            let name = T.self.description().components(separatedBy: ".").last ?? ""
            guard let view = bundle.loadNibNamed(name, owner: nil, options: nil)?.flatMap({ $0 as? T }).last else {
                return T()
            }
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            return view
        }
        
        return instanceFromNib()
    }
}
