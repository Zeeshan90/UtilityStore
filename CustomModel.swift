//
//  CustomModel.swift
//  Dogstagram
//
//  Created by Muhammad Zeeshan on 22/12/2019.
//  Copyright © 2019 Real Life Swift. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Kingfisher
class CustomModel{
    
    var name:String!
    var image:UIImage!
    var stringImage:String!
    
    init(json:JSON) {
        self.name = json["name"].stringValue
        self.stringImage = addPercent20(ImgUrl: json["logo"].stringValue)
        let url = URL(string: addPercent20(ImgUrl: json["logo"].stringValue))
        print(url!)
        if let data = try? Data(contentsOf: url!)
        {
            let image: UIImage = UIImage(data: data)!
            self.image =  image
            
        }
        
    }
    
    // MARK: %20 to url
    func addPercent20(ImgUrl:String) -> String{
        return ImgUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
    }
}

extension ViewController: CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        
        return items[indexPath.item].image.size
        
//        let url = URL(string: items[indexPath.row].stringImage)
//        if let data = try? Data(contentsOf: url!)
//        {
//            let image: UIImage = UIImage(data: data)!
//            print(image.size)
//            return image.size
//
//        }
//        return CGSize(width: 0, height: 0)
        
        
        //    return UIImage(named: items[indexPath.item])!.size
    }
}
