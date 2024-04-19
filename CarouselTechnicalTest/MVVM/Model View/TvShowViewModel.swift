//
//  TvShowViewModel.swift
//  CarouselTechnicalTest
//
//  Created by Xcaret Mora on 19/04/24.
//

import Foundation

class TvShowViewModel {
    
    var resultTv = [Tv]()
    var resultTvUrl = [TvUrl]()
    
    func getShowTv(completion: @escaping() -> Void) {
        
        APIService().fetchTv { [weak self] result , error in
            guard let result, error == nil else { return }
            
            self?.resultTv = result.items ?? []
            completion()
        }
        
    }
    
    func getUrlWebView(urlString: String, completion: @escaping() -> Void) {
        
        APIService().fetchUrlWebView(urlString: urlString) {[weak self] result , error in
            guard let result, error == nil else { return }
            
            self?.resultTvUrl = result.data ?? []
            completion()
        }
        
    }
    
}
