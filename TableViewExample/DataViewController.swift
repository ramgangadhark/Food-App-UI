//
//  DataViewController.swift
//  TableViewExample
//
//  Created by Ram on 26/02/21.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var dataLbl: UILabel!
    var data:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataLbl.text = data
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
