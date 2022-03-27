//
//  ProductTableViewCell.swift
//  iOSTest
//
//  Created by DonorRaja on 28/03/22.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    @IBOutlet weak var productBrand: UILabel!
    @IBOutlet weak var productCode: UILabel!
    @IBOutlet weak var productName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.borderWidth = 2
        bgView.layer.borderColor = UIColor.systemTeal.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
