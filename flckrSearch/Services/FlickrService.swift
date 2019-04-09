//
//  FlickrService.swift
//  flckrSearch
//
//  Created by Oleg Shulakov on 13.02.2019.
//  Copyright © 2019 Oleg Shulakov. All rights reserved.
//

import Foundation
import Moya

private let apiKey = "dcd0eb1cba36610453a6a6da6d46257b"
private let apiSecret = "6946b63702b27a14"

enum FlickrService {
    case photosSearch(searchText: String, page: Int, perPage: Int)
    case fetchPhoto(id: String, secret: String, server: String, farm: Int)
}

// MARK: - TargetType Protocol Implementation
extension FlickrService: TargetType {
    var baseURL: URL {
        switch self {
        case .photosSearch:
            return URL(string: "https://api.flickr.com")!
        case .fetchPhoto(_, _, _, let farm):
            return URL(string: "https://farm\(farm).staticflickr.com")!
        }
    }
    
    var path: String {
        switch self {
        case .photosSearch:
            return "services/rest"
        case .fetchPhoto(let id, let secret, let server, _):
            return "\(server)/\(id)_\(secret).jpg"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .photosSearch, .fetchPhoto:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        default:
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
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}
