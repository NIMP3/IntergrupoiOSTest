//
//  CountryPresenter.swift
//  InterGrupoiOSTest
//
//  Created by Edwin Yovany on 17/06/22.
//

import Foundation

class CountryPresenter: ViewToPresenterCountryProtocol {
    var view: PresenterToViewCountryProtocol?
    var interactor: PresenterToInteractorCountryProtocol?
    var router: PresenterToRouterCountryProtocol?
    
    func getCountries() {
        view?.showProgressBar()
        interactor?.getCountries()
    }
}

extension CountryPresenter: InteractorToPresenterCountryProtocol {
    func onCountriesFound(countries: [Country]) {
        view?.hideProgressBar()
        view?.showCountries(countries: countries)
    }
    
    func onCountriesError() {
        interactor?.getAccessToken()
    }
    
    func onUserTokenFound(token: String) {
        interactor?.processUserToken(token: token)
        interactor?.getCountries()
    }
    
    func onTransactionFailed(with message: Message) {
        view?.showMessage(message: message)
    }
}
