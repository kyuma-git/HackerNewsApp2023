//
//  UnixTimeConverter.swift
//  Utility
//
//  Created by Kyuma Morita on 2023/12/26.
//

public struct UnixTimeConverter {
    public init() {}

    // Convert Unix timestamp to Date
    public func convertToDate(from unixTimestamp: TimeInterval) -> Date {
        return Date(timeIntervalSince1970: unixTimestamp)
    }
}
