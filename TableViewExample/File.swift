//
//  File.swift
//  TableViewExample
//
//  Created by Ram on 25/02/21.
//

import Foundation
import UIKit
struct dishData {
    var chefName: String!
    var dishName: String!
    var dishImg: String!
    var favCount: Int!
//    var likes: [UIImage]
//    var saved:[UIImage]

    init(chefName: String, dishName: String, dishImg: String, favCount: Int) {
         self.chefName = chefName
         self.dishName = dishName
         self.dishImg = dishImg
         self.favCount = favCount
//        self.likes = likes
//        self.saved = saved

    }
}
