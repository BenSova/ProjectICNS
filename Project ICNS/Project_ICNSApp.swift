//
//  Project_ICNSApp.swift
//  Project ICNS
//
//  Created by Benjamin Sova on 9/25/20.
//

import SwiftUI

@main
struct Project_ICNSApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: Project_ICNSDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
