//
//  YemeklerCollectionViewCell.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 28.03.2022.
//

import UIKit

class YemeklerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var yemekImageView: UIImageView!
    @IBOutlet weak var yemekAdiLabel: UILabel!
    @IBOutlet weak var yemekFiyatLabel: UILabel!
    
    @IBAction func sepeteEkleButton(_ sender: Any) {
    }
}
