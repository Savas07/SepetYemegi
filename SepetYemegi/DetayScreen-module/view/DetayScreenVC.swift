//
//  DetayScreenVC.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 29.03.2022.
//

import UIKit
import Alamofire

class DetayScreenVC: UIViewController {

    @IBOutlet weak var yemekImageView: UIImageView!
    @IBOutlet weak var yemekAd: UILabel!
    @IBOutlet weak var yemekFiyat: UILabel!
    @IBOutlet weak var adetPicker: UIPickerView!
    let ud = UserDefaults.standard
//    Maksimum alınabilecek adet tüm ürünlerde sabit 20
    let adetListe:Int = 20
//    Seçilen yemek objesi
    var yemek:Yemekler?
    var secilenAdet:Int = 1
//  presenter nesnesi
    var presenter:DetayViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adetPicker.dataSource = self
        adetPicker.delegate = self
        DetayRouter.createModule(ref: self)
        
//        Tıklanan yemek objesinin özelliklerinin detay view da gösterilmesi
        if let y = yemek {
            yemekAd.text = y.yemek_adi
            yemekFiyat.text = "\(y.yemek_fiyat!) ₺"
//            KingFisher kullan
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(y.yemek_resim_adi!)"){
                DispatchQueue.main.async {
                    self.yemekImageView.kf.setImage(with:url)
                }
            }
        }
        
        
        
    }
    
//    Sepete ekleme fonksiyonu
    @IBAction func sepeteEkleButton(_ sender: Any) {
        if let y = yemek{
//      MARK: post gönder
            let params:Parameters = ["yemek_adi":y.yemek_adi!,"yemek_resim_adi":y.yemek_resim_adi!,"yemek_fiyat":Int(y.yemek_fiyat!)!,"kullanici_adi": ud.string(forKey: "username")!,"yemek_siparis_adet":self.secilenAdet]

            presenter?.sepeteEkleButton(params: params)
            /*
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
            } */
        }
    }
    


}

//Picker fonksiyonları
extension DetayScreenVC:UIPickerViewDelegate,UIPickerViewDataSource{
//    Components sayısı 1, çünkü seçmek istediğimiz sadece adet
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
//    Satır sayısı maksimum alınabilecek ürün sayısı kadar olmalı
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return adetListe
    }
//    Her bir satıra o satırın index'inin 1 fazlasını vermek 1'den 20 ye kadar seçebilmemize yarıyacak
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row+1)
    }
//    Adet seçilince fiyat güncellenecek
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if let y = yemek{
            yemekFiyat.text = "\(Int(y.yemek_fiyat!)!*(row+1)) ₺"
        }
        self.secilenAdet = Int(row+1)
        
        
    }
    
    
}
