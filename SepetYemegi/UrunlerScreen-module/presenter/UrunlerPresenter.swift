//
//  UrunlerPresenter.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 3.04.2022.
//

import Foundation
import Firebase
import Alamofire
class UrunlerPresenter:UrunlerViewToPresenterProtocol{
    var interactor: UrunlerPresenterToInteractorProtocol?
    
    var view: UrunlerPresenterToViewProtocol?
    
    func sepeteEkleButton(params: Parameters) {
        interactor?.sepeteEkleButton(params: params)
    }
    
    func yemekleriAl() {
        interactor?.tumYemekleriAl()
    }
    
    
}

extension UrunlerPresenter:UrunlerInteractorToPresenterProtocol{
    func presenteraVeriGonder(yemeklerListe: Array<Yemekler>) {
        view?.vieweVeriGonder(yemeklerListe: yemeklerListe)
    }


}
