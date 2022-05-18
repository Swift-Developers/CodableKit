//
//  Option.swift
//  Jsonable
//
//  Created by 方林威 on 2022/3/16.
//

import Foundation

protocol OptionConfigurable {
    static var options: [Option] { get set }
}

extension OptionConfigurable {
    static var options: [Option] { [] }
}

struct DefaultOptions: OptionConfigurable {
    static var options: [Option] = [
        .init(Int.self),
        .init(String.self),
        .init(Bool.self),
        .init(Double.self),
    ]
}

struct Option {
    internal var type: AnyCodable.Type
    init(_ type: AnyCodable.Type) {
        self.type = type
    }
}

extension Option {
    func decode(container: inout UnkeyedDecodingContainer) -> AnyCodable? {
        return type.decode(container: &container)
    }
    func decode(container: inout SingleValueDecodingContainer) -> AnyCodable? {
        return type.decode(container: &container)
    }
}
