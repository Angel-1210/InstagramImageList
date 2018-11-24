//
//  ViewController.swift
//  InstagramList
//
//  Created by Dharmesh Avaiya on 24/11/18.
//  Copyright © 2018 Dharmesh Avaiya. All rights reserved.
//

import UIKit
import Foundation

class InstagramCell: UITableViewCell {
   
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var lblAuthorName: UILabel!
    @IBOutlet weak var lblRequestedUrl: UILabel!
    
    var instagramModal: InstgramModal!
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup(instagramModal: InstgramModal) {
        
        self.instagramModal = instagramModal
        
        /*let width = self.instagramModal.width
        let height = self.instagramModal.height
        let imageId = self.instagramModal.id
        
        let imgRequestURL = "https://picsum.photos/\(String(describing: width!))/\(String(describing: height!))?image=\(String(describing: imageId!))"
        debugPrint(imgRequestURL)
        
        //setup image
        if self.instagramModal.isRequestOnGoing == false {
            
            activityIndicatorView.startAnimating()
            self.instagramModal.isRequestOnGoing = true
            
            imgView.cacheImage(urlString: imgRequestURL, onSuccess: { (image: UIImage?) in
                DispatchQueue.main.async {
                    self.imgView.image = image
                    self.instagramModal.isRequestOnGoing = false
                    self.activityIndicatorView.stopAnimating()
                }
            }, onError: { (error: Error) in
                DispatchQueue.main.async {
                    self.instagramModal.isRequestOnGoing = false
                }
            })
        } else {
            self.activityIndicatorView.stopAnimating()
        }*/
        
        lblAuthorName.text = self.instagramModal.author
        lblRequestedUrl.text = self.instagramModal.postUrl
    }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class InstagramListVC : BaseVC, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblList: UITableView!
    
    var instagramModals: [InstgramModal] = []
    var images: [IndexPath: UIImage] = [:]
    
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setImage(instagramModal: InstgramModal, for indexPath: IndexPath, with cell: InstagramCell) {
        
        let width = instagramModal.width
        let height = instagramModal.height
        let imageId = instagramModal.id
        
        let imgRequestURL = "https://picsum.photos/\(String(describing: width!))/\(String(describing: height!))?image=\(String(describing: imageId!))"
        debugPrint(imgRequestURL)
        
        //setup image
        cell.activityIndicatorView.startAnimating()
        
        if instagramModal.isRequestOnGoing == false {
            
            instagramModal.isRequestOnGoing = true
            cell.imgView.cacheImage(urlString: imgRequestURL, onSuccess: { (image: UIImage?) in
                DispatchQueue.main.async {
                    self.images[indexPath] = image
                    instagramModal.isRequestOnGoing = false
                    cell.activityIndicatorView.stopAnimating()
                }
            }, onError: { (error: Error) in
                DispatchQueue.main.async {
                    cell.instagramModal.isRequestOnGoing = false
                    cell.activityIndicatorView.stopAnimating()
                }
            })
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return instagramModals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let instagramModal = instagramModals[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: InstagramCell.self), for: indexPath) as? InstagramCell {
            
            cell.imgView.image = nil
            cell.setup(instagramModal: instagramModal)
            
            //check if image already loaded to cache
            if let savedImage = images[indexPath] {
                cell.imgView.image = savedImage
                cell.activityIndicatorView.stopAnimating()
            } else {
                setImage(instagramModal: instagramModal, for: indexPath, with: cell)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    //------------------------------------------------------
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    //------------------------------------------------------
    
    //MARK: UIView Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        LoadingManager.shared.show(controller: self)
        
        RequestManager.shared.requestToGet(methodName: "list", onSuccess: { (response: [String : Any]) in
            
            LoadingManager.shared.dismiss(controller: self)
            
            let instgramDataModal = InstgramDataModal(fromDictionary: response)
            self.instagramModals = instgramDataModal.data
            DispatchQueue.main.async {
                self.tblList.reloadData()
            }
            
        }, onError: { (error: Error) in
            
            LoadingManager.shared.dismiss(controller: self)
        })
    }
    
    //------------------------------------------------------
}

