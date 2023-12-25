//
//  Calendar+Extension.swift
//  Utility
//
//  Created by Kyuma Morita on 2023/12/26.
//

public extension Calendar {
    static var localized: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale.current
        calendar.timeZone = TimeZone.current
        return calendar
    }()
}
