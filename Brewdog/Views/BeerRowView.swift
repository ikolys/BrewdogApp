//
//  BeerRow.swift
//  Brewdog
//
//  Created by Izabela Kołyszko on 29/06/2022.
//

import SwiftUI

struct BeerRowView: View {
    let beer: Beer

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(uiImage: beer.image())
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

extension Beer {
    func image() -> UIImage {
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
