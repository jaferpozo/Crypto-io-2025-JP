import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                AssetList()
            }
            Tab("Favourites", systemImage: "star") {
                Text("Favourites")
            }
            Tab("Settings", systemImage: "gear") {
                Text("Settings")
            }
        }
    }
}

#Preview {
    AppTabView()
}
