//
//  UrunlerInteractor.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 3.04.2022.
//

import Foundation
import Firebase
import UIKit
import Alamofire

class UrunlerInteractor:UrunlerPresenterToInteractorProtocol{
    var presenter: UrunlerInteractorToPresenterProtocol?

    func sepeteEkleButton(params: Parameters) {
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post, parameters: params).response{response in
//            print("\(self.yemekAdiLabel.text!) sepete eklendi")

            if let data = response.data{
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                        print(json)
                    }
                }catch{
                    print("post metod da hata")
                    print(String(describing: error))
                }
            }
        }
    }
    
    func tumYemekleriAl() {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response{response in

            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(YemeklerCevap.self, from: data)

                    if let gelenListe = cevap.yemekler{
                        
                        self.presenter?.presenteraVeriGonder(yemeklerListe: gelenListe)
//                        self.yemeklerListe = gelenListe

                        DispatchQueue.main.async {
//                            self.yemeklerCollectionView.reloadData()
                        }

                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }

    
}
