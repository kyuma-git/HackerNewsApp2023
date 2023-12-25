//
//  DatePresenter.swift
//  Utility
//
//  Created by Kyuma Morita on 2023/12/26.
//

public struct DatePresenter {
    public init(date: Date) {
        self.dateFormatter = DateFormatter()
        self.date = date
    }

    private let dateFormatter: DateFormatter
    private let date: Date
    private let locale = Calendar.localized.locale

    public var simpleDate: String {
        dateFormatter.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "MM/dd/yyyy",
            options: 0,
            locale: dateFormatter.locale
        )

        return dateFormatter.string(from: date)
    }
}
