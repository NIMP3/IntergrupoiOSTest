//
//  BackendError.swift
//  InterGrupoiOSTest
//
//  Created by Edwin Yovany on 16/06/22.
//

import Foundation

enum BackendError: Error {
    static let parsingError = "12XDB"
    static let systemError = "10XCB"
    static let notFoundData = "11XDB"
    static let storageError = "08XAB"
    
    case network
    case timeOut
    case server(code: String)
    case system(code: String)
    case notFoundData(entity: String)
}
