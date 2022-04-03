//
//  LoginInteractor.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 1.04.2022.
//

import Foundation
import Alamofire
import UIKit

class LoginInteractor:LoginPresenterToInteractorProtocol{
    var presenter: LoginViewToPresenterProtocol?
    
    let ud = UserDefaults.standard
    
    func girisYap(email: String?, password: String?) {
        let loginManager = FireBaseAuthManager()
        guard let email = email, let password = password else { return }
            loginManager.signIn(email: email, pass: password) {[weak self] (success) in
                guard let `self` = self else { return }
                var message: String = ""
                if (success) {
//                    Signed in User Default burada
                    self.ud.set(true,forKey: "signedIn")
                    self.ud.set(email,forKey: "username")
                    
                    self.presenter?.view?.setKullanici(email: email)
//                  self.kullanici?.kullaniciAd = email
//                  self.performSegue(withIdentifier: "toUrunler", sender: nil)
                    
                } else {
                    message = "Hatalı giriş."
                    
                    let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    
                    self.presenter?.view?.presentAlert(alertController: alertController)
//                  self.present(alertController,animated: true)
                }
                
            }
    }
}
