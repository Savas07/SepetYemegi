//
//  RegisterInteractor.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 3.04.2022.
//

import Foundation
import Firebase
import UIKit

class RegisterInteractor:RegisterPresenterToInteractorProtocol{
    var presenter: RegisterViewToPresenterProtocol?

    func register(email: String?, password: String?) {
        let signUpManager = FireBaseAuthManager()

        if let email = email, let password = password {
            signUpManager.createUser(email: email, password: password) {[weak self] (success) in
                guard let `self` = self else {return}
                var message:String = ""
                if(success) {
                    message = "Kayıt oluşturuldu!"
                }else{
                    message = "Hatalı giriş"
                }

                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                
                self.presenter?.view?.presentAlert(alertController: alertController)
            }
        }
    }
    
    
}
