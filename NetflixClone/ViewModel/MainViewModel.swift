//
//  MainViewModel.swift
//  NetflixClone
//
//  Created by 김동현 on 8/7/24.
//

import Foundation
import RxSwift

class MainViewModel {
  // API Key.
  private let apiKey = Bundle.main.infoDictionary?["TMDB_API_KEY"] as? String
  // 구독 해제를 위한 DisposeBag.
  private let disposeBag = DisposeBag()
  
  /// View 가 구독할 Subject.
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
    // 잘못된 URL 인 경우 Subject 에서 에러가 방출되도록 함.
    guard let apiKey = apiKey, let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)") else {
      popularMovieSubject.onError(NetworkError.invalidUrl)
      return
    }
    
    // 이 네트워크 fetch 의 결과는 Single 타입이기 때문에, 구독할 수 있다.
    // NetworkManager 의 fetch 메서드의 Single 로 부터 흘러나온 데이터를,
    // 그대로 ViewModel 의 subject 로 그대로 물 흐르듯 흘려보내고 있다.
    // 그리고 View 에서는 이 subject 를 구독하고 있다가 데이터가 발행 된 순간 그에 맞는 행동을 할 것이다.
    // 이러한 특성 때문에 Observable 은 "데이터를 스트림으로 관리한다" 고 표현할 수 있다.
    NetworkManager.shared.fetch(url: url)
      .subscribe(onSuccess: { [weak self] (movieResponse: MovieResponse) in
        self?.popularMovieSubject.onNext(movieResponse.results)
      }, onFailure: { [weak self] error in
        self?.popularMovieSubject.onError(error)
      }).disposed(by: disposeBag)
  }
  
  func fetchTopRatedMovie() {
    guard let apiKey = apiKey, let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)") else {
      topRatedMovieSubject.onError(NetworkError.invalidUrl)
      return
    }
    
    NetworkManager.shared.fetch(url: url)
      .subscribe(onSuccess: { [weak self] (movieResponse: MovieResponse) in
        self?.topRatedMovieSubject.onNext(movieResponse.results)
      }, onFailure: { [weak self] error in
        self?.topRatedMovieSubject.onError(error)
      }).disposed(by: disposeBag)
  }
  
  func fetchUpcomingMovie() {
    guard let apiKey = apiKey, let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)") else {
      upcomingMovieSubject.onError(NetworkError.invalidUrl)
      return
    }
    
    NetworkManager.shared.fetch(url: url)
      .subscribe(onSuccess: { [weak self] (movieResponse: MovieResponse) in
        self?.upcomingMovieSubject.onNext(movieResponse.results)
      }, onFailure: { [weak self] error in
        self?.upcomingMovieSubject.onError(error)
      }).disposed(by: disposeBag)
  }
  
  // 동영상 키값
  func fetchTrailerKey(movie: Movie) -> Single<String> {
    guard let apiKey = apiKey, let movieId = movie.id else { return Single.error(NetworkError.dataFetchFail) }
    let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=\(apiKey)"
    guard let url = URL(string: urlString) else {
      return Single.error(NetworkError.invalidUrl)
    }
    
    return NetworkManager.shared.fetch(url: url)
      .flatMap { (VideoResponse: VideoResponse) -> Single<String> in
        if let trailer = VideoResponse.results.first(where: { $0.type == "Trailer" && $0.site == "YouTube" }) {
          guard let key = trailer.key else { return Single.error(NetworkError.dataFetchFail) }
          return Single.just(key)
        } else {
          return Single.error(NetworkError.dataFetchFail)
        }
      }
  }
}
