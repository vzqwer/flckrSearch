//
// Created by Oleg Shulakov on 2019-03-07.
// Copyright (c) 2019 Oleg Shulakov. All rights reserved.
//

import Foundation
import RxSwift

protocol ApiProvider {
    func requestPhotos(text: String, page: Int, perPage: Int) -> Single<PhotosList>
}
