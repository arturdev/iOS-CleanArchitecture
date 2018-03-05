//
//  Bundle+Localization.swift
//  ARCA
//
//  Created by Artur Mkrtchyan on 1/23/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation

enum AppLanguages: String {
    case russian = "ru-RU"
    case english = "en"
    case spanish = "sp"
    case italian = "es"
}

fileprivate struct AssociatedKeys {
    static var bundle = "_bundle"
}

fileprivate class BundleEx: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if let bundle = objc_getAssociatedObject(self, &AssociatedKeys.bundle) as? Bundle {
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        } else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
    }
}

extension Bundle {
    private class DispatchOnce {
        static let exchangeBundles: Any? = {object_setClass(Bundle.main, BundleEx.self)}()
    }
    
    static func setLanguage(_ language: AppLanguages) {
        setLanguage(language.rawValue)
    }
    
    static func setLanguage(_ name: String) {
        _ = DispatchOnce.exchangeBundles
        let path = Bundle.main.path(forResource: name, ofType: "lproj") ?? ""
        let value = Bundle(path: path)
        objc_setAssociatedObject(Bundle.main, &AssociatedKeys.bundle, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

