import Foundation

struct Asset: Decodable, Identifiable, Equatable {
    let id: String
    let name: String
    let symbol: String
    let priceUsd: String
    let changePercent24Hr: String
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case symbol
//        case priceUsd = "price_usd"
//        case changePercent24Hr = "change_percent_24_hr"
//    }
}


//struct Persona: Identifiable {
//    
//    var id: String {
//        UUID().uuidString
//    }
//    
//    let ci: String
//    let name: String
//    let lastname: String
//}
