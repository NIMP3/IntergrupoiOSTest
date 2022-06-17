//
//  ServerError.swift
//  InterGrupoiOSTest
//
//  Created by Edwin Yovany on 16/06/22.
//

import Foundation

struct ServerError: Decodable {
    let dataError: DataError
    
    init(from decoder: Decoder) throws {
        let values = try decoder.singleValueContainer()
        dataError = try values.decode(DataError.self)
    }
}

struct DataError: Decodable {
    let name: String
    let message: String
}
