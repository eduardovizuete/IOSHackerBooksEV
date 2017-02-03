//
//  JSONProcessing.swift
//  HackerBooksEV
//
//  Created by usuario on 2/3/17.
//  Copyright © 2017 evizcloud. All rights reserved.
//

import Foundation
import UIKit

// JSON recibido 
/*
{
    "authors": "Scott Chacon, Ben Straub",
    "image_url": "http://hackershelf.com/media/cache/b4/24/b42409de128aa7f1c9abbbfa549914de.jpg",
    "pdf_url": "https://progit2.s3.amazonaws.com/en/2015-03-06-439c2/progit-en.376.pdf",
    "tags": "version control, git",
    "title": "Pro Git"
}
 */

//MARK: - Aliases
typealias JSONObject        = AnyObject
typealias JSONDictionary    = [String: JSONObject]
typealias JSONArray         = [JSONDictionary]

//MARK: - Decodification
func decode(book json: JSONDictionary) throws -> Book {
    
    // Validamos el diccionario
    
    // "title": "Pro Git"
    guard let title = json["title"] as? String else {
        throw BookError.wrongJSONFormat
    }
    
    // "authors": "Scott Chacon, Ben Straub"
    guard let authors = json["authors"] as? String else {
        throw BookError.wrongJSONFormat
    }
    
    let listAuthors: [String] = authors.components(separatedBy: ",")
    
    // "tags": "version control, git"
    guard let tags = json["tags"] as? String else {
        throw BookError.wrongJSONFormat
    }
    
    let listTags: [String] = tags.components(separatedBy: ",")
    var setTags = Set<Tag>()
    
    for tag in listTags {
        let newTag = Tag.init(name: tag)
        setTags.insert(newTag)
    }
 
    // "pdf_url"
    guard let pdfUrlString = json["pdf_url"] as? String,
        let urlpdf = URL(string:pdfUrlString) else {
            throw BookError.wrongURLFormatForJSONResource
    }
    
    // "image_url"
    guard let imageName = json["image_url"] as? String,
        let urlImage = URL(string:imageName) else {
            throw BookError.resourcePointedByURLNotReachable
    }
    
    return Book.init(title: title,
                     authors: listAuthors,
                     tags: setTags,
                     image_url: urlImage,
                     pdf_url: urlpdf)
    
}

func decode(book json: JSONDictionary?) throws -> Book {
    guard let json = json else {
        throw BookError.nilJSONObject
    }

    return try decode(book: json)
}

// MARK: - Loading from Local
func loadFromLocalFile(fileName name: String,
                       bundle: Bundle = Bundle.main) throws -> JSONArray {
    
    if let url = bundle.url(forResource: name),
        let data = try? Data(contentsOf: url),
        let maybeArray = try? JSONSerialization.jsonObject(
            with: data,
            options: JSONSerialization.ReadingOptions.mutableContainers) as? JSONArray,
        let array = maybeArray {
        return array
        
    } else {
        throw BookError.jsonParsingError
    }
    
}

