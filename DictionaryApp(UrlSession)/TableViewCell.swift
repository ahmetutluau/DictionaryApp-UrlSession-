//
//  TableViewCell.swift
//  DictionaryApp(UrlSession)
//
//  Created by MAC on 1.08.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var labelTurkish: UILabel!
    @IBOutlet weak var labelEnglish: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
