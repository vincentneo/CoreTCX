//
//  TCXPartNumber.swift
//  CoreTCX
//
//  Created by Vincent Neo on 20/4/2022.
//

import Foundation

/// The formatted XXX-XXXXX-XX Garmin part number of a PC application.
public struct TCXPartNumber: CustomStringConvertible {
    private let regexPattern = #"[\p{Lu}\d]{3}-[\p{Lu}\d]{5}-[\p{Lu}\d]{2}"#
    
    public var value: String
    public var description: String {
        return value
    }
    
    public init?(value: String) {
        let conformsToSchema = value.range(of: regexPattern, options: .regularExpression) != nil
        
        guard conformsToSchema else { return nil}
        self.value = value
    }
}
