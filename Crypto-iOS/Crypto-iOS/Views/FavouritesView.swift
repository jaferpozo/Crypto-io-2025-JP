import SwiftUI
struct FavouritesView: View {

    @State var viewModel: FavouritesViewModel = .init()
    var body: some View {
        List {
            ForEach(viewModel.assets) { asset in
                AssetView(
                    assetViewState: .init(asset)
                )
            }
        }
        .listStyle(.plain)
        .task {
            await viewModel.getFavourites()
        }
    }
}
 
#Preview {
    FavouritesView()
}
