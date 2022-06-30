//
//  BeerDetailsView.swift
//  Brewdog
//
//  Created by Izabela Kołyszko on 29/06/2022.
//

import SwiftUI

struct BeerDetailsView: View {
    let beer: Beer
    let image: UIImage
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {

                HStack{
                    Spacer()
                    VStack(alignment: .center, spacing: 8) {
                        Text(beer.name)
                            .font(.system(size: 24).bold())
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 144, height: 144)
                    }
                    Spacer()
                }


                VStack(alignment: .leading, spacing: 4) {
                    Text("Description")
                        .font(.system(size: 14).bold())
                    Text(beer.description)
                        .font(.system(size: 16))
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("Methods")
                        .font(.system(size: 14).bold())
                    ForEach(beer.methods, id: \.self) {
                        Text($0.name)
                            .font(.system(size: 16))
                    }
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("Malts")
                        .font(.system(size: 14).bold())
                    ForEach(beer.malts, id: \.self) {
                        Text($0.name)
                            .font(.system(size: 16))
                    }
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("Hops")
                        .font(.system(size: 14).bold())
                    ForEach(beer.hops, id: \.self) {
                        Text($0.name)
                            .font(.system(size: 16))
                    }
                }
            }
        }.padding([.leading, .trailing], 24)
    }
}
