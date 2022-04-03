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
//    presenter nesnesi
    var presenter:SepetViewToPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        sepetTableView.delegate = self
        sepetTableView.dataSource = self

        SepetRouter.createModule(ref: self)
       presenter?.sepetiAl()

    }
    override func viewWillAppear(_ animated: Bool) {
        presenter?.sepetiAl()
    }
}

extension SepetScreenVC:SepetPresenterToViewProtocol{
    func vieweVeriGonder(sepetListe: Array<SepetYemekler>) {
        self.sepet = sepetListe
        DispatchQueue.main.async {
            self.sepetTableView.reloadData()
        }
    }

    func vieweUcretGonder(totalUcret: Int?) {
        self.totalUcret = totalUcret!
        self.toplamUcretLabel.text = "\(self.totalUcret) ₺"
    }
}

extension SepetScreenVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sepet.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let yemek = sepet[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sepetHucre", for: indexPath) as! SepetTableViewCell
        
//      TODO:  Kingfisher Burada Kullanılacak
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
                let params:Parameters = ["sepet_yemek_id":yemek.sepet_yemek_id!,"kullanici_adi":self.ud.string(forKey: "username")!]
//                MARK: Yemeksil komutu buraya
                self.presenter?.yemekSil(params: params)
//              Table da ki öğeleri yenileme
//               MARK: silme işlemi
                if(self.sepet.count != 1){
                    self.sepet.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
//                    self.sepetiAl()
                    self.presenter?.sepetiAl()
                    print("sepet yenilendi")
                }else{
                    self.toplamUcretLabel.text = String(0)
                    self.sepet.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    print("son eleman silindi")
                }
            }
            alert.addAction(evetAction)
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
    
}
