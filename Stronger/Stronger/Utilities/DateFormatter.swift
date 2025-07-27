//
//  DateFormatter.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 27/07/2025.
//

import Foundation

func isoDateOnly(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter.string(from: date)
}
