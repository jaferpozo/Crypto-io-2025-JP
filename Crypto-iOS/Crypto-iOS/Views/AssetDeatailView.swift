import SwiftUI
struct AssetDeatailView:View {
    @State var viewModel: AssetDetailsViewModel

    var body: some View {
        
        VStack {
                    Text(viewModel.asset.name)
                    Button {
                        Task {
                            await viewModel.addToFavourites()
                        }
                    } label: {
                        Text("Add to favourites")
                    }
                }
                .navigationTitle(viewModel.asset.name)
                .alert(
                    viewModel.errorMessage,
                    isPresented: $viewModel.showError) {
                        Button("OK") {
                        }
                    }
            }
         
        }
#Preview {
    NavigationStack {
        AssetDeatailView(
            viewModel: .init(
                asset: .init(
                id:"bitcoin",
                name:"Bitcoin",
                symbol:"BTC",
                priceUsd:"78787.87687687",
                changePercent24Hr: "213123123.87897")
             
            )
        )
    }
  
}
