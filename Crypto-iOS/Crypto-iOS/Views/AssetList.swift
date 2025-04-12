import SwiftUI

struct AssetList: View {
    
    var viewModel: AssetListViewModel = .init()

//    @State var task: Task<Void, Never>?
    
    var body: some View {
        NavigationStack {
            
            Text(viewModel.errorMessage ?? "")
                
            List {
                ForEach(viewModel.assets) { asset in
                    NavigationLink {
                        AssetDetailView(asset: asset)
                    } label: {
                        AssetView(assetViewState: .init(asset))
                    }
                }
            }
            .listStyle(.plain)
            .task {
               await viewModel.fetchAssets()
            }
            .navigationTitle("Home")
            
        }
       
//        .onAppear {
//            task = Task {
//                await viewModel.fetchAssets()
//            }
//        }
//        .onDisappear {
//            task?.cancel()
//        }
    }
}

#Preview {
    AssetList()
}
