//
//  File.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation
import RxCocoa

protocol BaseViewModelling {
    var title: String? {get}
    var showLoading: BehaviorRelay<Bool> {get}    
    var error: BehaviorRelay<NetworkError?> {get}
}
