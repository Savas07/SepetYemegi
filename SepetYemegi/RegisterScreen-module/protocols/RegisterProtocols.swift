//
//  RegisterProtocols.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 3.04.2022.
//

import Foundation
import UIKit
//Ana protokoller
protocol RegisterViewToPresenterProtocol{//Presenter
    var view:RegisterPresenterToViewProtocol? {get set}
    var interactor:RegisterPresenterToInteractorProtocol? {get set}

    func kayitOl(email:String?, password:String?)
}

protocol RegisterPresenterToInteractorProtocol{//Interactor
    var presenter:RegisterViewToPresenterProtocol? { get set }

    func register(email:String?, password:String?)
}
//Taşıyıcı protokoller
protocol RegisterInteractorToPresenterProtocol{//Presenter

    func presentAlert(alertController: UIAlertController)
}

protocol RegisterPresenterToViewProtocol{//View
    func presentAlert(alertController: UIAlertController)
}
//Router
protocol RegisterPresenterToRouterProtocol{//Router
    static func createModule(ref:RegisterScreenVC)
}
