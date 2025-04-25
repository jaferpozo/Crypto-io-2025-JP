import SwiftUI
struct AppTabView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                AssetList()
            }
            Tab("Favourites", systemImage: "star") {
                FavouritesView()
            }
 
            Tab("Settings", systemImage: "gear") {
                SettingsView()
            }
        }
    }
}
 
#Preview {
    AppTabView()
}
