//
//  CustomTableViewCell.swift
//  TableViewExample
//
//  Created by Ram on 12/02/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var dishTitleLbl: UILabel!
    
    @IBOutlet weak var favCountLbl: UILabel!
    @IBOutlet weak var chefNameLbl: UILabel!
    @IBOutlet weak var icoImgView: UIImageView!
    
    @IBOutlet weak var saveLbl: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var favBtn: UIButton!
    
    @IBOutlet weak var xibLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
