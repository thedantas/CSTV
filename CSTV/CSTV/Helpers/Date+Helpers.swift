//
//  Date+Helper.swift
//  CSTV
//
//  Created by André  Costa Dantas on 01/09/24.
//

import Foundation

func formatDate(_ dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")

    guard let date = dateFormatter.date(from: dateString) else {
        return dateString
    }

    let outputFormatter = DateFormatter()
    outputFormatter.locale = Locale.current

    if Calendar.current.isDateInToday(date) {
        outputFormatter.dateFormat = "'Today' HH:mm"
    } else {
        outputFormatter.dateFormat = "EEEE HH:mm"
    }

    return outputFormatter.string(from: date)
}
