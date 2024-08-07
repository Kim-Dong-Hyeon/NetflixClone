//
//  MainViewModel.swift
//  NetflixClone
//
//  Created by 김동현 on 8/7/24.
//

import Foundation

class MainViewModel {
  private let apiKey = Bundle.main.infoDictionary?["TMDB_API_KEY"] as? String
  
  init() {
    
  }
  
  
  /// Popular Movie 데이터를 불러온다.
  /// ViewModel 에서 수행해야할 비즈니스 로직.
  func fetchPopularMovie() {
    
  }
  
  func fetchTopRatedMovie() {
    
  }
  
  func fetchUpcomingMovie() {
    
  }
}
