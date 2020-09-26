//
//  ContentView.swift
//  Project ICNS
//
//  Created by Benjamin Sova on 9/25/20.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: HomeThemeDocument

    var body: some View {
        ProjectEditor(theme: $document)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(HomeThemeDocument()))
    }
}
