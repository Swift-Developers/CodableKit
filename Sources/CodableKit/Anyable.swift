//
//  Anyable.swift
//  Jsonable
//
//  Created by 方林威 on 2022/3/16.
//

import Foundation

struct Anyable<P: OptionConfigurable>: Codable {
    var wrappedValue: Any
    init(wrappedValue: Any) {
        self.wrappedValue = wrappedValue
    }
    init(from decoder: Decoder) throws {
        var container = try decoder.singleValueContainer()
        var anyCodable: AnyCodable?
        for option in P.options {
            if let value = option.decode(container: &container) {
                anyCodable = value
                break
            }
        }
        if let value = anyCodable {
            wrappedValue = value
        } else {
            throw CodableXError.mismatch("\(P.self)")
        }
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        guard let value = wrappedValue as? AnyCodable else {
            return
        }
        try value.encode(container: &container)
    }
    var projectedValue: Any {
        wrappedValue
    }
}


