//
//  YemeklerCollectionViewCell.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 28.03.2022.
//

import UIKit
import Alamofire
import SwiftUI

class YemeklerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var yemekImageView: UIImageView!
    @IBOutlet weak var yemekAdiLabel: UILabel!
    @IBOutlet weak var yemekFiyatLabel: UILabel!
    var yemekResimAd:String?
    let ud = UserDefaults.standard
    
    @IBAction func sepeteEkleButton(_ sender: Any) {
        var yemekFiyat = yemekFiyatLabel.text!
        yemekFiyat.removeLast()
        yemekFiyat = yemekFiyat.trimmingCharacters(in: .whitespacesAndNewlines)
        let yemekFiyatInt = Int(yemekFiyat)
        
        let params:Parameters = ["yemek_adi":yemekAdiLabel.text!,"yemek_resim_adi":yemekResimAd!,"yemek_fiyat":yemekFiyatInt!,"kullanici_adi": ud.string(forKey: "username")!,"yemek_siparis_adet":1]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post, parameters: params).response{response in
            print("\(self.yemekAdiLabel.text!) sepete eklendi")
            
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
        
//      TODO: Sepete eklenince bildirim göster
        let alertController = UIAlertController(title: "Sipariş",message:"Ürün sepete eklendi!", preferredStyle: .alert)
        let tamamAction = UIAlertAction(title: "Tamam", style: .destructive)
        alertController.addAction(tamamAction)
        
//
        
    }
}
