//
//  RXSwift+Extensions.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/4/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol OptionalType {
    associatedtype Wrapped
    
    var optional: Wrapped? { get }
}

extension Optional: OptionalType {
    
    public var optional: Wrapped? { return self }
    public var notNil: Bool {
        return self != nil
    }
    public var isNil: Bool {
        return self == nil
    }
}

extension Observable where Element: OptionalType {
    
    func ignoreNil() -> Observable<Element.Wrapped> {
        return flatMap { value in
            value.optional.map { Observable<Element.Wrapped>.just($0) } ?? Observable<Element.Wrapped>.empty()
        }
    }
}

extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy, E: OptionalType {
    func ignoreNil() -> Driver<E.Wrapped> {
        return flatMap { value in
            value.optional.map { Driver<E.Wrapped>.just($0) } ?? Driver<E.Wrapped>.empty()
        }
    }
}
