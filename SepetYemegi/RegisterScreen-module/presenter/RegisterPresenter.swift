//
//  RegisterPresenter.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 3.04.2022.
//

import Foundation
import UIKit

class RegisterPresenter:RegisterViewToPresenterProtocol{
    var view: RegisterPresenterToViewProtocol?
    
    var interactor: RegisterPresenterToInteractorProtocol?
    
    func kayitOl(email: String?, password: String?) {
        interactor?.register(email: email, password: password)
    }
    
    
}

extension RegisterPresenter:RegisterInteractorToPresenterProtocol{
    func presentAlert(alertController: UIAlertController) {
        view?.presentAlert(alertController: alertController)
    }

    
}
