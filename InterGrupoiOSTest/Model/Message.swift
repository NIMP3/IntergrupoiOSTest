//
//  Message.swift
//  InterGrupoiOSTest
//
//  Created by Edwin Yovany on 17/06/22.
//

import Foundation


enum TypeOfErrors: String{
    case error = "error"
    case check = "check"
    case info = "info"
    case question = "question"
    case warning = "warning"
    case loader = "loader"
}

class Message {
    let title: String
    let message: String
    let type: TypeOfErrors
    
    init(title: String = "ERROR", message: String = "Se presento un error en el sistema.", type: TypeOfErrors = .error) {
        
        self.title = title
        self.message = message
        self.type = type
    }
    
    init(error: BackendError) {
        
        switch error {
        case .network:
            self.title = "Error de Conexión"
            self.message = "¡Parece que no hay Internet!\nPor favor revisa tu conexión para seguir navegando."
            self.type = .warning
        case .timeOut:
            self.title = "Error del Servidor"
            self.message = "¡Lo sentimos! No se ha establecido la conexión con el Servidor, porfavor intenta nuevamente."
            self.type = .error
        case let .system(code):
            self.title = "Error del Sistema"
            self.message = "¡Lo sentimos! Se presentó un error en el Sistema - \(code)."
            self.type = .error
        case let .server(code):
            self.title = "Error del Servidor"
            self.message = "¡Lo sentimos! Se presentó un error en el Servidor - \(code)."
            self.type = .error
        case let .notFoundData(entity):
            self.title = "Información"
            self.message = "No se encontraron \(entity)"
            self.type = .info
        }
    }
}
