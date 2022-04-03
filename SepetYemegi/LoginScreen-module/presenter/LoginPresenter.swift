//
//  LoginPresenter.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 1.04.2022.
//

import Foundation
import UIKit

class LoginPresenter:LoginViewToPresenterProtocol{
    var view: LoginPresenterToViewProtocol?
    
    var interactorNesnesi: LoginPresenterToInteractorProtocol?
    
    func giris(email: String?, password: String?) {
        interactorNesnesi?.girisYap(email: email, password: password)
    }
}

extension LoginPresenter:LoginInteractorToPresenterProtocol{
    func presentAlert(alertController: UIAlertController) {
        view?.presentAlert(alertController: alertController)
    }
    
    func setKullanici(email: String?) {
        view?.setKullanici(email: email)
    }  
}
