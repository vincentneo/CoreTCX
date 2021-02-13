//
//  TCXSubfolders.swift
//  CoreTCX
//
//  Created by Vincent on 12/12/19.
//

import Foundation

public class TCXFolderType: NSObject, TCXElement {
    func tagName() -> String { fatalError("Not implemented") }
    var category: TCXCategoryFolderNames!
    
    public enum TCXCategoryFolderNames: String {
        case running = "Running"
        case biking = "Biking"
        case other = "Other"
        case multiSport = "MultiSport"
        case unspecified = "Unknown"
    }
    
    func tcxTagging(_ tcx: inout String, indentationLevel: Int) {
        addOpenTag(toTCX: &tcx, indentationLevel: indentationLevel)
        addChildTag(toTCX: &tcx, indentationLevel: indentationLevel + 1)
        addCloseTag(toTCX: &tcx, indentationLevel: indentationLevel)
    }
    func addOpenTag(toTCX tcx: inout String, indentationLevel level: Int) {}
    func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {}
    func addCloseTag(toTCX tcx: inout String, indentationLevel: Int) {}
}

/*public protocol TCXFolderType: TCXFolderType {
    
    //var categoryTag: TCXCategoryFolderNames { get }
}*/
/*extension TCXFolderType {
    public var category: TCXCategoryFolderNames {
        get { return .unspecified }
    }
}*/

/// `History_t` or `Workouts_t`
public class TCXSubfolders<folderType: TCXFolderType>: NSObject, TCXElement {
    public var running: folderType?
    public var biking: folderType?
    public var other: folderType?
    public var extensions: TCXExtensions?
    
    public override init() {
        super.init()
    }
    /// Only call when tagging.
    private func autoTagCategories() {
        running?.category = .running
        biking?.category = .biking
        other?.category = .other
    }
    
    func tagName() -> String {
        if folderType.self == TCXHistoryFolder.self {
            return "History"
        }
        else if folderType.self == TCXWorkoutsFolder.self {
            return "Workouts"
        }
        else {
            fatalError("Subfolder is neither History or Workouts, is againsts TCX v2 Schema.")
        }
    }
    
    func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
        autoTagCategories()
        if let running = running {
            //running.type = .running
            running.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
        if let biking = biking {
            biking.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
        if let other = other {
            other.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
        if let extensions = extensions {
            extensions.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
    }
    
}

public final class TCXWorkouts: TCXSubfolders<TCXWorkoutsFolder> {}

public final class TCXHistory: TCXSubfolders<TCXHistoryFolder> {
    public var multiSport: TCXHistoryFolder?
    
    override func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
        multiSport?.category = .multiSport
        
        // MultiSport tag is only written if folder is of type `History_t`
        if let multiSport = multiSport {
            multiSport.tcxTagging(&tcx, indentationLevel: indentationLevel)
        }
    }
}

/// `Courses_t`
public final class TCXCourses: TCXElement {
    func tagName() -> String {
        return "Courses"
    }
    
    var folder: TCXCoursesFolder?
    var extensions: TCXExtensions?
    
    func addChildTag(toTCX tcx: inout String, indentationLevel: Int) {
        self.folder?.tcxTagging(&tcx, indentationLevel: indentationLevel)
        self.extensions?.tcxTagging(&tcx, indentationLevel: indentationLevel)
    }
}

