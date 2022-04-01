//
//  ViewController.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 24.03.2022.
//

import UIKit

class LoginScreenVC: UIViewController {
    @IBOutlet weak var mailTextField: MyTextField!
    @IBOutlet weak var pwdTextField: MyTextField!
    
    var kullanici:Kullanici?
//    UserDefaults
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        UserDefault
        
        let signedIn = ud.bool(forKey: "signedIn")
        
        if signedIn{
            self.performSegue(withIdentifier: "toUrunler", sender: nil)
        }else{
            mailTextField.text = ud.string(forKey: "username")
        }
        
        navigationItem.largeTitleDisplayMode = .never
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pwdTextField.text = ""
    }

    @IBAction func loginButton(_ sender: Any) {
        let loginManager = FireBaseAuthManager()
            guard let email = mailTextField.text, let password = pwdTextField.text else { return }
            loginManager.signIn(email: email, pass: password) {[weak self] (success) in
                guard let `self` = self else { return }
                var message: String = ""
                if (success) {
//                    Signed in User Default burada
                    self.ud.set(true,forKey: "signedIn")
                    self.ud.set(email,forKey: "username")
                    
                    message = "User was sucessfully logged in."
                    
                    self.kullanici?.kullaniciAd = email
                    
                    self.performSegue(withIdentifier: "toUrunler", sender: nil)
                    
                } else {
                    message = "There was an error."
                }
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController,animated: true)
            }
    }
    
    @IBAction func registerButton(_ sender: Any) {
        
        performSegue(withIdentifier: "toRegister", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "toUrunler"{
            
            let controller = segue.destination as! UrunlerScreenVC
            
            controller.kullaniciAdi = ud.string(forKey: "username") //      kullanici?.kullaniciAd
            
            
//            controller.navigationController?.isNavigationBarHidden = true
//            controller.navigationItem .setHidesBackButton(true, animated: false)
        }
        
    }

    
}

