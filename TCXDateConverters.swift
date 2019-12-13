//
//  TCXDateConverters.swift
//  CoreTCX
//
//  Created by Vincent on 13/12/19.
//

import Foundation

class DateConvert {
    // MARK:- Date & Time Formatting
    
    enum types {
        case ISO8601
        case day
    }
    
    // base formatter
    private static let formatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        return df
    }()
    
    /// ISO8601 formatter within CoreTCX.
    private static let ISO8601Formatter: DateFormatter = {
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
    
    /// Day
    private static let dayFormatter: DateFormatter = {
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    /// For conversion from optional `Date` to optional `String`
    ///
    /// - Parameters:
    ///     - date: can be of any date and time, which will be converted to a formatted ISO8601 date and time string.
    ///
    /// - Returns:
    ///     Formatted string according to ISO8601, which is of **"yyyy-MM-ddTHH:mm:ssZ"**
    ///
    /// This method is currently heavily used for generating of GPX files / formatted string, as the native `Date` type must be converted to a `String` first.
    ///
    static func toString(with type: types, from dateTime: Date?) -> String? {
        
        guard let validDate = dateTime else {
            return nil
        }
        
        switch type {
        case .ISO8601: return ISO8601Formatter.string(from: validDate)
        case .day: return dayFormatter.string(from: validDate)
        }
    }

}
