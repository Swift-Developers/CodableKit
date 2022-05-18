//
//  Error.swift
//  Jsonable
//
//  Created by 方林威 on 2022/3/16.
//

import Foundation

public enum CodableXError: Error {
    case mismatch(String)
    case unableToForce(String)
}

extension CodableXError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .mismatch(let type):
            return "Uable to decode data into any of the options in \(type)"
        case .unableToForce(let type):
            return "Uable to force to \(type)"
        }
    }
}
