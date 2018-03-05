//
//  RepoCellViewModelling.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation

protocol RepoCellViewModelling {
    var name: String? {get}
    var fullName: String? {get}
    var owner: User? {get}
    var descr: String? {get}
    var starsCount: String? {get}
    var watchersCount: String? {get}
    var forksCount: String? {get}
    var openIssuesCount: String? {get}
}
