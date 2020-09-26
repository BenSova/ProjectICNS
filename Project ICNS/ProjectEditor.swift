//
//  ProjectEditor.swift
//  Project ICNS
//
//  Created by Benjamin Sova on 9/26/20.
//

import SwiftUIX

struct ProjectEditor: View {
    @Binding var theme: HomeThemeDocument
    @State var textEdit: WritableKeyPath<HomeThemeDocument, String> = \.themeName {
        didSet {
            sheetID = 2
            showSheet = true
        }
    }
    @State var showSheet = false
    @State var sheetID = 0
    @State var shareItems: [Any] = []
    @State var searchFor = ""
    @State var showSearch = true
    
    var body: some View {
        VStack {
            if showSearch {
                SearchBar(text: $searchFor)
                    .returnKeyType(.search)
                    .enablesReturnKeyAutomatically(true)
                    .searchBarStyle(.prominent)
            } else {
                Text("Search")
                    .onAppear {
                        showSearch = true
                    }
            }
            List(theme.themeContents.filter {
                if searchFor != "" {
                    if $0.iconName.contains(searchFor.lowercased()) || $0.bundleID.contains(searchFor.lowercased()) {
                        return true
                    }
                    return false
                } else {
                    return true
                }
            }, id: \.iconName) { icon in
                IconRow(icon: icon)
            }
            HStack {
                Spacer()
                Text("\(theme.themeDescription)\n\(theme.themeAuthor)")
                Spacer()
            }
            .onSwipeLeft {
                showSearch = false
            }
        }
        .navigationTitle(theme.themeName)
        .navigationBarItems(trailing: Menu {
            Button {
                sheetID = 1
                showSheet = true
            } label: {
                Text("Add")
                Image(systemName: "plus")
            }
            Button {
                textEdit = \.themeName
            } label: {
                Text("Title")
                Image(systemName: "textbox")
            }
            Button {
                textEdit = \.themeDescription
            } label: {
                Text("Description")
                Image(systemName: "doc.plaintext")
            }
            Button {
                textEdit = \.themeAuthor
            } label: {
                Text("Author")
                Image(systemName: "person.crop.circle")
            }
            Button {
                shareItems = [generatePlist(theme)]
                sheetID = 3
                showSheet = true
            } label: {
                Text("Export")
                Image(systemName: "square.and.arrow.up")
            }
        } label: {
            Image(systemName: "ellipsis.circle")
        })

        .sheet(isPresented: $showSheet) { () -> AnyView in
            if sheetID == 1 {
                return AnyView(NewIconView(icons: $theme.themeContents, isPresented: $showSheet))
            }
            if sheetID == 2 {
                return AnyView(TextEditor(text: .init(get: {theme[keyPath: textEdit]}, set: {theme[keyPath: textEdit] = $0})))
            }
            if sheetID == 3 {
                return AnyView(AppActivityView(activityItems: shareItems))
            }
            return AnyView(Text("Uh-oh..."))
        }
    }
}

struct NewIconView: View {
    @Binding var icons: [ThemeContent]
    @State var workingIcon = ThemeContent(
        iconName: "",
        appName: "",
        bundleID: "",
        image: "",
        url: "http://"
    )
    @State var icon: Image?
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    TextField("Icon Name (Internal)", text: $workingIcon.iconName)
                    TextField("App Display Name (External)", text: $workingIcon.appName)
                    TextField("Bundle ID", text: $workingIcon.bundleID)
                    TextField("URL", text: $workingIcon.url)
                    Button(workingIcon.image == "" || icon == nil ? "Grab Base64 Icon" : "Replace Base64 Icon") {
                        workingIcon.image = UIPasteboard.general.string ?? ""
                        if let data = Data(base64Encoded: workingIcon.image, options: .ignoreUnknownCharacters) {
                            icon = Image(data: data)
                        }
                    }
                    if let icon = icon {
                        icon
                            .resizable()
                            .frame(width: 144, height: 144)
                    }
                }.padding()
            }.navigationTitle("New Icon")
            .navigationBarItems(trailing: Button("Done") {
                if workingIcon.iconName != "" && workingIcon.appName != "" && workingIcon.bundleID != "" && !(workingIcon.bundleID.contains(" ") || workingIcon.bundleID.contains("\n")) && workingIcon.image != "" && workingIcon.url != "" && workingIcon.url.contains("://") {
                    icons.append(workingIcon)
                    isPresented = false
                }
            })
        }
    }
}

struct ProjectEditor_Previews: PreviewProvider {
    static var previews: some View {
        ProjectEditor(theme: .constant(HomeThemeDocument()))
    }
}

struct IconRow: View {
    var icon: ThemeContent
    var body: some View {
        HStack {
            if let data = Data(base64Encoded: icon.image, options: .ignoreUnknownCharacters) {
                if let image = Image(data: data) {
                    image
                        .resizable()
                        .frame(width: 40, height: 40)
                        .cornerRadius(8)
                } else {
                    Image(systemName: "app.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
            } else {
                Image(systemName: "app")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
            VStack(alignment: .leading) {
                Text(icon.iconName)
                Text(icon.appName)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(icon.bundleID)
                Text(icon.url)
            }
        }
    }
}
