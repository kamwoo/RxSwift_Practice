//
//  ArticleService.swift
//  RxSwift_Practice
//
//  Created by wooyeong kam on 2021/06/12.
//

import Foundation
import Alamofire
import RxSwift

protocol ArticleServiceProtocol {
    func fetchNews() -> Observable<[Article]>
}

class ArticleService : ArticleServiceProtocol {
    
    func fetchNews() -> Observable<[Article]>{
        return Observable<[Article]>.create { observer -> Disposable in
            self.fetchNews { (error, articles) in
                
                if let error = error {
                    observer.onError(error)
                }
                
                if let articles = articles {
                    observer.onNext(articles)
                }
                
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    private func fetchNews(completion: @escaping((Error?, [Article]?) -> Void)) {
        let urlString = "https://newsapi.org/v2/everything?q=tesla&from=2021-05-12&sortBy=publishedAt&apiKey=e34febe364614031a28ce5d669caa1da"
        
        guard let url = URL(string: urlString) else { return completion(NSError(domain: "kam1741", code: 404, userInfo: nil), nil)}
        
        AF.request(url,
                   method: HTTPMethod.get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: nil,
                   interceptor: nil,
                   requestModifier: nil).responseDecodable(of: ArticleResponse.self){ response in
                    
                    if let error = response.error {
                        return completion(error, nil)
                    }
                    
                    if let articles = response.value?.articles {
                        return completion(nil, articles)
                    }
                   }
    }
}
