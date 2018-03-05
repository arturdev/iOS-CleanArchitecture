//
//  Configs.swift
//  StoryBook
//
//  Created by Artur Mkrtchyan on 2/2/18.
//  Copyright © 2018 Develandoo. All rights reserved.
//

import Foundation

// All configuration variables based on the variety of environments must be placed here

enum Environment {
    case debug
    case release
    case stagingDebug
    case stagingRelease
    case appstore
}

struct Config {
    static let env: Environment = {
        #if STAGING_DEBUG
            return .stagingDebug
        #elseif STAGING_RELEASE
            return .stagingRelease
        #elseif APPSTORE
            return .appstore
        #elseif DEBUG
            return .debug
        #elseif RELEASE
            return .release
        #endif
    }()
    
    static let apiBaseUrl: String = {
        switch env {
        case .debug,
             .stagingDebug:
            return "https://api.github.com"
        case .stagingRelease,
             .appstore,
             .release:
            return "https://api.github.com"
        }
    }()
}
