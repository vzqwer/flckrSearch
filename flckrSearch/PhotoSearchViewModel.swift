//
//  PhotoSearchViewModel.swift
//  flckrSearch
//
//  Created by Oleg Shulakov on 13.02.2019.
//  Copyright © 2019 Oleg Shulakov. All rights reserved.
//

import RxSwift
import RxCocoa
import Moya

class PhotoSearchViewModel {
    // MARK: - Properties
    let title = "flckrSearch"
    
    // MARK: - Input
    let searchTextRelay = BehaviorRelay<String>(value: "")
    
    // MARK: - Output
    let searchResult: Observable<PhotosList>
    let photos: Observable<[Photo]>
//    let searchFailed: Observable<Error>
    
    init(flickrProvider: MoyaProvider<FlickrService> = MoyaProvider<FlickrService>()) {

        let searchRequest = searchTextRelay
                .distinctUntilChanged()
                .filter { $0 == nil || $0.isEmpty }
                .debounce(RxTimeInterval.init(0.3), scheduler: MainScheduler.init())
                .flatMap { (searchText) -> Single<Response> in
                    return flickrProvider.rx.request(.photosSearch(searchText: searchText, page: 1, perPage: 20))
                }
        
        searchResult = searchRequest.map({ (response) -> PhotosList in
            let photoList = try! JSONDecoder().decode(PhotosList.self, from: response.data)
            return photoList
        })
        
        photos = searchResult.map({ (photosList) -> [Photo] in
            return photosList.photos
        })
        
    }

    private func requestPhotos() {

    }
}
