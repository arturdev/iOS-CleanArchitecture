//
//  Created by Artur Mkrtchyan on 2/8/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import UIKit

fileprivate struct LocalizationKeys {
    static var LocaliziedKey = "localiziedKey"
}

extension UIBarItem {
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
        
        if localizedText == nil {
            localizedText = NSLocalizedString(self.title ?? "", comment: "")
        }
        UIView.setAnimationsEnabled(false)
        self.title = localizedText
        UIView.setAnimationsEnabled(true)
    }
}
