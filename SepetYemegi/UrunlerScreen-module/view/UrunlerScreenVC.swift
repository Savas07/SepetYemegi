//
//  UrunlerVC.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 27.03.2022.
//

import UIKit
import Alamofire
import Kingfisher

class UrunlerScreenVC: UIViewController {

    @IBOutlet weak var yemeklerCollectionView: UICollectionView!
    @IBOutlet weak var kullaniciLabel: UILabel!
    var kullaniciAdi:String?
    var yemeklerListe = [Yemekler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yemeklerCollectionView.delegate = self
        yemeklerCollectionView.dataSource = self
        
        tumYemekleriAl()
        
        
        
        
        let tasarim = UICollectionViewFlowLayout()
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.minimumLineSpacing = 5
        tasarim.minimumInteritemSpacing = 5
        let genislik = self.yemeklerCollectionView.frame.size.width
        let hucreGenislik =  (genislik-30)/3
        tasarim.itemSize = CGSize(width: hucreGenislik, height: hucreGenislik*1.7)
        yemeklerCollectionView?.collectionViewLayout = tasarim
        
    }
    
    func tumYemekleriAl(){
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response{response in
            
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    
                    if let gelenListe = cevap.yemekler{
                        
                        self.yemeklerListe = gelenListe
                        
                        DispatchQueue.main.async {
                            self.yemeklerCollectionView.reloadData()
                        }
                        
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }

}


extension UrunlerScreenVC : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yemeklerListe.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let yemek = yemeklerListe[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "yemekHucre", for: indexPath) as! YemeklerCollectionViewCell
        
//        Kingfisher Burada Kullanılacak
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)"){
            DispatchQueue.main.async {
                cell.yemekImageView.kf.setImage(with:url)
            }
        }
        
        
//        cell.yemekImageView.image = UIImage(named: yemek.yemek_resim_adi!)
        cell.yemekAdiLabel.text = yemek.yemek_adi
        cell.yemekFiyatLabel.text = "\(yemek.yemek_fiyat!) ₺"
        
        return cell
    }
    
    
}
