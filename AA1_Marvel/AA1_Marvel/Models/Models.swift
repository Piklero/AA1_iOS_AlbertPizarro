//
//  Models.swift
//  AA1_marvel
//
//  Created by Albert Pizarro on 28/4/23.
//

import Foundation

struct HeroesRespone: Codable {
    let code: Int
    let status :String
    let data: HeroesData
}

struct HeroesData: Codable {
    let results: [Hero]
}

struct Hero: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail?
}

struct Thumbnail: Codable {
    let path: String
    let `extension`: String
    
    var ImageUrl: String {get{return "\(path).\(`extension`)"}}
    var Url: URL? {get{URL(string: ImageUrl)}}
}

struct ComicResponse: Codable {
    let code: Int
    let status :String
    let data: ComicData
}

struct ComicData: Codable {
    let results: [Comic]
}

struct Comic: Codable {
    let id: Int
    let title: String
    let thumbnail: Thumbnail?
}

struct SeriesResponse: Codable {
    let code: Int
    let status :String
    let data: SeriesData
}

struct SeriesData: Codable {
    let results: [Serie]
}

struct Serie: Codable {
    let id: Int
    let title: String
    let thumbnail: Thumbnail?
}

struct StoriesResponse: Codable {
    let code: Int
    let status :String
    let data: StoriesData
}

struct StoriesData: Codable {
    let results: [Story]
}

struct Story: Codable {
    let id: Int
    let title: String
    let thumbnail: Thumbnail?
}
