//
//  Storyboards.swift
//  StoryBook
//
//  Created by Artur Mkrtchyan on 2/7/18.
//  Copyright © 2018 Develandoo. All rights reserved.
//

import UIKit

extension UIViewController {
    static func instantiate(from storyboard:Storyboards, identifier: String? = nil) -> Self {
        return instantiateFromStoryboard(storyboard.rawValue, identifier)
    }
}

enum Storyboards: String {
    case Main = "Main"
}
