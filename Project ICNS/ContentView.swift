//
//  ContentView.swift
//  Project ICNS
//
//  Created by Benjamin Sova on 9/25/20.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: Project_ICNSDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(Project_ICNSDocument()))
    }
}
