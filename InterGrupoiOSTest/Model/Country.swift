//
//  Country.swift
//  InterGrupoiOSTest
//
//  Created by Edwin Yovany on 16/06/22.
//

import Foundation

struct Country: Decodable {
    let name: String
    let short_name : String
    let phone_code : Int
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String.self, forKey: .name)
        short_name = try values.decode(String.self, forKey: .short_name)
        phone_code = try values.decode(Int.self, forKey: .phone)
    }
    
    private enum CodingKeys: String, CodingKey {
        case name = "country_name"
        case short_name = "country_short_name"
        case phone = "country_phone_code"
    }
}
