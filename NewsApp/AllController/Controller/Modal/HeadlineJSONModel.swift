//
//  HeadlineJSONModel.swift
//  NewsApp
//
//  Created by rahulverma on 14/8/23.
//

import Foundation

// MARK: - HeadlineJSONModel
struct HeadlineJSONModel: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}

