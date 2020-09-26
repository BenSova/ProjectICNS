//
//  Project_ICNSDocument.swift
//  Project ICNS
//
//  Created by Benjamin Sova on 9/25/20.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var homeThemeDoc: UTType {
        UTType(importedAs: "u-bensova.Project-ICNS.document")
    }
}

struct HomeThemeDocument: FileDocument, Codable {

    var themeName, themeDescription, themeAuthor: String
    var themeContents: [ThemeContent]

    enum CodingKeys: String, CodingKey {
        case themeName = "ThemeName"
        case themeDescription = "ThemeDescription"
        case themeAuthor = "ThemeAuthor"
        case themeContents = "ThemeContents"
    }

    init(name: String = "My New Theme", description: String = "A short explanation on my theme is the best.", author: String = "Me", contents: [ThemeContent] = []) {
        self.themeName = name
        self.themeDescription = description
        self.themeAuthor = author
        self.themeContents = contents
    }

    static var readableContentTypes: [UTType] { [.homeThemeDoc] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        try self.init(string)
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try self.jsonData()
        return .init(regularFileWithContents: data)
    }
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let homeThemeDocument = try HomeThemeDocument(json)

// MARK: - HomeThemeDocument

// MARK: HomeThemeDocument convenience initializers and mutators

extension HomeThemeDocument {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HomeThemeDocument.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        themeName: String? = nil,
        themeDescription: String? = nil,
        themeAuthor: String? = nil,
        themeContents: [ThemeContent]? = nil
    ) -> HomeThemeDocument {
        return HomeThemeDocument(
            name: themeName ?? self.themeName,
            description: themeDescription ?? self.themeDescription,
            author: themeAuthor ?? self.themeAuthor,
            contents: themeContents ?? self.themeContents
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ThemeContent
struct ThemeContent: Codable {
    var iconName, appName, bundleID, image, url: String

    enum CodingKeys: String, CodingKey {
        case iconName = "IconName"
        case appName = "AppName"
        case bundleID = "BundleID"
        case image = "Image"
        case url = "URL"
    }
}

// MARK: ThemeContent convenience initializers and mutators

extension ThemeContent {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ThemeContent.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        iconName: String? = nil,
        appName: String? = nil,
        bundleID: String? = nil,
        image: String? = nil,
        url: String? = nil
    ) -> ThemeContent {
        return ThemeContent(
            iconName: iconName ?? self.iconName,
            appName: appName ?? self.appName,
            bundleID: bundleID ?? self.bundleID,
            image: image ?? self.image,
            url: url ?? self.url
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

