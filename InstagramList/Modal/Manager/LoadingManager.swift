//
//  LoadingManager.swift
//  InstagramList
//
//  Created by Dharmesh Avaiya on 24/11/18.
//  Copyright © 2018 Dharmesh Avaiya. All rights reserved.
//

import UIKit

let kDefaultMessage = "Please wait..."

class LoadingManager: NSObject {

    static let shared: LoadingManager = LoadingManager()
    
    //------------------------------------------------------
    
    //MARK: Loading
    
    func show(controller: UIViewController, message: String? = nil) {
        
        let alert = UIAlertController(title: nil, message: message ?? kDefaultMessage, preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        controller.present(alert, animated: true, completion: nil)
    }
    
    func dismiss(controller: UIViewController) {
        controller.dismiss(animated: false, completion: nil)
    }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    override init() {
        super.init()
    }
    
    //------------------------------------------------------
}


