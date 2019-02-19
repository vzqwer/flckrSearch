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
//    "secret": "928442e461",
//    "server": "7847",
//    "farm": 8,
    let title: String
//    "ispublic": 1,
//    "isfriend": 0,
//    "isfamily": 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
    }
}
