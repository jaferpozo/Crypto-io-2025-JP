import Testing
import Dependencies

@testable import Crypto_iOS

var assetStub: Asset = .init(
    id: "bitcoin",
    name: "Bitcoin",
    symbol: "BTC",
    priceUsd: "80123.12",
    changePercent24Hr: "20.121212"
)

extension AssetsApiClient {
    static var mockWithFailure: AssetsApiClient {
        .init(fetchAllAssets: {
            throw NetworkingError.invalidURL
        })
    }
    
    static var mockWithSuccess: AssetsApiClient {
        .init(fetchAllAssets: {
            [ assetStub ]
        })
    }
}


struct AssetListViewModelTests {
    
    @Test func clientConfigured() {
        let viewModel = AssetListViewModel()
        
        viewModel.configClient()
        
        #expect(viewModel.clientConfigured == true)
    }
    
    @Test func fetchAssetsFailure() async throws {
        let viewModel = withDependencies {
            $0.assetsApiClient = .mockWithFailure
        } operation: {
            AssetListViewModel()
        }
        
        await viewModel.fetchAssets()
        
        #expect(viewModel.errorMessage == "Invalid URL")
    }
    
    @Test func fetchAssetsSuccess() async throws {
        let viewModel = withDependencies {
            $0.assetsApiClient = .mockWithSuccess
        } operation: {
            AssetListViewModel()
        }
        
        await viewModel.fetchAssets()
        
        #expect(viewModel.assets.count == 1)
        #expect(viewModel.assets == [ assetStub ])
    }
}
