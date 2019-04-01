//
//  Photo.swift
//  flckrSearch
//
//  Created by Oleg Shulakov on 13.02.2019.
//  Copyright © 2019 Oleg Shulakov. All rights reserved.
//

struct Photo: Decodable {
    let id: String
//    "owner": "136344873@N06",
    let secret: String
    let server: String
    let farm: Int
    let title: String
//    "ispublic": 1,
//    "isfriend": 0,
//    "isfamily": 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case secret
        case server
        case farm
        case title
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        secret = try container.decode(String.self, forKey: .secret)
        server = try container.decode(String.self, forKey: .server)
        farm = try container.decode(Int.self, forKey: .farm)
        title = try container.decode(String.self, forKey: .title)
    }
}
