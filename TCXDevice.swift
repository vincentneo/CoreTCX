//
//  TCXDevice.swift
//  CoreTCX
//
//  Created by Vincent Neo on 20/4/2022.
//

import Foundation

public struct TCXDevice: TCXAbstractSource {
    public var name: String
    public var unitId: UInt
    public var productId: UInt16
    public var version: TCXVersion
}
