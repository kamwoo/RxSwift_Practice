//
//  RootViewController.swift
//  RxSwift_Practice
//
//  Created by wooyeong kam on 2021/06/12.
//

import UIKit
import RxSwift
import RxRelay

class RootViewController: UIViewController {
    
    let viewModel : RootViewModel
    let disposeBag = DisposeBag()
    
    fileprivate let articleViewModel = BehaviorRelay<[ArticleViewModel]>(value: [])
    
    var articleViewModelObserver : Observable<[ArticleViewModel]>{
        return articleViewModel.asObservable()
    }
    
    
    //MARK: -LifeCycle
    init(viewModel : RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollectionView()
    }
    
    
    //MARK: -Configure UI
    
    private lazy var collectionView : UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .systemBackground
        return cv
    }()
    
    func configureUI(){
        self.view.backgroundColor = .systemBackground
        self.title = viewModel.title
        
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureCollectionView(){
        self.collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func fetchArticle() {
        viewModel.ArticleService().subscribe(onNext:{ articleViewModels in
            self.articleViewModel.accept(articleViewModels)
        }).disposed(by: disposeBag)
    }
    
    func subscribe() {
        self.articleViewModelObserver.subscribe({ articles in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
    

}

extension RootViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.articleViewModel.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ArticleCell
        
        cell.imageView.image = nil
        
        let articleViewModel = self.articleViewModel.value[indexPath.row]
        cell.viewModel.onNext(articleViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
}
