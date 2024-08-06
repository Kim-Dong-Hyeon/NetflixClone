//
//  Video.swift
//  NetflixClone
//
//  Created by 김동현 on 8/7/24.
//

import Foundation

struct VideoResponse: Codable {
  let results: [Video]
}

struct Video: Codable {
  let key: String?
  let site: String?
  let type: String?
}
