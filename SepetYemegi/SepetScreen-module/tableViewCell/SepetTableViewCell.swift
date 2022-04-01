//
//  SepetTableViewCell.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 30.03.2022.
//

import UIKit

class SepetTableViewCell: UITableViewCell {

    @IBOutlet weak var sepetImageView: UIImageView!
    @IBOutlet weak var sepetYemekAd: UILabel!
    @IBOutlet weak var sepetYemekFiyat: UILabel!
    @IBOutlet weak var sepetYemekAdet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
