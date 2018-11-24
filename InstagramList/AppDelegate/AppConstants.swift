//
//  AppConstants.swift
//  InstagramList
//
//  Created by Dharmesh Avaiya on 24/11/18.
//  Copyright © 2018 Dharmesh Avaiya. All rights reserved.
//

import UIKit

public enum RequestError: Error {
    
    case invalidURL
    case noDataFound
    case invalidJsonResponse
    case invalidData
}

extension RequestError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid request url", comment: String(describing: RequestError.self))
        case .noDataFound:
            return NSLocalizedString("No data found for given request url", comment: String(describing: RequestError.self))
        case .invalidJsonResponse:
            return NSLocalizedString("Invalid json response for given request url", comment: String(describing: RequestError.self))
        case .invalidData:
            return NSLocalizedString("Invalid data for given request url", comment: String(describing: RequestError.self))
        }
    }
}
