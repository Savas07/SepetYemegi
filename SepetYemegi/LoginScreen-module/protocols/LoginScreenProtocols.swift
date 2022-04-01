//
//  LoginScreenProtocols.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 1.04.2022.
//

import Foundation

protocol LoginViewToPresenterProtocol{//Presenter
    var interactorNesnesi:LoginPresenterToInteractorProtocol? { get set }
    func giris()
}

protocol LoginPresenterToInteractorProtocol{//Interactor
    func girisYap()
}

protocol LoginPresenterToRouterProtocol{
    static func createModule(ref:LoginScreenVC)
}
