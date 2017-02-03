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
    typealias tagType = Set<Tag>

    
    //MARK: - StoredProperties
    let title       : String
    let authors     : [String]
    let tags        : tagType
    let image_url   : URL
    let pdf_url     : URL
    
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
        self.image_url = image_url
        self.pdf_url = pdf_url
    }
    
}
