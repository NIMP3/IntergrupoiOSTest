//
//  CountryProtocol.swift
//  InterGrupoiOSTest
//
//  Created by Edwin Yovany on 17/06/22.
//

import Foundation

protocol ViewToPresenterCountryProtocol {
    var view: PresenterToViewCountryProtocol? {get set}
    var interactor: PresenterToInteractorCountryProtocol? {get set}
    var router: PresenterToRouterCountryProtocol? {get set}
    
    func getCountries()
}

protocol PresenterToViewCountryProtocol {
    func showCountries(countries: [Country])
    
    //Metodo para visualizar la vista de progreso de una transacción
    func showProgressBar()
    //Metodo para oculta la vista de progreso de una transacción
    func hideProgressBar()
    //Metodo para visualizar un mensaje en pantalla
    func showMessage(message: Message)
}

protocol PresenterToInteractorCountryProtocol {
    var presenter: InteractorToPresenterCountryProtocol? {get set}
    
    func getAccessToken()
    func getCountries()
    func processUserToken(token: String)
}

protocol InteractorToPresenterCountryProtocol {
    func onCountriesFound(countries: [Country])
    func onCountriesError()
    func onUserTokenFound(token: String)
    func onTransactionFailed(with message: Message) 
}

protocol PresenterToRouterCountryProtocol {
    static func createCountryModule(_ ref: CountryListViewController)
    func pushToMap(on view: PresenterToViewCountryProtocol)
}
