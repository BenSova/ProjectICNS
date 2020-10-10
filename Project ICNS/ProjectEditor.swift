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
    @State var themeEdit = ThemeContent(
        iconName: "",
        appName: "",
        bundleID: "",
        image: "",
        url: "http://"
    )
    @State var whichEdit = 0
    @State var useNil = true
    @State var editorDetails: LINotificationTextDetails = (.init(get: {"NIL CONTENTS"}, set: {_ in}), "NIL TITLE", "NIL PLACEHOLDER", false, "NIL TEMP")
    
    var body: some View {
        VStack {
            if showSearch {
                SearchBar(text: $searchFor)
                    .returnKeyType(.search)
                    .enablesReturnKeyAutomatically(true)
                    .searchBarStyle(.prominent)
                    .showsCancelButton(true)
            } else {
                Text("Search")
                    .onAppear {
                        showSearch = true
                    }
            }
            List {
                ForEach((0 ..< theme.themeContents.count).filter {
                    if searchFor != "" {
                        if theme.themeContents[$0].iconName.contains(searchFor.lowercased()) || theme.themeContents[$0].bundleID.contains(searchFor.lowercased()) {
                            return true
                        }
                        return false
                    } else {
                        return true
                    }
                }, id: \.self) { icon in
                    IconRow(icon: .init(get: {theme.themeContents[icon]}, set: {theme.themeContents[icon] = $0}), iconID: icon, showSheet: $showSheet, isNil: $useNil, sheetID: $sheetID, whichEdit: $whichEdit, editorDetails: $editorDetails)
                }.onDelete(perform: { indexSet in
                    theme.themeContents.remove(atOffsets: indexSet)
                }).onMove(perform: { indices, newOffset in
                    theme.themeContents.move(fromOffsets: indices, toOffset: newOffset)
                })
            }
            Text("\(theme.themeAuthor) \(theme.themeName) \(theme.themeDescription)")
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
                editorDetails.to = $theme.themeName
                editorDetails.title = "Theme Title"
                editorDetails.placeholder = "Title"
                editorDetails.temp = theme.themeName
                withAnimation {
                    editorDetails.shown = true
                }
            } label: {
                Text("Title")
                Image(systemName: "textbox")
            }
            Button {
                editorDetails.to = $theme.themeDescription
                editorDetails.title = "Description"
                editorDetails.placeholder = "Description"
                editorDetails.temp = theme.themeDescription
                withAnimation {
                    editorDetails.shown = true
                }
            } label: {
                Text("Description")
                Image(systemName: "doc.plaintext")
            }
            Button {
                editorDetails.to = $theme.themeAuthor
                editorDetails.title = "Theme Author"
                editorDetails.placeholder = "Author"
                editorDetails.temp = theme.themeAuthor
                withAnimation {
                    editorDetails.shown = true
                }
            } label: {
                Text("Author")
                Image(systemName: "person.crop.circle")
            }
            EditButton()
            Button {
                shareItems = generatePlist(theme)
                sheetID = 3
                showSheet = true
            } label: {
                Text("Export")
                Image(systemName: "square.and.arrow.up")
            }
            Button {
//                shareItems = generatePlist(theme)
//                sheetID = 4
//                showSheet = true
            } label: {
                Text("Install")
                Image(systemName: "square.and.arrow.down")
            }
        } label: {
            Image(systemName: "ellipsis.circle")
        })
        .popover(isPresented: $showSheet) { () -> AnyView in
            if sheetID == 1 {
                return AnyView(NewIconView(icons: $theme.themeContents, isPresented: $showSheet))
            }
            if sheetID == 2 {
                return AnyView(TextEditor(text: .init(get: {theme[keyPath: textEdit]}, set: {theme[keyPath: textEdit] = $0})))
            }
            if sheetID == 3 {
                return AnyView(AppActivityView(activityItems: shareItems))
            }
//            if sheetID == 4 {
//                return AnyView(WebView(urlType: .localUrl, viewModel: T##ViewModel))
//            }
            return AnyView(Text("Uh-oh..."))
        }.notificationEditor(t: editorDetails.title, p: editorDetails.placeholder, input: editorDetails.to, temp: editorDetails.temp, shown: $editorDetails.shown)
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
                    TextField("Icon Name (Home Screen)", text: $workingIcon.iconName)
                    TextField("App Display Name (Configurator)", text: $workingIcon.appName)
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
    @Binding var icon: ThemeContent
    var iconID: Int?
    @Binding var showSheet: Bool
    @Binding var isNil: Bool
    @Binding var sheetID: Int
    @Binding var whichEdit: Int
    @Binding var editorDetails: LINotificationTextDetails
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
                Text(icon.iconName).bold()
                Text(icon.appName)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(icon.bundleID)
                Text("\(icon.url)    \(iconID ?? -1)")
            }.font(.custom("System", size: 12))
            .foregroundColor(.secondary)
        }
        .contextMenu(ContextMenu(menuItems: {
            Button {
                let base64 = UIPasteboard.general.string ?? ""
                if Data(base64Encoded: base64, options: .ignoreUnknownCharacters) != nil {
                    icon.image = base64
                }
            } label: {
                Text("Set Icon")
                Image(systemName: "photo")
            }
            Button {
                editorDetails.to = $icon.bundleID
                editorDetails.title = icon.iconName != " " ? icon.iconName : icon.appName
                editorDetails.placeholder = "Bundle ID"
                editorDetails.temp = icon.bundleID
                withAnimation {
                    editorDetails.shown = true
                }
            } label: {
                Text("Set Bundle ID")
                Image(systemName: "textbox")
            }
            Button {
                editorDetails.to = $icon.url
                editorDetails.title = icon.iconName != " " ? icon.iconName : icon.appName
                editorDetails.placeholder = "URL Scheme"
                editorDetails.temp = icon.url
                withAnimation {
                    editorDetails.shown = true
                }
            } label: {
                Text("Set URL Scheme")
                Image(systemName: "safari")
            }
            Button {
                editorDetails.to = $icon.iconName
                editorDetails.title = icon.iconName != " " ? icon.iconName : icon.appName
                editorDetails.placeholder = "Icon Name"
                editorDetails.temp = icon.iconName
                withAnimation {
                    editorDetails.shown = true
                }
            } label: {
                Text("Set Display Name")
                Image(systemName: "textformat.abc.dottedunderline")
            }
            Button {
                editorDetails.to = $icon.appName
                editorDetails.title = icon.iconName != " " ? icon.iconName : icon.appName
                editorDetails.placeholder = "App ID"
                editorDetails.temp = icon.appName
                withAnimation {
                    editorDetails.shown = true
                }
            } label: {
                Text("Set App Name")
                Image(systemName: "textformat.size")
            }
        }))
    }
}
