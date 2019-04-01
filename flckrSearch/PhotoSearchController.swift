//
//  PhotoSearchController.swift
//  flckrSearch
//
//  Created by Oleg Shulakov on 12.02.2019.
//  Copyright © 2019 Oleg Shulakov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import RxOptional

class PhotoSearchController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionViewPhoto: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    var collectionView: UICollectionView!
    
    let viewModel = PhotoSearchViewModel()
    private let disposeBag = DisposeBag()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    private func setupBindings() {
        searchBar.rx.text.orEmpty.bind(to: viewModel.searchTextRelay).disposed(by: disposeBag)

        viewModel.photos.asObservable()
            .bind(to: self.collectionViewPhoto.rx.items) { (collectionView, row, photo) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
                let cellViewModel = PhotoCellViewModel(photo)
                cell.bindViewModel(viewModel: cellViewModel)
//                cell.title.text = photo.id
                return cell
            }
            .disposed(by: disposeBag)
        
//        collectionViewPhoto.rx.modelSelected(Photo.self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
}
