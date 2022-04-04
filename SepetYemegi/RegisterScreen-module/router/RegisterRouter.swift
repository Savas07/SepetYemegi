//
//  RegisterRouter.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 3.04.2022.
//

import Foundation

class RegisterRouter:RegisterPresenterToRouterProtocol{
    static func createModule(ref: RegisterScreenVC) {
        let presenter = RegisterPresenter()

//        View
        ref.presenter = presenter
//       Presenter
        ref.presenter?.interactor = RegisterInteractor()
        ref.presenter?.view = ref
//        Interactor
        ref.presenter?.interactor?.presenter = presenter
    }

    
}
