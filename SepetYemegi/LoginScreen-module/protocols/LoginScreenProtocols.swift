//
//  LoginScreenProtocols.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 1.04.2022.
//

import Foundation
import UIKit
//Ana protokoller
protocol LoginViewToPresenterProtocol{//Presenter
    var interactorNesnesi:LoginPresenterToInteractorProtocol? { get set }
    var view:LoginPresenterToViewProtocol? { get set }
    
    func giris(email:String?, password:String?)
}

protocol LoginPresenterToInteractorProtocol{//Interactor
    var presenter:LoginViewToPresenterProtocol? { get set }
    func girisYap(email:String?, password:String?)
}
//Router
protocol LoginPresenterToRouterProtocol{
    static func createModule(ref:LoginScreenVC)
}
//Taşıyıcı protokoller
protocol LoginInteractorToPresenterProtocol{
    func setKullanici(email:String?)
    func presentAlert(alertController:UIAlertController)
}

protocol LoginPresenterToViewProtocol{
    func setKullanici(email:String?)
    func presentAlert(alertController:UIAlertController)
    
}
