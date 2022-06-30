//
//  BeerRow.swift
//  Brewdog
//
//  Created by Izabela Kołyszko on 29/06/2022.
//

import SwiftUI

struct BeerRowView: View {
    let beer: Beer
    let image: UIImage

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 64, height: 64)
            Text(beer.name)
                .font(.system(size: 16))
            Spacer()
            VStack(alignment: .leading) {
                Text("ABV")
                    .font(.system(size: 12))
                Text("\(beer.abv)")
                    .font(.system(size: 14))
            }
        }
    }
}
