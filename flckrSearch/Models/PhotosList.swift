//
//  PhotosList.swift
//  flckrSearch
//
//  Created by Oleg Shulakov on 13.02.2019.
//  Copyright © 2019 Oleg Shulakov. All rights reserved.
//

struct PhotosList: Decodable {
    let photos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case photos = "photos"
    }
    
    enum RatingsCodingKeys: String, CodingKey {
        case photo = "photo"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let photosContainer = try container.nestedContainer(keyedBy: RatingsCodingKeys.self, forKey: .photos)
        self.photos = try photosContainer.decode([Photo].self, forKey: .photo)
    }
}
