//
//  Service.swift
//  Brewdog
//
//  Created by Izabela Kołyszko on 29/06/2022.
//

import Combine
import Foundation

protocol BeersService {
    func beersPublisher() -> AnyPublisher<[Beer], Never>
}

protocol URLSessionProtocol {
    func dataTaskPublisher(for url: URL) -> URLSession.DataTaskPublisher
}

extension URLSession: URLSessionProtocol {}

class PunkapiBeersService: BeersService {
    private let urlSession: URLSessionProtocol
    private let url = URL(string: "https://api.punkapi.com/v2/beers?abv_gt=9")!

    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }

    func beersPublisher() -> AnyPublisher<[Beer], Never> {
        urlSession
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [ServiceBeerResponse].self, decoder: JSONDecoder())
            .map { $0.mapToBeers() }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}

extension Array where Element == ServiceBeerResponse {
    func mapToBeers() -> [Beer] {
        map { Beer(from: $0) }
    }
}
