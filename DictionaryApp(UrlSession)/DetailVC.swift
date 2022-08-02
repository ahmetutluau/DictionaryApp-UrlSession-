//
//  DetailVC.swift
//  DictionaryApp(UrlSession)
//
//  Created by MAC on 1.08.2022.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var labelTurkish: UILabel!
    @IBOutlet weak var labelEnglish: UILabel!
    
    var kelime : Kelimeler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let k = kelime {
            labelTurkish.text = k.turkce
            labelEnglish.text = k.ingilizce
        }
        
    }
    
}
