//
//  UserCellViewModelling.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation

protocol UserCellViewModelling {
    var usernameForUI: String? {get}
    var username: String? {get}
    var avatarUrl: String? {get}
}
