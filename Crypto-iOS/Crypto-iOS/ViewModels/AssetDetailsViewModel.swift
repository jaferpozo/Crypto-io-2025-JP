import Foundation
import FirebaseAuth
import FirebaseFirestore
import Dependencies

@Observable
final class AssetDetailsViewModel {
    let asset: Asset
    var errorMessage: String = ""
    var showError: Bool = false
    @ObservationIgnored
       @Dependency(\.assetsApiClient) var apiClient

       @ObservationIgnored
       @Dependency(\.authClient) var authClient

    init(asset: Asset) {
        self.asset = asset
    }

    func addToFavourites() async {
           do {
               let user = try authClient.getCurrentUser()
               try await apiClient.saveFavourite(user, asset)
           } catch let error as AuthError {
               errorMessage = error.localizedDescription
            showError = true
            return
           } catch {
                      // TODO: Handle error
        }
    }
}
