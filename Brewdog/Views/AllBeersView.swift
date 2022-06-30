//
//  ContentView.swift
//  Brewdog
//
//  Created by Izabela Kołyszko on 29/06/2022.
//
import SwiftUI
import Combine

struct AllBeersView: View {
    @ObservedObject var viewModel = BeersViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.beers, id: \.self) { beer in
                NavigationLink(destination: BeerDetailsView(beer: beer)) {
                    BeerRowView(beer: beer)
                }
            }.navigationBarTitle("Some beers...")
        }
    }
}

struct AllBeersView_Previews: PreviewProvider {
    static var previews: some View {
        AllBeersView(viewModel: BeersViewModel(service: PreviewService()))
    }

    class PreviewService: BeersService {
        func beersPublisher() -> AnyPublisher<[Beer], Never> {
            Just([
                Beer(name: "First", imageUrl: "https://images.punkapi.com/v2/2.png", abv: 3.0, description: "1234", methods: [Beer.Method(name: "x")], malts: [Beer.Malt(name: "malt1")], hops: [Beer.Hop(name: "hop1")]),
                Beer(name: "Second", imageUrl: "https://images.punkapi.com/v2/keg.png", abv: 4.5, description: "1234", methods: [Beer.Method(name: "x")], malts: [Beer.Malt(name: "malt1")], hops: [Beer.Hop(name: "hop1")]),
                Beer(name: "Third", imageUrl: "https://images.punkapi.com/v2/5.png", abv: 4.1, description: "1234", methods: [Beer.Method(name: "x")], malts: [Beer.Malt(name: "malt1")], hops: [Beer.Hop(name: "hop1")])
            ]).eraseToAnyPublisher()
        }
    }
}
