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
    
    private func clearCell() {
        self.imageView.image = UIImage.photoPlaceHolder()
        self.title.text = ""
    }
    
    func bindViewModel(viewModel: PhotoCellViewModel) {
        clearCell()
        
        self.viewModel = viewModel
        self.viewModel.title.asObservable()
            .bind(to: self.title.rx.text)
            .disposed(by: self.disposeBag)
        self.viewModel.image.asObservable()
            .bind(to: self.imageView.rx.image)
            .disposed(by: self.disposeBag)
    }
}
