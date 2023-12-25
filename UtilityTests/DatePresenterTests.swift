//
//  DatePresenterTests.swift
//  UtilityTests
//
//  Created by Kyuma Morita on 2023/12/26.
//

import XCTest
@testable import Utility

class DatePresenterTests: XCTestCase {
    let tzUS = TimeZone(identifier: "UTC-0800")!
    let tzJP = TimeZone(identifier: "UTC+0900")!

    let loc_en_US = Locale(identifier: "en_US")
    let loc_en_JP = Locale(identifier: "en_JP")

    /// Saturday, December 31, 2022 at 5:30:00 PM GMT+00:00
    let date = Date(timeIntervalSince1970: 1672507800)

    var usEnUs: DatePresenter {
        return DatePresenter(date: date, calendar: localizedCalendarFor(timeZone: tzUS, locale: loc_en_US))
    }

    var usEnJP: DatePresenter {
        return DatePresenter(date: date, calendar: localizedCalendarFor(timeZone: tzUS, locale: loc_en_JP))
    }

    var jpEnUs: DatePresenter {
        return DatePresenter(date: date, calendar: localizedCalendarFor(timeZone: tzJP, locale: loc_en_US))
    }

    var jpEnJP: DatePresenter {
        return DatePresenter(date: date, calendar: localizedCalendarFor(timeZone: tzJP, locale: loc_en_JP))
    }

    private func localizedCalendarFor(timeZone: TimeZone, locale: Locale) -> Calendar {
        var cal = Calendar.localized
        cal.timeZone = timeZone
        cal.locale = locale
        return cal
    }

    func testSimpleDate() {
        XCTAssertEqual(usEnUs.simpleDate, "12/31/2022")
        XCTAssertEqual(usEnJP.simpleDate, "2022/12/31")
        XCTAssertEqual(jpEnUs.simpleDate, "01/01/2023")
        XCTAssertEqual(jpEnJP.simpleDate, "2023/01/01")
    }
}
