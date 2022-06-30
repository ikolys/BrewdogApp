//
//  BeersViewModel.swift
//  Brewdog
//
//  Created by Izabela Kołyszko on 29/06/2022.
//

import Foundation

class BeersViewModel: ObservableObject {

    //private let service: BeersService
    @Published var beers: [Beer] = []

    init(service: BeersService = PunkapiBeersService()) {
        //self.service = service
        service.beersPublisher().receive(on: RunLoop.main).assign(to: &$beers)
    }
}
