//
//  MainViewModel.swift
//  NetflixClone
//
//  Created by 김동현 on 8/7/24.
//

import Foundation
import RxSwift

class MainViewModel {
  
  private let apiKey = Bundle.main.infoDictionary?["TMDB_API_KEY"] as? String
  private let disposeBag = DisposeBag()
  
  /// View가 구독할 Subject.
  let popularMovieSubject = BehaviorSubject(value: [Movie]())
  let topRatedMovieSubject = BehaviorSubject(value: [Movie]())
  let upcomingMovieSubject = BehaviorSubject(value: [Movie]())
  
  init() {
    fetchPopularMovie()
    fetchTopRatedMovie()
    fetchUpcomingMovie()
  }
  
  
  /// Popular Movie 데이터를 불러온다.
  /// ViewModel 에서 수행해야할 비즈니스 로직.
  func fetchPopularMovie() {
    
    guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(String(describing: apiKey))") else {
      popularMovieSubject.onError(NetworkError.invalidUrl)
      return
    }
    
    NetworkManager.shared.fetch(url: url)
      .subscribe(onSuccess: { [weak self] (MovieResponse: MovieResponse) in
        self?.popularMovieSubject.onNext(MovieResponse.results)
      }, onFailure: { [weak self] error in
        self?.popularMovieSubject.onError(error)
      }).disposed(by: disposeBag)
  }
  
  func fetchTopRatedMovie() {
    guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(String(describing: apiKey))") else {
      topRatedMovieSubject.onError(NetworkError.invalidUrl)
      return
    }
    
    NetworkManager.shared.fetch(url: url)
      .subscribe(onSuccess: { [weak self] (MovieResponse: MovieResponse) in
        self?.topRatedMovieSubject.onNext(MovieResponse.results)
      }, onFailure: { [weak self] error in
        self?.topRatedMovieSubject.onError(error)
      }).disposed(by: disposeBag)
  }
  
  func fetchUpcomingMovie() {
    guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(String(describing: apiKey))") else {
      upcomingMovieSubject.onError(NetworkError.invalidUrl)
      return
    }
    
    NetworkManager.shared.fetch(url: url)
      .subscribe(onSuccess: { [weak self] (MovieResponse: MovieResponse) in
        self?.upcomingMovieSubject.onNext(MovieResponse.results)
      }, onFailure: { [weak self] error in
        self?.upcomingMovieSubject.onError(error)
      }).disposed(by: disposeBag)
  }
}
