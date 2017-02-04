//
//  Book.swift
//  HackerBooksEV
//
//  Created by usuario on 2/3/17.
//  Copyright © 2017 evizcloud. All rights reserved.
//

import Foundation

class Book {
    
    //MARK: - Aliases
    typealias tagType = [Tag]

    
    //MARK: - StoredProperties
    let title       : String
    let authors     : [String]
    let tags        : tagType
    let imageUrl    : URL
    let pdfUrl      : URL
    
    //MARK: - Initialization
    init(title: String,
         authors: [String],
         tags: tagType,
         image_url: URL,
         pdf_url: URL)
    {
        self.title = title
        self.authors = authors
        self.tags = tags
        self.imageUrl = image_url
        self.pdfUrl = pdf_url
    }
    
    //MARK: - Proxies
    func proxieForEquality() -> String {
        return "\(title)"
    }
    
    func proxyForComparison() -> String {
        return proxieForEquality()
    }
}

//MARK: - Protocols
extension Book: Equatable {
    public static func ==(lhs: Book, rhs: Book) -> Bool {
        return (lhs.proxieForEquality() == rhs.proxieForEquality())
    }
}

extension Book : Comparable {
    public static func <(lhs: Book,
                         rhs: Book) -> Bool {
        return (lhs.proxyForComparison() < rhs.proxyForComparison())
    }
}






