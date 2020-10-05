//
//  plist Generator.swift
//  Project ICNS
//
//  Created by Benjamin Sova on 9/26/20.
//

import Foundation

func generatePlist(_ theme: HomeThemeDocument) -> [Any] {
    var output = """
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
        <key>PayloadContent</key>
        <array>
    """
    theme.themeContents.forEach { (content) in
        output.append("""
        \n        <dict>
                    <key>FullScreen</key>
                    <true/>
                    <key>Icon</key>
                    <data>\(content.image)</data>
                    <key>Label</key>
                    <string>\(content.iconName.replacingOccurrences(of: ",", with: ""))</string>
                    <key>PayloadDisplayName</key>
                    <string>\(content.appName.replacingOccurrences(of: ",", with: ""))</string>
                    <key>PayloadIdentifier</key>
                    <string>u-bensova.icons.third-party.\(theme.themeAuthor).\(theme.themeName.replacingOccurrences(of: " ", with: "-")).\(content.appName.replacingOccurrences(of: " ", with: "-").replacingOccurrences(of: ",", with: ""))</string>
                    <key>PayloadType</key>
                    <string>com.apple.webClip.managed</string>
                    <key>PayloadUUID</key>
                    <string>\(UUID())</string>
                    <key>PayloadVersion</key>
                    <real>1</real>
                    <key>Precomposed</key>
                    <true/>
                    <key>TargetApplicationBundleIdentifier</key>
                    <string>\(content.bundleID)</string>
                    <key>URL</key>
                    <string>\(content.url)</string>
                </dict>
        """)
    }
    output.append("""
    \n    </array>
        <key>PayloadDescription</key>
        <string>\(theme.themeDescription)</string>
        <key>PayloadDisplayName</key>
        <string>\(theme.themeName)</string>
        <key>PayloadIdentifier</key>
        <string>u-bensova.icons.third-party.\(theme.themeAuthor).\(theme.themeName.replacingOccurrences(of: " ", with: "-")))</string>
        <key>PayloadOrganization</key>
        <string>\(theme.themeAuthor)</string>
        <key>PayloadType</key>
        <string>Configuration</string>
        <key>PayloadUUID</key>
        <string>\(UUID())</string>
        <key>PayloadVersion</key>
        <real>1</real>
    </dict>
    </plist>
    """)
    let filename = getDocumentsDirectory().appendingPathComponent("\(theme.themeName).mobileconfig")

    do {
        try output.write(toFile: filename, atomically: true, encoding: String.Encoding.utf8)

        let fileURL = NSURL(fileURLWithPath: filename)
        return [fileURL]
    } catch {
        print("cannot write file")
        // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        return []
    }
}

func getDocumentsDirectory() -> NSString {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentsDirectory = paths[0]
    return documentsDirectory as NSString
}

extension Array {

    /// Find the location of the first element with a certain value at a certain spot
    ///
    /// `Array.whereFrom(_:in:)` looks for all elements in an Array that, when passed into `grabItem(_:)` (aka `in`), matches `find`. If nothing is found `whereAt` will return `nil`.
    ///
    /// - Parameters:
    ///   - find: The item to compare to the one found in an element.
    ///   - grabItem: A func to convert an element to an item that can be compared to the `find` option.
    /// - Returns: The location of the element that contains `find`.
    /// # Declared in
    ///  [FindMap.swift](https://github.com/SwiftStars/StdLibX/tree/master/Sources/StdLibX/Foundation/FindMap.swift)
    ///
    public func whereAt<T: Equatable>(_ find: T, at grabItem: (Element) -> T) -> Int? {
        var status = (found: false, index: 0)
        forEach { (item) in
            if !(status.found) {
                if grabItem(item) == find {
                    status.found = true
                } else {
                    status.index += 1
                }
            }
        }
        return status.found ? status.index : nil
    }
}
