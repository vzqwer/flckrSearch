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

class PhotoSearchController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionViewPhoto: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = PhotoSearchViewModel()
    private let disposeBag = DisposeBag()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        collectionViewPhoto.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        
//        let provider = MoyaProvider<FlickrService>()
//        provider.rx.request(.photosSearch(searchText: "qwe", page: 1, perPage: 10)).subscribe { (singleEvent) in
//            switch singleEvent {
//            case .success(let response):
//                let rsp = try! response.mapString()
//                NSLog(rsp)
//
//                let photoList = try! JSONDecoder().decode(PhotosList.self, from: response.data)
//                NSLog(photoList.photos.count.description)
//                NSLog(photoList.photos.description)
//            case .error(let error):
//                NSLog(error.localizedDescription)
//            }
//        }
        
        setupBindings()
    }
    
    private func setupBindings() {
//        searchBar.rx.text.
        let titles = Observable.from(["1", "2"])
        
        titles.bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (index, model, cell) in
                cell.title = model
            }
            .disposed(by: disposeBag)
        
//        viewModel.repositories
//            .observeOn(MainScheduler.instance)
//            .do(onNext: { [weak self] _ in self?.refreshControl.endRefreshing() })
//            .bind(to: tableView.rx.items(cellIdentifier: "RepositoryCell", cellType: RepositoryCell.self)) { [weak self] (_, repo, cell) in
//                self?.setupRepositoryCell(cell, repository: repo)
//            }
//            .disposed(by: disposeBag)
        
//        collectionViewPhoto.rx.items(cellIdentifier: <#T##String#>, cellType: <#T##Cell.Type#>)
        
        viewModel.photos
//            .observeOn(MainScheduler.instance)
            .bind(to: collectionViewPhoto.rx.items(cellIdentifier: "PhotoCell", cellType: PhotoCell.self)) { (index, model, cell) in
                cell.title = model.title
            }
            .disposed(by: disposeBag)
        
//        viewModel.searchTextRelay = searchBar.rx.text
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
