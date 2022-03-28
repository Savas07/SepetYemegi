//
//  Kullanici.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 28.03.2022.
//

import Foundation

class Kullanici:Codable{
    var kullaniciAd:String?
    
    init(){
        
    }
    
    init(kullaniciAd:String){
        self.kullaniciAd = kullaniciAd
    }
}
