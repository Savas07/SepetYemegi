//
//  LoginRouter.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 1.04.2022.
//

import Foundation

class LoginRouter:LoginPresenterToRouterProtocol{
    static func createModule(ref: LoginScreenVC) {
        let presenter = LoginPresenter()
        
//      view
        ref.presenter = presenter
//      presenter
        ref.presenter?.interactorNesnesi = LoginInteractor()
        ref.presenter?.view = ref
//      Interactor
        ref.presenter?.interactorNesnesi?.presenter = presenter
        
    }
}
