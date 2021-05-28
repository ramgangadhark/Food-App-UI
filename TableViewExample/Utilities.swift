//
//  Utilities.swift
//  TableViewExample
//
//  Created by Ram on 23/02/21.
//
import UIKit
import Foundation
//class Utils {
//
//    static func displayAlert(title: String, message: String) {
//
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let defaultAction = UIAlertAction(title: "Default", style: .default, handler: nil)
//        alertController.addAction(defaultAction)
//
//        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
//            fatalError("keyWindow has no rootViewController")
//            return
//        }
//
//        viewController.present(alertController, animated: true, completion: nil)
//    }
//
//}
extension UIImageView {
   func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
   }
   func downloadImage(from url: URL) {
      getData(from: url) {
         data, response, error in
         guard let data = data, error == nil else {
            return
         }
         DispatchQueue.main.async() {
            self.image = UIImage(data: data)
         }
      }
   }
}
extension UIViewController {

  func presentAlert(withTitle title: String, message : String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default) { action in
        print("You've pressed OK Button")
    }
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
}

//extension Dictionary {
//    public init(keys: [Key], values: [Value]) {
//        precondition(keys.count == values.count)
//
//        self.init()
//
//        for (index, key) in keys.enumerate() {
//            self[key] = values[index]
//        }
//    }
//}


