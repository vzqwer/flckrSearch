//
//  PhotoCell.swift
//  flckrSearch
//
//  Created by Oleg Shulakov on 27.02.2019.
//  Copyright © 2019 Oleg Shulakov. All rights reserved.
//

import UIKit
import RxSwift

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var viewModel = PhotoCellViewModel(nil)
    private let disposeBag = DisposeBag()
    
    func bindViewModel(viewModel: PhotoCellViewModel) {
        self.viewModel = viewModel
        self.viewModel.image.asObservable().bind(to: self.imageView.rx.image).disposed(by: self.disposeBag)
    }
}
