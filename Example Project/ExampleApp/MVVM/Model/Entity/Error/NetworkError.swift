//
//  NetworkError.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/2/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper

typealias NetworkError = MoyaError
extension NetworkError {
    var message: String? {
        guard let response = response else {
            return nil
        }
        return try? response.mapString(atKeyPath: "message")
    }
}
