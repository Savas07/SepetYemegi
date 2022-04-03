//
//  SepetInteractor.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 3.04.2022.
//

import Foundation
import Alamofire

class SepetPresenter:SepetViewToPresenterProtocol{
    var interactor: SepetPresenterToInteractorProtocol?

    var view: SepetPresenterToViewProtocol?

    func yemekSil(params: Parameters) {
        interactor?.yemekSil(params: params)
    }

    func sepetiAl() {
        interactor?.sepetiAl()
    }

    
}

extension SepetPresenter:SepetInteractorToPresenterProtocol{
    func presenteraVeriGonder(sepetListe: Array<SepetYemekler>) {
        view?.vieweVeriGonder(sepetListe: sepetListe)
    }

    func presenteraUcretGonder(totalUcret: Int?) {
        view?.vieweUcretGonder(totalUcret: totalUcret)
    }


}
