//
//  DetailsViewController.swift
//  iOSTest
//
//  Created by DonorRaja on 28/03/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var deleveryDate: UILabel!
    @IBOutlet weak var labelGST: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    
    //MARK: - Variables
    var orderDetails:Order!
    var orderTotal = 0.0
    var orderGST = 0.0
    
    // MARK: - Viewcontroller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialBinding()
    }
    
    
    // MARK: - Functions
    func initialBinding() {
        
        self.title = orderDetails.description
        self.productTableView.delegate = self
        self.productTableView.dataSource = self
        // Do any additional setup after loading the view.
        self.orderTotal = orderDetails.getOrderTotal()
        self.orderGST = Utility.calculateGST(excludeGST: self.orderTotal, percentage: 15)
        
        self.orderDate.text =  Bidone.orderDate + self.orderDetails.orderDate
        self.deleveryDate.text = Bidone.deleveryDate + self.orderDetails.deliveryDate
        self.orderPrice.text = Bidone.totalPrice + (Utility.makeCurrencyFormatter(currentAmount: self.orderTotal))
                                                    
        self.labelGST.text = Bidone.gst + (Utility.makeCurrencyFormatter(currentAmount: self.orderGST))
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderDetails.products.count
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Bidone.productCell, for: indexPath) as! ProductTableViewCell
        let product = self.orderDetails.products
        cell.productName.text = Bidone.productName + product[indexPath.row].description
        cell.productCode.text = Bidone.productCode + String(product[indexPath.row].productCode)
        cell.productBrand.text = Bidone.productBrand + product[indexPath.row].brand
        cell.productPrice.text = Bidone.productPrice + (Utility.makeCurrencyFormatter(currentAmount: product[indexPath.row].price))
                                        
        cell.productQuantity.text = Bidone.productQty + String(product[indexPath.row].quantity)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
    }

    
}
