import Foundation
import FirebaseAuth
import FirebaseFirestore

@Observable
final class AssetDetailsViewModel {
    let asset: Asset
    var errorMessage: String = ""
    var showError: Bool = false

    init(asset: Asset) {
        self.asset = asset
    }

    func addFavourites() {
        guard let user = Auth.auth().currentUser else {
            errorMessage = "Usuario no Autenticado"
            showError = true
            return
        }

        let userId = user.uid
        let db = Firestore.firestore()
        
        db.collection("favourites").document(userId).setData(
            ["favourites": FieldValue.arrayUnion([asset.id])],
            merge: true
        ) { error in
            if let error = error {
                self.errorMessage = "Error al agregar favorito: \(error.localizedDescription)"
                self.showError = true
            }
        }
    }
}
