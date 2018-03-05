//
//  Created by Artur Mkrtchyan on 2/7/18.
//  Copyright © 2018 Develandoo. All rights reserved.
//

import UIKit

fileprivate struct LocalizationKeys {
    static var LocaliziedKey = "localiziedKey"
}

extension UIView {
    @objc var localiziedKey: String? {
        get {
            return objc_getAssociatedObject(self, &LocalizationKeys.LocaliziedKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &LocalizationKeys.LocaliziedKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            localize()
        }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        localize()
    }
    
    func localize() {
        var localizedText: String? = nil
        if let localiziedKey = self.localiziedKey {
            localizedText = NSLocalizedString(localiziedKey, comment: "")
        }
        
        switch self {
        case let label as UILabel:
            if localizedText == nil {
                localizedText = NSLocalizedString(label.text ?? "", comment: "")
            }
            label.text = localizedText
        case let textField as UITextField:
            if localizedText == nil {
                localizedText = NSLocalizedString(textField.placeholder ?? "", comment: "")
            }
            textField.placeholder = localizedText
        case let textView as UITextView:
            if localizedText == nil {
                localizedText = NSLocalizedString(textView.text ?? "", comment: "")
            }
            textView.text = localizedText
        case let button as UIButton:
            if localizedText == nil {
                if (button.titleLabel?.text ?? "").isEmpty {
                    return
                }
                localizedText = NSLocalizedString(button.titleLabel?.text ?? "", comment: "")
            }
            UIView.setAnimationsEnabled(false)
            button.setTitle(localizedText, for: .normal)
            UIView.setAnimationsEnabled(true)
        case let navigationBar as UINavigationBar:
            if localizedText == nil {
                localizedText = NSLocalizedString(navigationBar.topItem?.title ?? "", comment: "")
            }
            navigationBar.topItem?.title = localizedText
        default:
            break
        }
    }
}
