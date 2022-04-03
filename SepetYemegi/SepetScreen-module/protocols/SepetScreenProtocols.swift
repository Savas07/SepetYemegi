//
//  SepetScreenProtocols.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 3.04.2022.
//

import Foundation
import Alamofire
//Ana protokoller
protocol SepetViewToPresenterProtocol{//Presenter
    var interactor:SepetPresenterToInteractorProtocol? {get set}
    var view:SepetPresenterToViewProtocol? {get set}

    func yemekSil(params:Parameters)
    func sepetiAl()
    
}
protocol SepetPresenterToInteractorProtocol{//Interactor
    var presenter:SepetInteractorToPresenterProtocol?{get set}

    func yemekSil(params:Parameters)
    func sepetiAl()
}
//Router
protocol SepetPresenterToRouterProtocol{//Router
    static func createModule(ref:SepetScreenVC)
}
//Taşıyıcı protokoller
protocol SepetInteractorToPresenterProtocol{//Presentera veri
    func presenteraVeriGonder(sepetListe:Array<SepetYemekler>)
    func presenteraUcretGonder(totalUcret:Int?)
}
protocol SepetPresenterToViewProtocol{//Viewe veri
    func vieweVeriGonder(sepetListe:Array<SepetYemekler>)
    func vieweUcretGonder(totalUcret:Int?)
    
}
