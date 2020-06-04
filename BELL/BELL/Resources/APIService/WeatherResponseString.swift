// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weatherResponseString = try WeatherResponseString(json)

import Foundation

// MARK: - WeatherResponseString
struct WeatherResponseString: Codable {
    var status: String?
    var data: DataClass?
}

// MARK: WeatherResponseString convenience initializers and mutators

extension WeatherResponseString {
    init(data: Data) throws {
        self = try newJSONDecoder2().decode(WeatherResponseString.self, from: data)
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
        status: String?? = nil,
        data: DataClass?? = nil
    ) -> WeatherResponseString {
        return WeatherResponseString(
            status: status ?? self.status,
            data: data ?? self.data
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder2().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    var aqi, idx: Int?
    var attributions: [Attribution]?
    var city: City?
    var dominentpol: String?
    var iaqi: Iaqi?
    var time: Time?
    var debug: Debug?
}

// MARK: DataClass convenience initializers and mutators

extension DataClass {
    init(data: Data) throws {
        self = try newJSONDecoder2().decode(DataClass.self, from: data)
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
        aqi: Int?? = nil,
        idx: Int?? = nil,
        attributions: [Attribution]?? = nil,
        city: City?? = nil,
        dominentpol: String?? = nil,
        iaqi: Iaqi?? = nil,
        time: Time?? = nil,
        debug: Debug?? = nil
    ) -> DataClass {
        return DataClass(
            aqi: aqi ?? self.aqi,
            idx: idx ?? self.idx,
            attributions: attributions ?? self.attributions,
            city: city ?? self.city,
            dominentpol: dominentpol ?? self.dominentpol,
            iaqi: iaqi ?? self.iaqi,
            time: time ?? self.time,
            debug: debug ?? self.debug
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder2().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Attribution
struct Attribution: Codable {
    var url: String?
    var name, logo: String?
}

// MARK: Attribution convenience initializers and mutators

extension Attribution {
    init(data: Data) throws {
        self = try newJSONDecoder2().decode(Attribution.self, from: data)
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
        url: String?? = nil,
        name: String?? = nil,
        logo: String?? = nil
    ) -> Attribution {
        return Attribution(
            url: url ?? self.url,
            name: name ?? self.name,
            logo: logo ?? self.logo
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder2().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - City
struct City: Codable {
    var geo: [Double]?
    var name: String?
    var url: String?
}

// MARK: City convenience initializers and mutators

extension City {
    init(data: Data) throws {
        self = try newJSONDecoder2().decode(City.self, from: data)
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
        geo: [Double]?? = nil,
        name: String?? = nil,
        url: String?? = nil
    ) -> City {
        return City(
            geo: geo ?? self.geo,
            name: name ?? self.name,
            url: url ?? self.url
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder2().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Debug
struct Debug: Codable {
    var sync: Date?
}

// MARK: Debug convenience initializers and mutators

extension Debug {
    init(data: Data) throws {
        self = try newJSONDecoder2().decode(Debug.self, from: data)
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
        sync: Date?? = nil
    ) -> Debug {
        return Debug(
            sync: sync ?? self.sync
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder2().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Iaqi
struct Iaqi: Codable {
    var co, h, no2, o3: Co?
    var p, pm10, pm25, r: Co?
    var so2, t, w, wd: Co?
}

// MARK: Iaqi convenience initializers and mutators

extension Iaqi {
    init(data: Data) throws {
        self = try newJSONDecoder2().decode(Iaqi.self, from: data)
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
        co: Co?? = nil,
        h: Co?? = nil,
        no2: Co?? = nil,
        o3: Co?? = nil,
        p: Co?? = nil,
        pm10: Co?? = nil,
        pm25: Co?? = nil,
        r: Co?? = nil,
        so2: Co?? = nil,
        t: Co?? = nil,
        w: Co?? = nil,
        wd: Co?? = nil
    ) -> Iaqi {
        return Iaqi(
            co: co ?? self.co,
            h: h ?? self.h,
            no2: no2 ?? self.no2,
            o3: o3 ?? self.o3,
            p: p ?? self.p,
            pm10: pm10 ?? self.pm10,
            pm25: pm25 ?? self.pm25,
            r: r ?? self.r,
            so2: so2 ?? self.so2,
            t: t ?? self.t,
            w: w ?? self.w,
            wd: wd ?? self.wd
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder2().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Co
struct Co: Codable {
    var v: Double?
}

// MARK: Co convenience initializers and mutators

extension Co {
    init(data: Data) throws {
        self = try newJSONDecoder2().decode(Co.self, from: data)
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
        v: Double?? = nil
    ) -> Co {
        return Co(
            v: v ?? self.v
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder2().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Time
struct Time: Codable {
    var s, tz: String?
    var v: Int?
}

// MARK: Time convenience initializers and mutators

extension Time {
    init(data: Data) throws {
        self = try newJSONDecoder2().decode(Time.self, from: data)
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
        s: String?? = nil,
        tz: String?? = nil,
        v: Int?? = nil
    ) -> Time {
        return Time(
            s: s ?? self.s,
            tz: tz ?? self.tz,
            v: v ?? self.v
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder2().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder2() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder2() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

