//
//  CountryInteractor.swift
//  InterGrupoiOSTest
//
//  Created by Edwin Yovany on 17/06/22.
//

import Foundation
import KeychainSwift

class CountryInteractor: PresenterToInteractorCountryProtocol {
    var presenter: InteractorToPresenterCountryProtocol?
    let keychain = KeychainSwift()
    var token: String? { get { return keychain.get("token-key")}}
    
    private let api_token = "B67waL-tp99mJMrmsWdc97gkxgg8O2cgSmRDxELY1B6qPdbYYocoLLezl7922vqwfuI"
    private let email = "yovany.dev@gmail.com"
    
    func getAccessToken() {
        if(NetworkUtility.isConnected()) {
            CountryService.getAccessToken(api_token,email) { response, error in
                if let response = response {
                    self.presenter?.onUserTokenFound(token: response.auth_token)
                }
                else { self.presenter?.onTransactionFailed(with: Message(error: error ?? .system(code: "XD2312"))) }
            }
        }
        else { presenter?.onTransactionFailed(with: Message(error: .network))}
    }
    
    func getCountries() {
        if(NetworkUtility.isConnected()) {
            if let token = token {
                CountryService.getCountries(token: token) { response, error in
                    if let countries = response{
                        if !countries.isEmpty { self.presenter?.onCountriesFound(countries: countries) }
                        else { self.presenter?.onTransactionFailed(with: Message(error: .notFoundData(entity: "regiones..."))) }
                    }
                    else { self.presenter?.onTransactionFailed(with: Message(error: error ?? .system(code: "XD2312"))) }
                }
            }
            else { getAccessToken() }
        }
    }
    
    func processUserToken(token: String) {
        keychain.set(token, forKey: "token-key")
    }
    
    
}
