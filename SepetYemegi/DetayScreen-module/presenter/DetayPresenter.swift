//
//  DetayPresenter.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 3.04.2022.
//

import Foundation
import Alamofire

class DetayPresenter:DetayViewToPresenterProtocol{
    var interactor: DetayPresenterToInteractorProtocol?

    func sepeteEkleButton(params: Parameters) {
        interactor?.sepeteEkleButton(params: params)
    }

    
}
