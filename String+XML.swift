//
//  NSMutableString+XML.swift
//  CoreGPX
//
//  Created by Vincent Neo on 6/6/19.
//

import Foundation

extension String {
    /// Appends an open tag
       ///
       /// This function will append an open tag with the right format.
       ///
       /// **Format it will append to:**
       ///
       ///     "%@<%@%@>\r\n"
       ///     //indentations <tagName attributes> \r\n
    mutating func appendOpenTag(indentation: String, tag: String, attribute: String) {
           self.append(String(format: "%@<%@%@>\r\n", indentation, tag, attribute))
       }
    
    mutating func appendOpenTag(indentation: String, tag: String, attributes: [TCXAttribute]) {
        var attributeStr = String()
        
        for attribute in attributes {
            attributeStr += attribute.text()
        }

        self.append(String(format: "%@<%@%@>\r\n", indentation, tag, attributeStr))
    }
       
       /// Appends a close tag
       ///
       /// This function will append an close tag with the right format.
       /// Not currently used, but included, for ease of use when needed.
       ///
       /// **Format it will append to:**
       ///
       ///     "%@</%@>\r\n"
       ///     //indentations </tagName> \r\n
    mutating func appendCloseTag(indentation: String, tag: String) {
           self.append(String(format: "%@</%@>\r\n", indentation, tag))
       }
    
}

struct TCXAttribute {
    var name: String
    var value: String
    
    func text() -> String {
        return " \(name)=\"\(value)\""
    }
}
