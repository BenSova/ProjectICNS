//
//  Project_ICNSApp.swift
//  Project ICNS
//
//  Created by Benjamin Sova on 9/25/20.
//

import SwiftUI

@main
struct ProjectICNSApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: HomeThemeDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
