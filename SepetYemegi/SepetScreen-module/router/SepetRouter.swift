//
//  SepetRouter.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 3.04.2022.
//

import Foundation

class SepetRouter:SepetPresenterToRouterProtocol{
    static func createModule(ref: SepetScreenVC) {
        let presenter = SepetPresenter()
//        View
        ref.presenter = presenter
//        Presenter
        ref.presenter?.interactor = SepetInteractor()
        ref.presenter?.view = ref
//          Interactor
        ref.presenter?.interactor?.presenter = presenter

    }
}
