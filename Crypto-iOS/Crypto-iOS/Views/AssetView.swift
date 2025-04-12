import SwiftUI

struct AssetView: View {
    
    let asset: Asset
    
    var body: some View {
        HStack {
            
            AsyncImage(
                url: asset.iconUrl) {
                image in image
                    .resizable()
            } placeholder: {
                Image(
                    systemName: "dollarsign.gauge.chart.lefthalf.righthalf"
                )
                    }
            .frame(
                width: 40,
                height:40
            )
            
            
            VStack (alignment: .leading){
                Text(asset.symbol)
                    .font(.headline)
                Text(asset.name)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
        
        Spacer()
        
            Text(asset.formattedPercentage)
            .foregroundStyle(asset.percentage >= 0 ? .green : .red)
            Text(asset.formattedPrice)
        }
        .padding(.horizontal)
    }
}


#Preview {
    AssetView(
        asset: .init(
            id: "bitcoin",
            name: "Bitcoin",
            symbol: "BTC",
            priceUsd: "89999",
            changePercent24Hr: "6.99"
        )
    )
}
