//
//  NewsModel.swift
//  HackerNews
//
//  Created by Elmira on 04.04.21.
//

import Foundation

struct NewsModel: Decodable {
    let hits: [News]
}

struct News: Decodable {
    let title: String
    let points: Int
    let url: String?
    let objectID: String
}
