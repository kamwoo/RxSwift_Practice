//
//  ArticleViewModel.swift
//  RxSwift_Practice
//
//  Created by wooyeong kam on 2021/06/13.
//

import Foundation

struct ArticleViewModel {
    init(article : Article) {
        self.article = article
    }
    
    private var article : Article
    
    var imageUrl : String? {
        return article.urlToImage
    }
    
    var title : String? {
        return article.title
    }
    
    var author : String?{
        return article.author
    }
    
    var descrition : String? {
        return article.description
    }
    
}
