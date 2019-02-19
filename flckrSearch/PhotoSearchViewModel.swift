//
//  PhotoSearchViewModel.swift
//  flckrSearch
//
//  Created by Oleg Shulakov on 13.02.2019.
//  Copyright © 2019 Oleg Shulakov. All rights reserved.
//

import RxSwift
import RxCocoa

class PhotoSearchViewModel {
    // MARK: - Properties
    let title = "flckrSearch"
    
    // MARK: - Input
    let serchText = BehaviorRelay<String>(value: "")
    
    // MARK: - Output
}
