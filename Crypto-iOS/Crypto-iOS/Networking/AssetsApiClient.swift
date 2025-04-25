import Dependencies
import Foundation
import FirebaseFirestore
import XCTestDynamicOverlay

struct AssetsApiClient {
    var fetchAllAssets: () async throws -> [Asset]
    var fetchAssets: (String) async throws -> Asset
    var saveFavourite: (User, Asset) async throws -> Void
    var fetchFavourites: (User) async throws -> [String]
}

enum NetworkingError: Error {
    case invalidURL
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        }
    }
}

extension AssetsApiClient: DependencyKey {
    static var liveValue: AssetsApiClient {
        let db = Firestore.firestore().collection("favourites")
        let urlSession = URLSession.shared
        let apiKey = ""
        let baseUrl = "https://rest.coincap.io/v3"
        
        return .init(
            fetchAllAssets: {
                guard let url = URL(string: "\(baseUrl)/assets?apiKey=\(apiKey)") else {
                    throw NetworkingError.invalidURL
                }
                let (data, _) = try await urlSession.data(for: URLRequest(url: url))
                let assetsResponse = try JSONDecoder().decode(AssetsResponse.self, from: data)
                return assetsResponse.data
            },
            fetchAssets: { assetId in
                guard let url = URL(string: "\(baseUrl)/assets/\(assetId)?apiKey=\(apiKey)") else {
                    throw NetworkingError.invalidURL
                }
                let (data, _) = try await urlSession.data(for: URLRequest(url: url))
                return try JSONDecoder().decode(Asset.self, from: data)
            },
            saveFavourite: { user, asset in
                try await db.document(user.id).setData(
                    ["favourites": FieldValue.arrayUnion([asset.id])],
                    merge: true
                )
            },
            fetchFavourites: { user in
                           let doc = try await db.document(user.id).getDocument()
                           let favourites = doc.get("favourites") as? [String]
                           return favourites ?? []
                       },
        )
    }

    static var previewValue: AssetsApiClient {
        .init(
            fetchAllAssets: {
                [
                    .init(id: "bitcoin", name: "Bitcoin", symbol: "BTC", priceUsd: "89111121.2828", changePercent24Hr: "8.99"),
                    .init(id: "ethereum", name: "Ethereum", symbol: "ETH", priceUsd: "1289.28", changePercent24Hr: "-1.23"),
                    .init(id: "solana", name: "Solana", symbol: "SOL", priceUsd: "500.29", changePercent24Hr: "9.28")
                ]
            },
            fetchAssets: { _ in .init(
                         id: "solana",
                         name: "Solana",
                         symbol: "SOL",
                         priceUsd: "500.29292929",
                         changePercent24Hr: "9.2828282"
                     )},
            saveFavourite: { _, _ in },
            fetchFavourites: { _ in []},
        )
    }

    static var testValue: AssetsApiClient {
        .init(
            fetchAllAssets: {
                XCTFail("AssetsApiClient.fetchAllAssets is unimplemented")
                return []
            },
            fetchAssets: { _ in
                XCTFail("AssetsApiClient.fetchAsset is unimplemented")
                return .init(
                    id: "solana",
                    name: "Solana",
                    symbol: "SOL",
                    priceUsd: "500.29292929",
                    changePercent24Hr: "9.2828282"
                )
            },
            saveFavourite: { _, _ in
                XCTFail("AssetsApiClient.saveFavourite is unimplemented")
            },
            fetchFavourites: { _ in
                    XCTFail("AssetsApiClietnt.fetchAsset is unimplemented")
                    return []
                },
        )
    }
}

extension DependencyValues {
    var assetsApiClient: AssetsApiClient {
        get { self[AssetsApiClient.self] }
        set { self[AssetsApiClient.self] = newValue }
    }
}
