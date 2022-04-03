//
//  UrunlerRouter.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 3.04.2022.
//

import Foundation

class UrunlerRouter:UrunlerPresenterToRouterProtocol{
    static func createModule(ref: UrunlerScreenVC) {
        let presenter = UrunlerPresenter()
//       View
        ref.presenter = presenter
//        presenter
        ref.presenter?.interactor = UrunlerInteractor()
        ref.presenter?.view = ref
//      Interactor
        ref.presenter?.interactor?.presenter = presenter
    }
    
    
}
