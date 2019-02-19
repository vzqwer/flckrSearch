//
//  FlickrService.swift
//  flckrSearch
//
//  Created by Oleg Shulakov on 13.02.2019.
//  Copyright © 2019 Oleg Shulakov. All rights reserved.
//

import Moya

private let apiKey = "dcd0eb1cba36610453a6a6da6d46257b"
private let apiSecret = "6946b63702b27a14"

enum FlickrService {
    case photosSearch(searchText: String, page: Int, perPage: Int)
}

// MARK: - TargetType Protocol Implementation
extension FlickrService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.flickr.com/services/rest")!
    }
    
    var path: String {
//        switch self {
//        case .photosSearch(let searchText, let page):
//            return "=&=\(apiKey)&text=\(searchText)&format=json&nojsoncallback=1&auth_token=72157705210128411-4604d5029d272221&api_sig=c276b68646f3047ee4855b509e1b57a1"
//        }
        return ""
    }
    
    var method: Method {
        switch self {
        case .photosSearch:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .photosSearch:
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .photosSearch(let searchText, let page, let perPage):
            return .requestParameters(parameters: ["method" : "flickr.photos.search",
                                                   "api_key" : apiKey,
                                                   "text" : searchText,
                                                   "page" : page,
                                                   "per_page" : perPage,
                                                   "format" : "json",
                                                   "nojsoncallback" : 1,
                                                   ], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}
