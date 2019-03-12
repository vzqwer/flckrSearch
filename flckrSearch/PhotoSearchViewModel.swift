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
    let searchResult: Driver<PhotosList>
    let photos: Driver<[Photo]>
    let searchFailed: Driver<Error>

    let apiProvider: ApiProvider
    
    init(apiProvider: ApiProviderImpl = ApiProviderImpl(flickrProvider: MoyaProvider<FlickrService>())) {
        self.apiProvider = apiProvider

        let searchRequest = searchTextRelay
                .debug("searchRequest")
                .debounce(RxTimeInterval.init(0.3), scheduler: MainScheduler.init())
                .distinctUntilChanged()
                .filter { !$0.isEmpty }
                .flatMap { searchText -> Observable<PhotosList> in
                    return apiProvider.requestPhotos(text: searchText, page: 1, perPage: 20).debug("requestPhotos").asObservable()
                }

        searchResult = searchRequest
                .debug("searchResult")
                .asDriver(onErrorJustReturn: PhotosList.emptyPhotoList())
        photos = searchResult
                .debug("photos")
                .map { $0.photos }
        searchFailed = searchRequest
                .debug("searchFailed")
                .materialize()
                .map({ $0.error})
                .filterNil()
                .asDriver(onErrorJustReturn: UnknownError())
        
    }

//    private func requestPhotos(text: String, page: Int, perPage: Int) -> Result<Photos, Error> {
//        apiProvider.request(.photosSearch(searchText: text, page: page, perPage: perPage)) { (result) in
//            return result
//        }
//    }
}
