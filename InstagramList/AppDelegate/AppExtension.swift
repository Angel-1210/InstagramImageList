//
//  AppExtension.swift
//  InstagramList
//
//  Created by Dharmesh Avaiya on 24/11/18.
//  Copyright © 2018 Dharmesh Avaiya. All rights reserved.
//

import UIKit
import Foundation

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func cacheImage(urlString: String, onSuccess:@escaping (_ image: UIImage?)->Void, onError:@escaping(_ error: Error)->Void) {
        
        let url = URL(string: urlString)
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            onSuccess(imageFromCache)
            return
        }
        
        URLSession.shared.dataTask(with: url!) {
            data, response, error in
            
            if error == nil {
                
                if let response = data {
                    DispatchQueue.main.async {
                        let imageToCache = UIImage(data: response)
                        imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                        onSuccess(imageToCache)
                    }
                } else {
                    let error: Error = RequestError.invalidData
                    print(error.localizedDescription)
                    onError(error)
                }
            } else {
                print(error!.localizedDescription)
                onError(error!)
            }
            
            }.resume()
    }    
}
