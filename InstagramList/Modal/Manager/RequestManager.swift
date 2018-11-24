//
//  RequestManager.swift
//  InstagramList
//
//  Created by Dharmesh Avaiya on 24/11/18.
//  Copyright © 2018 Dharmesh Avaiya. All rights reserved.
//

import UIKit

class RequestManager: NSObject {

    static let shared: RequestManager = RequestManager()
    
    let kBaseURL = "https://picsum.photos/"
    
    //------------------------------------------------------
    
    //MARK: GET
    
    func requestToGet(methodName: String, onSuccess: @escaping(_ response:  [String: Any])->Void, onError:@escaping(_ error: Error)->Void) {
        
        let requestStringURL = kBaseURL.appending(methodName)
        
        guard let requestURL = URL(string: requestStringURL) else {
            let error: Error = RequestError.invalidURL
            print(error.localizedDescription)
            onError(error)
            return
        }
        
        let urlRequest = URLRequest(url: requestURL)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let dataTask = session.dataTask(with: urlRequest) {
            (data, response, error) in
            
            guard data != nil else {
                let error: Error = RequestError.noDataFound
                print(error.localizedDescription)
                onError(error)
                return
            }
            
            if let response = response {
                print(response)
            }
            
            // check for any errors
            guard error == nil else {
                print(error!.localizedDescription)
                onError(error!)
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                
                if let jsonDictionaryData = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    
                    print(jsonDictionaryData)
                    onSuccess(jsonDictionaryData)
                    
                } else if let jsonArrayData = try JSONSerialization.jsonObject(with: data!, options: []) as? [Any] {
                    
                    let jsonDictionary = ["data": jsonArrayData]
                    print(jsonDictionary)
                    onSuccess(jsonDictionary)
                    
                } else {
                    
                    let error: Error = RequestError.invalidJsonResponse
                    print(error.localizedDescription)
                    onError(error)
                }
                
            } catch let error {
                print(error.localizedDescription)
                onError(error)                
            }
        }
        dataTask.resume()
    }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    override init() {
        super.init()
    }
    
    //------------------------------------------------------
}
