//
//  TCXApplication.swift
//  CoreTCX
//
//  Created by Vincent Neo on 20/4/2022.
//

import Foundation

public struct TCXApplication: TCXAbstractSource {
    public var name: String
    public var build: TCXBuild
    public var languageId: TCXLangId
    public var partNumber: TCXPartNumber
    
}

public typealias TCXLangId = String // NOTE: max char 2
