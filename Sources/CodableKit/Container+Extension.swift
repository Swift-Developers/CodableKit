//
//  Container+Extension.swift
//  Jsonable
//
//  Created by 方林威 on 2022/3/16.
//

import Foundation

extension UnkeyedEncodingContainer {
    mutating func encode(_ value: [Any]) throws {
        for v in value {
            if v is NSNull {
                try encodeNil()
            } else {
                try Jsonable(wrappedValue: v).encode(to: self.superEncoder())
            }
        }
    }
}

extension KeyedEncodingContainer where K == AnyCodingKey {
    mutating func encode(_ value: [String: Any]) throws {
        for (k, v) in value {
            let key = AnyCodingKey(stringValue: k)!
            if v is NSNull {
                try encodeNil(forKey: key)
            } else {
                try Jsonable(wrappedValue: v).encode(to: self.superEncoder(forKey: key))
            }
        }
    }
}

extension KeyedDecodingContainer {
    
    func decode(_ type: [String: Any].Type) throws -> [String: Any] {
        var dictionary: [String: Any] = [:]
        for key in allKeys {
            if let any = try? decode(Jsonable.self, forKey: key).wrappedValue {
                dictionary[key.stringValue] = any
            } else {
                dictionary[key.stringValue] = NSNull()
            }
        }
        return dictionary
    }
}
