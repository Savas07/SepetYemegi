//
//  DetayRouter.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 3.04.2022.
//

import Foundation

class DetayRouter:DetayPresenterToRouterProtocol{
    static func createModule(ref: DetayScreenVC) {
        ref.presenter = DetayPresenter()
        ref.presenter?.interactor = DetayInteractor()
    }   
}
