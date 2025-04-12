import Foundation

@Observable
final class AssetListViewModel {
    
    var errorMessage: String?
    var assets: [Asset] = []
    
    func fetchAssets() async {
        let urlSession = URLSession.shared
        //una forma de traer variables opcionales que pueden o no existir
        guard let url = URL(string: "https://rest.coincap.io/v3/assets?apiKey=5afe9a3cc58cd3026d29a4dd7cec05ef0e1cef5a50072b547d8bcd62785ab287") else {
            errorMessage = "Invalid URL"
            return
        }
        
        do {
            let (data, _) = try await urlSession.data(for: URLRequest(url: url))
            let assetsResponse = try JSONDecoder().decode(AssetsResponse.self, from: data)
            self.assets = assetsResponse.data
        } catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
        }
    }
}
