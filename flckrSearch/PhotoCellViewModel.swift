//
//  PhotoCellViewModel.swift
//  flckrSearch
//
//  Created by Oleg Shulakov on 24.03.2019.
//  Copyright © 2019 Oleg Shulakov. All rights reserved.
//

import RxSwift
import RxCocoa
import Moya

class PhotoCellViewModel: NSObject {
    // MARK: - Properties
    let apiProvider: ApiProvider
    let photo: Photo?
    
    // MARK: - Input
    
    // MARK: - Output
    let title: Driver<String>
    let image: Driver<UIImage?>
    
    
    init(_ photo: Photo?, apiProvider: ApiProviderImpl = ApiProviderImpl(flickrProvider: MoyaProvider<FlickrService>())) {
        self.apiProvider = apiProvider
        self.photo = photo
        
        if let photoVal = photo {
            title = Single.just(photoVal.title).asDriver(onErrorJustReturn: "")
            image = apiProvider.requestPhoto(photoVal).asDriver(onErrorJustReturn: UIImage.photoPlaceHolder())
        } else {
            title = Driver.just("")
            image = Driver.just(UIImage.photoPlaceHolder())
        }
    }
}
