//
//  CountryService.swift
//  InterGrupoiOSTest
//
//  Created by Edwin Yovany on 16/06/22.
//

import Foundation
import Alamofire

class CountryService {
    static func getAccessToken(
        _ api_token: String,
        _ email: String,
        completion: @escaping(UserToken?, BackendError?) -> Void) {
            
            let headers: HTTPHeaders = ["api-token" : api_token, "user-email" : email]
            
            AF.request(EndPoints.getAccessToken,
                       method: .get,
                       encoding: URLEncoding.default,
                       headers: headers)
                {$0.timeoutInterval = 30 }
                .responseDecodable(of: UserToken.self) { response in
                    
                    switch response.result {
                    case let .success(userToken):
                        let statusCode = response.response?.statusCode ?? 500
                        
                        if statusCode == 200 { completion(userToken, nil) }
                        else { completion(nil, .server(code: BackendError.notFoundData)) }
                    case .failure:
                        completion(nil, .server(code: BackendError.notFoundData))
                    }
                    
                }.resume()
            
    }
    
    static func getCountries(
        token: String,
        completion: @escaping([Country]?, BackendError?) -> Void) {
            
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(token)"]
        
        AF.request(EndPoints.getCountries,
                   method: .get,
                   encoding: URLEncoding.default,
                   headers: headers)
            {$0.timeoutInterval = 30 }
                .responseDecodable(of: [Country].self) { response in
                
                switch response.result {
                case let .success(countries):
                    let statusCode = response.response?.statusCode ?? 500
                    
                    if statusCode == 200 { completion(countries, nil) }
                    else { completion(nil, .server(code: BackendError.notFoundData)) }
                case .failure:
                    completion(nil, .server(code: BackendError.notFoundData))
                }
                
            }.resume()
    }
}
