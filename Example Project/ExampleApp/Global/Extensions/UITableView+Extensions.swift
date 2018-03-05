//
//  Created by Artur Mkrtchyan on 2/7/18.
//  Copyright © 2018 Develandoo. All rights reserved.
//

import Foundation
import UIKit


protocol ReusableCell: class {
    static var nibName: String { get }
    static var reuseIdentifier: String { get }
}

extension ReusableCell where Self: UIView {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension UITableViewCell: ReusableCell {}


extension UITableView {
    
    func register<T: ReusableCell>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
        var nibName = isIpad ? (T.nibName + "~iPad") : T.nibName
        if let _ = bundle.path(forResource: nibName, ofType: "nib") {
        } else {
            nibName = T.nibName
        }
        let nib = UINib.init(nibName: nibName, bundle: bundle)
        
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: ReusableCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

extension UIView {
    func parentView<T: UIView>(of type: T.Type) -> T? {
        guard let view = self.superview else {
            return nil
        }
        return (view as? T) ?? view.parentView(of: T.self)
    }
}

extension UITableViewCell {
    var parentTableView: UITableView? {
        return self.parentView(of: UITableView.self)
    }
    
    var ip: IndexPath? {
        return parentTableView?.indexPath(for: self)
    }
}
