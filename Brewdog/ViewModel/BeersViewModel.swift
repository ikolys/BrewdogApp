//
//  BeersViewModel.swift
//  Brewdog
//
//  Created by Izabela Kołyszko on 29/06/2022.
//

import Foundation
import UIKit
import Combine

struct BeerData: Hashable {
    let beer: Beer
    let image: UIImage
}

class BeersViewModel: ObservableObject {
    private let service: BeersService
    @Published var beersData: [BeerData] = []
    @Published var isLoading = true
    var cancellables = Set<AnyCancellable>()

    init(service: BeersService = PunkapiBeersService()) {
        self.service = service

        service.beersPublisher()
            .receive(on: RunLoop.main)
            .map { beers in beers.map { BeerData(beer: $0, image: $0.getImage()) }}
            .sink(receiveValue: {
                self.beersData = $0
                self.isLoading = false
            })
            .store(in: &cancellables)
    }
}

extension Beer {
    func getImage() -> UIImage {
        let fallbackImage = UIImage(systemName: "photo.circle")!
        do {
            let imageData = try Data(contentsOf: URL(string: imageUrl)!)
            guard let image = UIImage(data: imageData) else {
                return fallbackImage
            }
            return image
        } catch {
            return fallbackImage
        }
    }
}
