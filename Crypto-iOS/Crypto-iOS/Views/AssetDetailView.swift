import SwiftUI

struct AssetDetailView: View {
    
    let asset: Asset
    
    var body: some View {
        Text(asset.name)
            .navigationTitle(asset.name)
    }
}

#Preview {
    NavigationStack {
        AssetDetailView(
            asset: .init(
                id: "bitcoin",
                name: "Bitcoin",
                symbol: "BTC",
                priceUsd: "123123.123123",
                changePercent24Hr: "9.99292"
            )
        )
    }
    
}
