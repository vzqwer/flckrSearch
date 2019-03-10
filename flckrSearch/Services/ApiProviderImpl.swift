//
// Created by Oleg Shulakov on 2019-03-07.
// Copyright (c) 2019 Oleg Shulakov. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class ApiProviderImpl: ApiProvider {

    let moyaProvider: MoyaProvider<FlickrService>

    init(flickrProvider: MoyaProvider<FlickrService> = MoyaProvider<FlickrService>()) {
        moyaProvider = flickrProvider
    }

    func requestPhotos(text: String, page: Int, perPage: Int) -> Single<PhotosList> {
        return Single.create { [weak self] single in
            let cancellable = self?.moyaProvider.request(.photosSearch(searchText: text, page: page, perPage: perPage)) { (result) in
                switch result {
                case .success(let response):
                    do {
                        let photoList = try JSONDecoder().decode(PhotosList.self, from: response.data)
                        single(.success(photoList))
                    } catch {
                        single(.error(error))
                    }
                case .failure(let moyaError):
                    single(.error(moyaError))
                }
            }

            return Disposables.create {
                cancellable?.cancel()
            }
        }

    }
}
