//
//  TCXElement.swift
//  CoreTCX
//
//  Created by Vincent on 24/8/19.
//  Original code from CoreGPX.
//

import Foundation

/**
 A root class for all element types
 
 All element types such as waypoints, tracks or routes are subclasses of `GPXElement`.
 This class brings important methods that aids towards creation of a GPX file.
 
 - Note:
 This class should not be used as is. To use its functionalities, please subclass it instead.
 */
//private var tcx = String()
private class TCXElementString {
    var contents = String()
}
public protocol TCXPublicElement {
    func tcxFormatted() -> String
    
}

protocol TCXElement: TCXPublicElement {
    //var tcx: String { get set }
    func tagName() -> String
    func addOpenTag(toTCX: inout String, indentationLevel: Int)
    func addChildTag(toTCX: inout String, indentationLevel: Int)
    func addCloseTag(toTCX: inout String, indentationLevel: Int)
}

extension TCXElement {
    //public init() { self.init() }
    
    public func tcxFormatted() -> String {
        var str = TCXElementString().contents
        self.tcxTagging(&str, indentationLevel: 0)
        return str as String
    }
    
    /// A method for invoking all tag-related methods
    func tcxTagging(_ tcx: inout String, indentationLevel: Int) {
        self.addOpenTag(toTCX: &tcx, indentationLevel: indentationLevel)
        self.addChildTag(toTCX: &tcx, indentationLevel: indentationLevel + 1)
        self.addCloseTag(toTCX: &tcx, indentationLevel: indentationLevel)
    }
    
    /// Implements an open tag
    ///
    /// An open tag is added to overall gpx content.
    ///
    /// - Parameters:
    ///     - gpx: the GPX string
    ///     - indentationLevel: the amount of indentation required to add for the tag
    /// - **Example**:
    ///
    ///         <trk> // an open tag
    ///         <wpt lat=1.0 lon=2.0> // an open tag with extra attributes
    func addOpenTag(toTCX tcx: inout String, indentationLevel level: Int) {
        tcx.append(String(format: "%@<%@>\r\n", indent(level: level), self.tagName()))
    }
    
    /// Implements a child tag after an open tag, before a close tag.
    ///
    /// An child tag is added to overall gpx content.
    ///
    /// - Parameters:
    ///     - gpx: the GPX string
    ///     - indentationLevel: the amount of indentation required to add for the tag
    /// - **Example**:
    ///
    ///         <trkpt lat=4.0 lon=3.0> // an open tag
    ///             <ele>20.19</ele>    // a child tag
    ///         </trkpt>                // a close tag
    func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
        // Override to subclasses
    }
    
    /// Implements a close tag
    ///
    /// An close tag is added to overall gpx content.
    ///
    /// - Parameters:
    ///     - gpx: the GPX string
    ///     - indentationLevel: the amount of indentation required to add for the tag
    /// - **Example**:
    ///
    ///         </metadata> // a close tag
    func addCloseTag(toTCX tcx: inout String, indentationLevel: Int) {
        tcx.append(String(format: "%@</%@>\r\n", indent(level: indentationLevel), self.tagName()))
    }
    
    /// For adding `Int` type values to a child tag
    /// - Parameters:
    ///     - value: value of that particular child tag
    ///     - gpx: The GPX string
    ///     - tagName: The tag name of the child tag
    ///     - indentationLevel: the amount of indentation required
    ///
    /// - Without default value or attribute
    /// - Method should only be used when overriding `addChildTag(toGPX:indentationLevel:)`
    /// - Will not execute if `value` is nil.
    /// - **Example**:
    ///
    ///       <ele>100</ele> // 100 is an example value
    func addProperty(forValue value: Int?, tcx: inout String, tagName: String, indentationLevel: Int) {
        if let validValue = value {
            addProperty(forValue: String(validValue), tcx: &tcx, tagName: tagName, indentationLevel: indentationLevel, defaultValue: nil, attribute: nil)
        }
    }
    
    /// For adding `Double` type values to a child tag
    /// - Parameters:
    ///     - value: value of that particular child tag
    ///     - gpx: The GPX string
    ///     - tagName: The tag name of the child tag
    ///     - indentationLevel: the amount of indentation required
    ///
    /// - Without default value or attribute
    /// - Method should only be used when overriding `addChildTag(toGPX:indentationLevel:)`
    /// - Will not execute if `value` is nil.
    /// - **Example**:
    ///
    ///       <ele>100.21345</ele> // 100.21345 is an example value
    func addProperty(forValue value: Double?, tcx: inout String, tagName: String, indentationLevel: Int) {
        if let validValue = value {
            addProperty(forValue: String(validValue), tcx: &tcx, tagName: tagName, indentationLevel: indentationLevel, defaultValue: nil, attribute: nil)
        }
    }
    
    /// For adding `String` type values to a child tag
    /// - Parameters:
    ///     - value: value of that particular child tag
    ///     - gpx: The GPX string
    ///     - tagName: The tag name of the child tag
    ///     - indentationLevel: the amount of indentation required
    ///     - defaultValue: default value expected of the particular child tag
    ///     - attribute: an attribute of the tag
    ///
    /// - If default value is the same as `value` parameter, method will not execute.
    /// - Method should only be used when overriding `addChildTag(toGPX:indentationLevel:)`
    /// - **Example**:
    ///
    ///       <name attribute>Your Value Here</name>
    func addProperty(forValue value: String?, tcx: inout String, tagName: String, indentationLevel: Int, defaultValue: String? = nil, attribute: String? = nil) {
        
        // value cannot be nil or empty
        if value == nil || value == "" {
            return
        }
        
        if defaultValue != nil && value == defaultValue {
            return
        }
        
        var isCDATA: Bool = false
        
        let match: Range? = value?.range(of: "[^a-zA-Z0-9.,+-/*!='\"()\\[\\]{}!$%@?_;: #\t\r\n]", options: .regularExpression, range: nil, locale: nil)
        
        // if match range, isCDATA == true
        if match != nil {
            isCDATA = true
        }
        
        // will append as XML CDATA instead.
        if isCDATA {
            tcx.append(String(format: "%@<%@%@><![CDATA[%@]]></%@>\r\n", indent(level: indentationLevel), tagName, (attribute != nil) ? " ".appending(attribute!): "", value?.replacingOccurrences(of: "]]>", with: "]]&gt;") ?? "", tagName))
        }
        else {
            tcx.append(String(format: "%@<%@%@>%@</%@>\r\n", indent(level: indentationLevel), tagName, (attribute != nil) ? " ".appending(attribute!): "", value ?? "", tagName))
        }
    }
    
    /// Indentation amount based on parameter
    ///
    /// - Parameters:
    ///     - indentationLevel: The indentation amount you require it to have.
    ///
    /// - Returns:
    ///     A `NSMutableString` that has been appended with amounts of "\t" with regards to indentation requirements input from the parameter.
    ///
    /// - **Example:**
    ///
    ///       This is unindented text (indentationLevel == 0)
    ///         This is indented text (indentationLevel == 1)
    ///             This is indented text (indentationLevel == 2)
    func indent(level indentationLevel: Int) -> String {
        var result = String()
        
        for _ in 0..<indentationLevel {
            result.append("\t")
        }
        
        return result
    }
}


open class TCXElementA: NSObject {
    
    // MARK:- Tag
    
    /// Tag name of the element.
    ///
    /// All subclasses must override this method, as elements cannot be tag-less.
    func tagName() -> String {
        fatalError("Subclass must override tagName()")
    }
    
    private var tcx = String()
    
    // MARK:- Instance
    
    public override init() {
        super.init()
    }
    
    // MARK:- GPX
    
    /// for generating newly tracked data straight into a formatted `String` that holds formatted data according to GPX syntax
    open func tcxFormatted() -> String {
        self.tcxTagging(&tcx, indentationLevel: 0)
        return tcx as String
    }
    
    /// A method for invoking all tag-related methods
    func tcxTagging(_ tcx: inout String, indentationLevel: Int) {
        self.addOpenTag(toTCX: &tcx, indentationLevel: indentationLevel)
        self.addChildTag(toTCX: &tcx, indentationLevel: indentationLevel + 1)
        self.addCloseTag(toTCX: &tcx, indentationLevel: indentationLevel)
    }
    
    /// Implements an open tag
    ///
    /// An open tag is added to overall gpx content.
    ///
    /// - Parameters:
    ///     - gpx: the GPX string
    ///     - indentationLevel: the amount of indentation required to add for the tag
    /// - **Example**:
    ///
    ///         <trk> // an open tag
    ///         <wpt lat=1.0 lon=2.0> // an open tag with extra attributes
    func addOpenTag(toTCX tcx: inout String, indentationLevel level: Int) {
        tcx.append(String(format: "%@<%@>\r\n", indent(level: level), self.tagName()))
    }
    
    /// Implements a child tag after an open tag, before a close tag.
    ///
    /// An child tag is added to overall gpx content.
    ///
    /// - Parameters:
    ///     - gpx: the GPX string
    ///     - indentationLevel: the amount of indentation required to add for the tag
    /// - **Example**:
    ///
    ///         <trkpt lat=4.0 lon=3.0> // an open tag
    ///             <ele>20.19</ele>    // a child tag
    ///         </trkpt>                // a close tag
    func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
        // Override to subclasses
    }
    
    /// Implements a close tag
    ///
    /// An close tag is added to overall gpx content.
    ///
    /// - Parameters:
    ///     - gpx: the GPX string
    ///     - indentationLevel: the amount of indentation required to add for the tag
    /// - **Example**:
    ///
    ///         </metadata> // a close tag
    func addCloseTag(toTCX tcx: inout String, indentationLevel: Int) {
        tcx.append(String(format: "%@</%@>\r\n", indent(level: indentationLevel), self.tagName()))
    }
    
    /// For adding `Int` type values to a child tag
    /// - Parameters:
    ///     - value: value of that particular child tag
    ///     - gpx: The GPX string
    ///     - tagName: The tag name of the child tag
    ///     - indentationLevel: the amount of indentation required
    ///
    /// - Without default value or attribute
    /// - Method should only be used when overriding `addChildTag(toGPX:indentationLevel:)`
    /// - Will not execute if `value` is nil.
    /// - **Example**:
    ///
    ///       <ele>100</ele> // 100 is an example value
    func addProperty(forValue value: Int?, tcx: inout String, tagName: String, indentationLevel: Int) {
        if let validValue = value {
            addProperty(forValue: String(validValue), tcx: &tcx, tagName: tagName, indentationLevel: indentationLevel, defaultValue: nil, attribute: nil)
        }
    }
    
    /// For adding `Double` type values to a child tag
    /// - Parameters:
    ///     - value: value of that particular child tag
    ///     - gpx: The GPX string
    ///     - tagName: The tag name of the child tag
    ///     - indentationLevel: the amount of indentation required
    ///
    /// - Without default value or attribute
    /// - Method should only be used when overriding `addChildTag(toGPX:indentationLevel:)`
    /// - Will not execute if `value` is nil.
    /// - **Example**:
    ///
    ///       <ele>100.21345</ele> // 100.21345 is an example value
    func addProperty(forValue value: Double?, tcx: inout String, tagName: String, indentationLevel: Int) {
        if let validValue = value {
            addProperty(forValue: String(validValue), tcx: &tcx, tagName: tagName, indentationLevel: indentationLevel, defaultValue: nil, attribute: nil)
        }
    }
    
    /// For adding `String` type values to a child tag
    /// - Parameters:
    ///     - value: value of that particular child tag
    ///     - gpx: The GPX string
    ///     - tagName: The tag name of the child tag
    ///     - indentationLevel: the amount of indentation required
    ///     - defaultValue: default value expected of the particular child tag
    ///     - attribute: an attribute of the tag
    ///
    /// - If default value is the same as `value` parameter, method will not execute.
    /// - Method should only be used when overriding `addChildTag(toGPX:indentationLevel:)`
    /// - **Example**:
    ///
    ///       <name attribute>Your Value Here</name>
    func addProperty(forValue value: String?, tcx: inout String, tagName: String, indentationLevel: Int, defaultValue: String? = nil, attribute: String? = nil) {
        
        // value cannot be nil or empty
        if value == nil || value == "" {
            return
        }
        
        if defaultValue != nil && value == defaultValue {
            return
        }
        
        var isCDATA: Bool = false
        
        let match: Range? = value?.range(of: "[^a-zA-Z0-9.,+-/*!='\"()\\[\\]{}!$%@?_;: #\t\r\n]", options: .regularExpression, range: nil, locale: nil)
        
        // if match range, isCDATA == true
        if match != nil {
            isCDATA = true
        }
        
        // will append as XML CDATA instead.
        if isCDATA {
            tcx.append(String(format: "%@<%@%@><![CDATA[%@]]></%@>\r\n", indent(level: indentationLevel), tagName, (attribute != nil) ? " ".appending(attribute!): "", value?.replacingOccurrences(of: "]]>", with: "]]&gt;") ?? "", tagName))
        }
        else {
            tcx.append(String(format: "%@<%@%@>%@</%@>\r\n", indent(level: indentationLevel), tagName, (attribute != nil) ? " ".appending(attribute!): "", value ?? "", tagName))
        }
    }
    
    /// Indentation amount based on parameter
    ///
    /// - Parameters:
    ///     - indentationLevel: The indentation amount you require it to have.
    ///
    /// - Returns:
    ///     A `NSMutableString` that has been appended with amounts of "\t" with regards to indentation requirements input from the parameter.
    ///
    /// - **Example:**
    ///
    ///       This is unindented text (indentationLevel == 0)
    ///         This is indented text (indentationLevel == 1)
    ///             This is indented text (indentationLevel == 2)
    func indent(level indentationLevel: Int) -> String {
        var result = String()
        
        for _ in 0..<indentationLevel {
            result.append("\t")
        }
        
        return result
    }
}
