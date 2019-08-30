//
//  TCXCommonTypes.swift
//  CoreTCX
//
//  Created by Vincent on 24/8/19.
//

import Foundation

public final class TCXWeek: TCXElement {
    var startDay: Date?
    var notes: String?
    var extensions: TCXExtensions?
}

open class TCXExtensions: TCXElement {
    
}

typealias TCXRestrictedToken = String
typealias TCXActivityReference = Date
