// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let aSSearch = try ASSearch(json)

import Foundation

// MARK: - ASSearch
struct ASSearch: Codable {
    var resultCount: Int
    var results: [ASResult]
}

// MARK: ASSearch convenience initializers and mutators

extension ASSearch {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ASSearch.self, from: data)
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
        resultCount: Int? = nil,
        results: [ASResult]? = nil
    ) -> ASSearch {
        return ASSearch(
            resultCount: resultCount ?? self.resultCount,
            results: results ?? self.results
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ASResult
struct ASResult: Codable {
    var features, advisories, supportedDevices: [String]
    var isGameCenterEnabled: Bool
    var screenshotUrls, ipadScreenshotUrls: [String]
    var appletvScreenshotUrls: [JSONAny]
    var artworkUrl60, artworkUrl512, artworkUrl100: String
    var artistViewURL: String
    var kind: String
    var currentVersionReleaseDate: Date
    var minimumOSVersion, primaryGenreName: String
    var isVppDeviceBasedLicensingEnabled: Bool
    var releaseDate: Date
    var sellerName: String
    var primaryGenreID, trackID: Int
    var trackName, formattedPrice: String
    var genreIDS: [String]
    var trackCensoredName: String
    var languageCodesISO2A: [String]
    var fileSizeBytes, contentAdvisoryRating: String
    var averageUserRatingForCurrentVersion: Double
    var userRatingCountForCurrentVersion: Int
    var averageUserRating: Double
    var trackViewURL: String
    var trackContentRating, version, wrapperType: String
    var genres: [String]
    var artistID: Int
    var artistName: String
    var price: Double
    var resultDescription, currency, bundleID: String
    var userRatingCount: Int
    var sellerURL: String?
    var releaseNotes: String?

    enum CodingKeys: String, CodingKey {
        case features, advisories, supportedDevices, isGameCenterEnabled, screenshotUrls, ipadScreenshotUrls, appletvScreenshotUrls, artworkUrl60, artworkUrl512, artworkUrl100
        case artistViewURL = "artistViewUrl"
        case kind, currentVersionReleaseDate
        case minimumOSVersion = "minimumOsVersion"
        case primaryGenreName, isVppDeviceBasedLicensingEnabled, releaseDate, sellerName
        case primaryGenreID = "primaryGenreId"
        case trackID = "trackId"
        case trackName, formattedPrice
        case genreIDS = "genreIds"
        case trackCensoredName, languageCodesISO2A, fileSizeBytes, contentAdvisoryRating, averageUserRatingForCurrentVersion, userRatingCountForCurrentVersion, averageUserRating
        case trackViewURL = "trackViewUrl"
        case trackContentRating, version, wrapperType, genres
        case artistID = "artistId"
        case artistName, price
        case resultDescription = "description"
        case currency
        case bundleID = "bundleId"
        case userRatingCount
        case sellerURL = "sellerUrl"
        case releaseNotes
    }
}

// MARK: ASResult convenience initializers and mutators

extension ASResult {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ASResult.self, from: data)
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
        features: [String]? = nil,
        advisories: [String]? = nil,
        supportedDevices: [String]? = nil,
        isGameCenterEnabled: Bool? = nil,
        screenshotUrls: [String]? = nil,
        ipadScreenshotUrls: [String]? = nil,
        appletvScreenshotUrls: [JSONAny]? = nil,
        artworkUrl60: String? = nil,
        artworkUrl512: String? = nil,
        artworkUrl100: String? = nil,
        artistViewURL: String? = nil,
        kind: String? = nil,
        currentVersionReleaseDate: Date? = nil,
        minimumOSVersion: String? = nil,
        primaryGenreName: String? = nil,
        isVppDeviceBasedLicensingEnabled: Bool? = nil,
        releaseDate: Date? = nil,
        sellerName: String? = nil,
        primaryGenreID: Int? = nil,
        trackID: Int? = nil,
        trackName: String? = nil,
        formattedPrice: String? = nil,
        genreIDS: [String]? = nil,
        trackCensoredName: String? = nil,
        languageCodesISO2A: [String]? = nil,
        fileSizeBytes: String? = nil,
        contentAdvisoryRating: String? = nil,
        averageUserRatingForCurrentVersion: Double? = nil,
        userRatingCountForCurrentVersion: Int? = nil,
        averageUserRating: Double? = nil,
        trackViewURL: String? = nil,
        trackContentRating: String? = nil,
        version: String? = nil,
        wrapperType: String? = nil,
        genres: [String]? = nil,
        artistID: Int? = nil,
        artistName: String? = nil,
        price: Double? = nil,
        resultDescription: String? = nil,
        currency: String? = nil,
        bundleID: String? = nil,
        userRatingCount: Int? = nil,
        sellerURL: String?? = nil,
        releaseNotes: String?? = nil
    ) -> ASResult {
        return ASResult(
            features: features ?? self.features,
            advisories: advisories ?? self.advisories,
            supportedDevices: supportedDevices ?? self.supportedDevices,
            isGameCenterEnabled: isGameCenterEnabled ?? self.isGameCenterEnabled,
            screenshotUrls: screenshotUrls ?? self.screenshotUrls,
            ipadScreenshotUrls: ipadScreenshotUrls ?? self.ipadScreenshotUrls,
            appletvScreenshotUrls: appletvScreenshotUrls ?? self.appletvScreenshotUrls,
            artworkUrl60: artworkUrl60 ?? self.artworkUrl60,
            artworkUrl512: artworkUrl512 ?? self.artworkUrl512,
            artworkUrl100: artworkUrl100 ?? self.artworkUrl100,
            artistViewURL: artistViewURL ?? self.artistViewURL,
            kind: kind ?? self.kind,
            currentVersionReleaseDate: currentVersionReleaseDate ?? self.currentVersionReleaseDate,
            minimumOSVersion: minimumOSVersion ?? self.minimumOSVersion,
            primaryGenreName: primaryGenreName ?? self.primaryGenreName,
            isVppDeviceBasedLicensingEnabled: isVppDeviceBasedLicensingEnabled ?? self.isVppDeviceBasedLicensingEnabled,
            releaseDate: releaseDate ?? self.releaseDate,
            sellerName: sellerName ?? self.sellerName,
            primaryGenreID: primaryGenreID ?? self.primaryGenreID,
            trackID: trackID ?? self.trackID,
            trackName: trackName ?? self.trackName,
            formattedPrice: formattedPrice ?? self.formattedPrice,
            genreIDS: genreIDS ?? self.genreIDS,
            trackCensoredName: trackCensoredName ?? self.trackCensoredName,
            languageCodesISO2A: languageCodesISO2A ?? self.languageCodesISO2A,
            fileSizeBytes: fileSizeBytes ?? self.fileSizeBytes,
            contentAdvisoryRating: contentAdvisoryRating ?? self.contentAdvisoryRating,
            averageUserRatingForCurrentVersion: averageUserRatingForCurrentVersion ?? self.averageUserRatingForCurrentVersion,
            userRatingCountForCurrentVersion: userRatingCountForCurrentVersion ?? self.userRatingCountForCurrentVersion,
            averageUserRating: averageUserRating ?? self.averageUserRating,
            trackViewURL: trackViewURL ?? self.trackViewURL,
            trackContentRating: trackContentRating ?? self.trackContentRating,
            version: version ?? self.version,
            wrapperType: wrapperType ?? self.wrapperType,
            genres: genres ?? self.genres,
            artistID: artistID ?? self.artistID,
            artistName: artistName ?? self.artistName,
            price: price ?? self.price,
            resultDescription: resultDescription ?? self.resultDescription,
            currency: currency ?? self.currency,
            bundleID: bundleID ?? self.bundleID,
            userRatingCount: userRatingCount ?? self.userRatingCount,
            sellerURL: sellerURL ?? self.sellerURL,
            releaseNotes: releaseNotes ?? self.releaseNotes
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

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    
    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}

