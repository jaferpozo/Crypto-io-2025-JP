import Foundation
import Dependencies

@Observable
final class AssetListViewModel {
    
    var errorMessage: String?
    var assets: [Asset] = []
    
    @ObservationIgnored
    @Dependency(\.assetsApiClient) var apiClient
    
    var clientConfigured = false
    
    func configClient() {
        clientConfigured = true
    }
    
    func fetchAssets() async {
        do {
            assets = try await apiClient.fetchAllAssets()
        } catch let error as NetworkingError {
            errorMessage = error.localizedDescription
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

//
//final class AAViewModel: ObservableObject {
//    
//    @Published var assets: [Asset] = []
//    @Published var errorMessage: String?
//    
//    var apiClient: AssetsApiClient
//    
//    init(assets: [Asset], errorMessage: String? = nil, apiClient: AssetsApiClient) {
//        self.assets = assets
//        self.errorMessage = errorMessage
//        self.apiClient = apiClient
//    }
//    
//    func fetchAssets() async {
//        
//    }
//}
