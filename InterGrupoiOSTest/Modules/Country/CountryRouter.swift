//
//  CountryRouter.swift
//  InterGrupoiOSTest
//
//  Created by Edwin Yovany on 17/06/22.
//

import Foundation

class CountryRouter: PresenterToRouterCountryProtocol {
    static func createCountryModule(_ ref: CountryListViewController) {
        let presenter: ViewToPresenterCountryProtocol & InteractorToPresenterCountryProtocol = CountryPresenter()
        
        ref.presenter = presenter
        ref.presenter?.router = CountryRouter()
        ref.presenter?.view = ref
        ref.presenter?.interactor = CountryInteractor()
        ref.presenter?.interactor?.presenter = presenter
    }
    
    func pushToMap(on view: PresenterToViewCountryProtocol) {
        
    }
    
    
}
