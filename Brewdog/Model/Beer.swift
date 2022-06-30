//
//  Beer.swift
//  Brewdog
//
//  Created by Izabela Kołyszko on 29/06/2022.
//
import Foundation
import SwiftyJSON

struct Beer: Hashable {
    let name: String
    let imageUrl: String
    let abv: Float
    let description: String
    let methods: [Method]
    let malts: [Malt]
    let hops: [Hop]

    struct Method: Hashable {
        let name: String
    }

    struct Malt: Hashable {
        let name: String
    }

    struct Hop: Hashable {
        let name: String
    }

    init(name: String, imageUrl: String, abv: Float, description: String, methods: [Method], malts: [Malt], hops: [Hop]) {
        self.name = name
        self.imageUrl = imageUrl
        self.abv = abv
        self.description = description
        self.methods = methods
        self.malts = malts
        self.hops = hops
    }

    init(from serviceResponse: ServiceBeerResponse) {
        self.name = serviceResponse.name
        self.imageUrl = serviceResponse.imageUrl
        self.abv = serviceResponse.abv
        self.description = serviceResponse.description
        self.methods = serviceResponse.method.keys.map { Method(name: $0)}
        self.malts = Beer.parseMalts(from: serviceResponse)
        self.hops = Beer.parseHops(from: serviceResponse)
    }

    private static func parseMalts(from serviceResponse: ServiceBeerResponse) -> [Malt] {
        serviceResponse.ingredients["malt"]?.array?.compactMap { $0["name"].rawString() }.map { Malt(name: $0) } ?? []
    }

    private static func parseHops(from serviceResponse: ServiceBeerResponse) -> [Hop] {
        serviceResponse.ingredients["hops"]?.array?.compactMap { $0["name"].rawString() }.map { Hop(name: $0) } ?? []
    }
}

struct ServiceBeerResponse: Decodable {
    let name: String
    let imageUrl: String
    let abv: Float
    let description: String
    let method: [String: JSON]
    let ingredients: [String: JSON]

    enum CodingKeys: String, CodingKey {
        case name
        case imageUrl = "image_url"
        case abv
        case description
        case method
        case ingredients
    }
}

