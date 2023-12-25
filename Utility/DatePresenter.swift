//
//  DatePresenter.swift
//  Utility
//
//  Created by Kyuma Morita on 2023/12/26.
//

public struct DatePresenter {
    private let dateFormatter: DateFormatter
    private let date: Date
    private let calendar: Calendar

    public init(date: Date, calendar: Calendar = Calendar.localized) {
        self.dateFormatter = DateFormatter()
        self.date = date
        self.calendar = calendar
        self.dateFormatter.timeZone = calendar.timeZone
    }

    public var simpleDate: String {
        dateFormatter.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "MM/dd/yyyy",
            options: 0,
            locale: calendar.locale
        )

        dateFormatter.calendar = calendar

        return dateFormatter.string(from: date)
    }
}
