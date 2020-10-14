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
    @State var themeEdit = ThemeContent(
        iconName: "",
        appName: "",
        bundleID: "",
        image: "",
        url: "http://"
    )
    @State var useNil = true
    @State var editorDetails: LINotificationTextDetails = (.init(get: {"NIL CONTENTS"}, set: {_ in}), "NIL TITLE", "NIL PLACEHOLDER", false, "NIL TEMP")
    @State var showPhotosAction = false
    @State var photosData: Data?
    @State var showDocumentPicker = false
    @State var modifyAt = 0
    
    var body: some View {
        VStack {
            SearchBar(text: $searchFor)
                .returnKeyType(.search)
                .enablesReturnKeyAutomatically(true)
                .searchBarStyle(.prominent)
                .showsCancelButton(true)
            List {
                ForEach((0 ..< theme.themeContents.count).filter {
                    if searchFor != "" {
                        if theme.themeContents[$0].appName.contains(searchFor.lowercased()) || theme.themeContents[$0].bundleID.contains(searchFor.lowercased()) {
                            return true
                        }
                        return false
                    } else {
                        return true
                    }
                }, id: \.self) { icon in
                    IconRow(icon:
                        .init(get: {
                                    theme.themeContents[icon]},
                              set: {
                                theme.themeContents[icon] = $0
                              }),
                            iconID: icon,
                            showSheet: .init(get: {
                        showPhotosAction
                    }, set: { _ in
                        modifyAt = icon
                        showPhotosAction = true
                    }), isNil: $useNil, sheetID: $sheetID, editorDetails: $editorDetails)
                }.onDelete(perform: { indexSet in
                    theme.themeContents.remove(atOffsets: indexSet)
                }).onMove(perform: { indices, newOffset in
                    theme.themeContents.move(fromOffsets: indices, toOffset: newOffset)
                })
            }
        }
        .navigationTitle(theme.themeName)
        .navigationBarItems(trailing: Menu {
            Button {
//                sheetID = 1
//                showSheet = true
                theme.themeContents.append(.init(iconName: "New Icon", appName: "New Icon \(theme.themeContents.count)", bundleID: "com.new.new", image: "", url: "http://"))
            } label: {
                Text("Add")
                Image(systemName: "plus")
            }
            Button {
                editorDetails.to = $theme.themeName
                editorDetails.title = "Theme Title"
                editorDetails.placeholder = "Title"
                editorDetails.temp = theme.themeName
                withAnimation(.easeOut(duration: 0.3)) {
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
                withAnimation(.easeOut(duration: 0.3)) {
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
                withAnimation(.easeOut(duration: 0.3)) {
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
        .sheet(isPresented: $showSheet, onDismiss: {
            if sheetID == 2 {
                guard let photosData = photosData else { return }
                guard let imageData = UIImage(data: photosData) else { return }
                guard let resizedImage = resizeImage(image: imageData, targetSize: .init(width: 140, height: 140)) else { return }
                guard let pngData = resizedImage.pngData() else { return }
                theme.themeContents[modifyAt].image = pngData.base64EncodedString()
            }
        }) { () -> AnyView in
            if sheetID == 1 {
                return AnyView(NewIconView(icons: $theme.themeContents, isPresented: $showSheet))
            }
            if sheetID == 2 {
                return AnyView(ImagePicker(data: $photosData, encoding: .png))
            }
            if sheetID == 3 {
                return AnyView(AppActivityView(activityItems: shareItems))
            }
//            if sheetID == 4 {
//                return AnyView(WebView(urlType: .localUrl, viewModel: T##ViewModel))
//            }
            return AnyView(Text("Uh-oh..."))
        }.notificationEditor(t: editorDetails.title, p: editorDetails.placeholder, input: editorDetails.to, temp: editorDetails.temp, shown: $editorDetails.shown)
        .notificationAction(t: "Choose a Photo", b: [(UUID(), Image("Cancel"), {}), (UUID(), Image("Photos"), {
            sheetID = 2
            photosData = nil
            showSheet = true
        }), (UUID(), Image("Clipboard"), {
            if let base64String = UIPasteboard.general.string {
                guard let unencodedData = Data(base64Encoded: base64String) else { return }
                if Image(data: unencodedData) != nil {
                    theme.themeContents[modifyAt].image = base64String
                }
            } else if let imageData = UIPasteboard.general.image {
                guard let resizedImage = resizeImage(image: imageData, targetSize: .init(width: 140, height: 140)) else { return }
                guard let pngData = resizedImage.pngData() else { return }
                theme.themeContents[modifyAt].image = pngData.base64EncodedString()
            }
        }), (UUID(), Image("Files"), {
            photosData = nil
            showDocumentPicker = true
        })], shown: $showPhotosAction)
        .fileImporter(isPresented: $showDocumentPicker, allowedContentTypes: [.png]) { (result) in
            do {
                let url = try result.get()
                guard let photosData = try? Data(contentsOf: url) else { return }
                guard let imageData = UIImage(data: photosData) else { return }
                guard let resizedImage = resizeImage(image: imageData, targetSize: .init(width: 140, height: 140)) else { return }
                guard let pngData = resizedImage.pngData() else { return }
                theme.themeContents[modifyAt].image = pngData.base64EncodedString()
            } catch {
                print(error.localizedDescription)
            }
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
    @Binding var editorDetails: LINotificationTextDetails
    var body: some View {
        HStack {
            if let data = Data(base64Encoded: icon.image, options: .ignoreUnknownCharacters) {
                if let image = Image(data: data) {
                    Menu {
                        menu
                    } label: {
                        image
                            .resizable()
                            .frame(width: 40, height: 40)
                            .cornerRadius(8)
                    }
                } else {
                    Button {
                        withAnimation(.easeOut(duration: 0.3)) {
                            showSheet = true
                        }
                    } label: {
                        Image(systemName: "app.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.red)
                    }
                }
            } else {
                Button {
                    withAnimation(.easeOut(duration: 0.3)) {
                        showSheet = true
                    }
                } label: {
                    Image(systemName: "app")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.red)
                }
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
            menu
        }))
    }
    
    @ViewBuilder
    var menu: some View {
        Button {
            withAnimation(.easeOut(duration: 0.3)) {
                showSheet = true
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
            withAnimation(.easeOut(duration: 0.3)) {
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
            withAnimation(.easeOut(duration: 0.3)) {
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
            withAnimation(.easeOut(duration: 0.3)) {
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
            withAnimation(.easeOut(duration: 0.3)) {
                editorDetails.shown = true
            }
        } label: {
            Text("Set App Name")
            Image(systemName: "textformat.size")
        }
    }
}
