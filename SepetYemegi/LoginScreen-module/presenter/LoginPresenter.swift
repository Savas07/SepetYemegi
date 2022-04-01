//
//  LoginPresenter.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 1.04.2022.
//

import Foundation

class LoginPresenter:LoginViewToPresenterProtocol{
    var interactorNesnesi: LoginPresenterToInteractorProtocol?
    
    func giris() {
        interactorNesnesi?.girisYap()
    }
    
    
}
