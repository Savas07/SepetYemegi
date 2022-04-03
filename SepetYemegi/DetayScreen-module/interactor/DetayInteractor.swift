//
//  DetayInteractor.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 3.04.2022.
//

import Foundation
import Alamofire
class DetayInteractor:DetayPresenterToInteractorProtocol{
    func sepeteEkleButton(params: Parameters) {
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post, parameters: params).response{response in

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
}
