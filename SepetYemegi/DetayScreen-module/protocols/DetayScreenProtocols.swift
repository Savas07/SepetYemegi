//
//  DetayScreenProtocols.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 3.04.2022.
//

import Foundation
import Alamofire
//Ana protokoller
protocol DetayViewToPresenterProtocol{//Presenter
    var interactor:DetayPresenterToInteractorProtocol?{get set}
    func sepeteEkleButton(params:Parameters)
}

protocol DetayPresenterToInteractorProtocol{//Interactor
    func sepeteEkleButton(params:Parameters)
}
//router
protocol DetayPresenterToRouterProtocol{//Router
    static func createModule(ref:DetayScreenVC)
}
