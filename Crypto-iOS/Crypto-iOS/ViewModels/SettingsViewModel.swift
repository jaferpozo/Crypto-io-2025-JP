import Foundation
import Dependencies

@Observable
final class SettingsViewModel {
    @ObservationIgnored
    @Dependency(\.authClient) var authClient
    var email: String = ""
    var password: String = ""
    var showError = false
    var errorMessage: String = ""
    var user: User?
    init() {
        user = try? authClient.getCurrentUser()
    }
    
    func login() async {
        do {
            user = try await authClient.signIn(email, password)
            email = ""
            password = ""
        } catch {
            showError = true
            errorMessage = error.localizedDescription
        }
    }
    
    func logout() {
        do {
            try authClient.signOut()
            user = nil
        } catch {
            showError = true
            errorMessage = error.localizedDescription
        }
    }
}
