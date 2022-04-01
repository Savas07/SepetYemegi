//
//  SepetScreenVC.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 29.03.2022.
//

import UIKit
import Alamofire

class SepetScreenVC: UIViewController {

    @IBOutlet weak var sepetTableView: UITableView!
    @IBOutlet weak var toplamUcretLabel: UILabel!
    var sepet = [SepetYemekler]()
    let ud = UserDefaults.standard
    var totalUcret:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sepetTableView.delegate = self
        sepetTableView.dataSource = self
        
        sepetiAl()
        
        

    }
    
    func sepetiAl(){
        
        let params:Parameters = ["kullanici_adi": ud.string(forKey: "username")!]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response{response in
            
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(SepetYemeklerCevap.self, from: data)
                    
                    if let gelenListe = cevap.sepet_yemekler{
                        
                        self.sepet = gelenListe
                        
                        var ucret = 0
                        for i in gelenListe{
                            ucret += Int(exactly: Int(i.yemek_fiyat!)! * Int(i.yemek_siparis_adet!)!)!
                            self.totalUcret = ucret
                            self.toplamUcretLabel.text = "\(self.totalUcret) ₺"
                        }
                        
                        DispatchQueue.main.async {
                            self.sepetTableView.reloadData()
                        }
                    }
                }catch{
                    print("Post metod da hata")
                    print(String(describing: error))
                }
            }
        }
    }
}
// FIXME: Tüm yemekleri silince bug, para sürekli artıyor
extension SepetScreenVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sepet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let yemek = sepet[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sepetHucre", for: indexPath) as! SepetTableViewCell
        
//        Kingfisher Burada Kullanılacak
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)"){
            DispatchQueue.main.async {
                cell.sepetImageView.kf.setImage(with:url)
            }
        }
        let yemekToplamUcret = Int(yemek.yemek_fiyat!)! * Int(yemek.yemek_siparis_adet!)!
        cell.sepetYemekAd.text = yemek.yemek_adi
        cell.sepetYemekFiyat.text = "\(yemekToplamUcret) ₺"
        cell.sepetYemekAdet.text = "Adet: \(yemek.yemek_siparis_adet!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){ (contextualAction,view,bool) in
            
            let yemek = self.sepet[indexPath.row]
           
            let alert = UIAlertController(title: "Silme İşlemi", message: "Sipariş silinsin mi ?", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel){ action in}
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){ action in
//                MARK: silme işlemi
                
                let params:Parameters = ["sepet_yemek_id":yemek.sepet_yemek_id!,"kullanici_adi":self.ud.string(forKey: "username")!]
                
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
//              Table da ki öğeleri yenileme
                self.sepetiAl()
            }
            alert.addAction(evetAction)
            self.present(alert, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [silAction])
    }
    
}
