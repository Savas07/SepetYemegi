//
//  SepetInteractor.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 3.04.2022.
//

import Foundation
import Alamofire

class SepetInteractor:SepetPresenterToInteractorProtocol{
    let ud = UserDefaults.standard
    var presenter: SepetInteractorToPresenterProtocol?

    func yemekSil(params: Parameters) {
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response{response in
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

    func sepetiAl() {
        let params:Parameters = ["kullanici_adi": ud.string(forKey: "username")!]

        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response{response in

            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(SepetYemeklerCevap.self, from: data)

                    if let gelenListe = cevap.sepet_yemekler{
//                      presentera veri gönder
                        
//                        self.sepet = gelenListe
                        self.presenter?.presenteraVeriGonder(sepetListe: gelenListe)

                        var ucret = 0
                        for i in gelenListe{
                            ucret += Int(exactly: Int(i.yemek_fiyat!)! * Int(i.yemek_siparis_adet!)!)!
//                          Presenterdan veri gönder
//                            self.totalUcret = ucret
                            self.presenter?.presenteraUcretGonder(totalUcret: ucret)
//                            self.toplamUcretLabel.text = "\(self.totalUcret) ₺"
                        }

//                        DispatchQueue.main.async {
//                            self.sepetTableView.reloadData()
//                        }
                    }
                }catch{
                    print("Post metod da hata")
                    print(String(describing: error))
                }
            }
        }
    }

    
}
