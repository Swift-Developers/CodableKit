//
//  AnyCodable+Extension.swift
//  Jsonable
//
//  Created by 方林威 on 2022/3/16.
//

import Foundation

protocol AnyCodable: Codable { }

extension AnyCodable {
    static private func typed() -> Self.Type {
        Self.self
    }
    /// It will return its pure type that conforms to `AnyCodable`.
    /// - Returns: Type that conforms to `AnyCodable`
    func type() -> Self.Type {
        Swift.type(of: self)
    }
    static func decode(container: inout UnkeyedDecodingContainer) -> Self? {
        guard let decoded = try? container.decode(self.typed()) else {
            return nil
        }
        return decoded
    }
    static func decode(container: inout SingleValueDecodingContainer) -> Self? {
        guard let decoded = try? container.decode(self.typed()) else {
            return nil
        }
        return decoded
    }
    
    func encode(container: inout UnkeyedEncodingContainer) throws {
        try container.encode(self)
    }
    func encode(container: inout SingleValueEncodingContainer) throws {
        try container.encode(self)
    }
}

protocol DefaultCodable: AnyCodable {
    init()
}
// MARK: - Default
extension Int: DefaultCodable { }
extension String: DefaultCodable { }
extension Double: DefaultCodable { }
extension Bool: DefaultCodable { }
extension Float: DefaultCodable { }

// MARK: - Collection
extension Array: AnyCodable where Element: AnyCodable { }
extension Dictionary: AnyCodable where Key: Codable, Value: AnyCodable { }
extension Set: AnyCodable where Element: AnyCodable { }

// MARK: - Default Collection
extension Array: DefaultCodable where Element: AnyCodable { }
extension Dictionary: DefaultCodable where Key: Codable, Value: AnyCodable { }
extension Set: DefaultCodable where Element: AnyCodable { }
