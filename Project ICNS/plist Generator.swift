//
//  plist Generator.swift
//  Project ICNS
//
//  Created by Benjamin Sova on 9/26/20.
//

import Foundation

func generatePlist(_ theme: HomeThemeDocument) -> String {
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
                    <string>\(content.iconName)</string>
                    <key>PayloadDisplayName</key>
                    <string>\(content.appName)</string>
                    <key>PayloadIdentifier</key>
                    <string>u-bensova.icons.third-party.\(theme.themeAuthor).\(theme.themeName.replacingOccurrences(of: " ", with: "-")).\(content.iconName.replacingOccurrences(of: " ", with: "-"))</string>
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
    return output
}
