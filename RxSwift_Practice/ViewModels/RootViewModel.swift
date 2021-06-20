//
//  RootViewModel.swift
//  RxSwift_Practice
//
//  Created by wooyeong kam on 2021/06/12.
//

import Foundation
import RxSwift

final class RootViewModel {
    let title = "kam news"
    
    private let ArticleServie : ArticleServiceProtocol
    
    init(articleServiceProtocol : ArticleServiceProtocol) {
        self.ArticleServie = articleServiceProtocol
    }
    
    func ArticleService() -> Observable<[ArticleViewModel]> {
        return ArticleServie.fetchNews().map{ $0.map{ ArticleViewModel(article: $0) }}
    }
}
