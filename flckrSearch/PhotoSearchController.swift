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

        collectionViewPhoto.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        
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
        viewModel.searchTextRelay.bind(to: searchBar.rx.text).disposed(by: disposeBag)
        
        viewModel.photos
            .observeOn(MainScheduler.instance)
            .bind(to: self.collectionViewPhoto.rx.items) { (collectionView, row, element) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
                cell.title.text = element.title
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
