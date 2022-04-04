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
    var kullaniciAdi:String?
    var yemeklerListe = [Yemekler]()
    let ud = UserDefaults.standard
    var presenter:UrunlerViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yemeklerCollectionView.delegate = self
        yemeklerCollectionView.dataSource = self

        UrunlerRouter.createModule(ref: self)
//      FIXME: yemekleri al
//        presenter?.yemekleriAl()
//        tumYemekleriAl()
        
        
        
        
        let tasarim = UICollectionViewFlowLayout()
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.minimumLineSpacing = 5
        tasarim.minimumInteritemSpacing = 5
        let genislik = self.yemeklerCollectionView.frame.size.width
        let hucreGenislik =  (genislik-30)/3
        tasarim.itemSize = CGSize(width: hucreGenislik, height: hucreGenislik*1.7)
        yemeklerCollectionView?.collectionViewLayout = tasarim
        
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter?.yemekleriAl()
    }
    /*
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
    } */
    
    @IBAction func logoutButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
        ud.set(false, forKey: "signedIn")
    }
    @IBAction func sepeteGitButton(_ sender: Any) {
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
        cell.yemekResimAd = yemek.yemek_resim_adi
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.3
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let yemek = yemeklerListe[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: yemek)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay"{
            let yemek = sender as? Yemekler
            let gidilecekVC = segue.destination as! DetayScreenVC
            gidilecekVC.yemek = yemek
        }
    }
    
    
}

extension UrunlerScreenVC:UrunlerPresenterToViewProtocol{
    func vieweVeriGonder(yemeklerListe: Array<Yemekler>) {
        self.yemeklerListe = yemeklerListe
        DispatchQueue.main.async {
            self.yemeklerCollectionView.reloadData()
        }
    }
}
