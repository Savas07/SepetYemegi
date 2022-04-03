//
//  registerScreenVC.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 26.03.2022.
//

import UIKit

class RegisterScreenVC: UIViewController {

    @IBOutlet weak var mailTextField: MyTextField!
    @IBOutlet weak var pwdTextField: MyTextField!
    
    var presenter:RegisterViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true

        RegisterRouter.createModule(ref: self)
//      Placeholder renkleri
        mailTextField.attributedPlaceholder = NSAttributedString(
            string: "Mail",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        pwdTextField.attributedPlaceholder = NSAttributedString(
            string: "Şifre",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
    
    @IBAction func registerButton(_ sender: Any) {

        presenter?.kayitOl(email: mailTextField.text, password: pwdTextField.text)

/*
        let signUpManager = FireBaseAuthManager()
        
        if let email = mailTextField.text, let password = pwdTextField.text {
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
                self.present(alertController, animated: true)
            }
        }
        */
        
    }
    

}

extension RegisterScreenVC:RegisterPresenterToViewProtocol{
    func presentAlert(alertController: UIAlertController) {
        self.present(alertController, animated: true)
    }
}
