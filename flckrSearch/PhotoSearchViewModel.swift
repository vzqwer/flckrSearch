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
    let apiProvider: ApiProvider
    
    // MARK: - Input
    let searchTextRelay = BehaviorRelay<String>(value: "")
    
    // MARK: - Output
    // TODO: Extract view state into separate struct
    let photos: Driver<[Photo]>
    let searchFailed: Driver<Error>
    let noData: Driver<Bool>
    let inProgress: BehaviorRelay<Bool>
    
    // MARK: - Methods
    init(apiProvider: ApiProviderImpl = ApiProviderImpl(flickrProvider: MoyaProvider<FlickrService>())) {
        self.apiProvider = apiProvider

        let inPrgrs = BehaviorRelay.init(value: false)
        
        let searchRequest = searchTextRelay
                .debounce(RxTimeInterval.init(0.3), scheduler: MainScheduler.init())
                .distinctUntilChanged()
                .filter { !$0.isEmpty }
                .flatMap { searchText -> Observable<PhotosList> in
                    return apiProvider.requestPhotos(text: searchText, page: 1, perPage: 20)
                        .do(onSuccess: { _ in inPrgrs.accept(false) },
                              onError: { _ in inPrgrs.accept(false) },
                          onSubscribe: { inPrgrs.accept(true) })
                        .asObservable()
                }

        let searchResult = searchRequest
                .asDriver(onErrorJustReturn: PhotosList.emptyPhotoList())
        
        photos = searchResult.map { $0.photos }
        searchFailed = searchRequest
                .materialize()
                .map({ $0.error})
                .filterNil()
                .asDriver(onErrorJustReturn: UnknownError())
        noData = Driver.of(
            photos.map({ $0.isEmpty }),
            searchTextRelay.asDriver().map({ $0.isEmpty}))
            .merge()
        
        self.inProgress = inPrgrs
    }
}
