import SwiftUI

struct AssetList: View {
    
    @State var viewModel: AssetListViewModel = .init()
    
    var body: some View {
        Text(viewModel.errorMessage ?? "")
        List {
            ForEach(viewModel.assets, id: \.id) { asset in
                AssetView(asset: asset)
            }
        }
        .listStyle(.plain)
        .task {
            await viewModel.fetchAssets()
        }
    }
}

#Preview {
    AssetList()
}
