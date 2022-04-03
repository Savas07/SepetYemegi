//
//  UrunlerProtocols.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 3.04.2022.
//

import Foundation
import Alamofire

//Ana protokoller
protocol UrunlerViewToPresenterProtocol{//Presenter
    var interactor:UrunlerPresenterToInteractorProtocol? {get set}
    var view:UrunlerPresenterToViewProtocol? {get set}

    func sepeteEkleButton(params:Parameters)

    func yemekleriAl()
}

protocol UrunlerPresenterToInteractorProtocol{//Interactor
    var presenter:UrunlerInteractorToPresenterProtocol?{get set}

    func sepeteEkleButton(params:Parameters)

    func tumYemekleriAl()
}
//Router
protocol UrunlerPresenterToRouterProtocol{//Router
    static func createModule(ref:UrunlerScreenVC)
}
//Taşıyıcı protokoller
protocol UrunlerInteractorToPresenterProtocol{//Presenter
    func presenteraVeriGonder(yemeklerListe: Array<Yemekler>)
}

protocol UrunlerPresenterToViewProtocol{//View
    func vieweVeriGonder(yemeklerListe: Array<Yemekler>)
}
