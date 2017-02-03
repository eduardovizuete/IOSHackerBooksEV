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
typealias tagType           = Set<Tag>

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
    var setTags = tagType()
    
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

// MARK: - Loading

func downloadAndSaveJSONFile() throws -> JSONArray {
    let nameJSONBook = "books_readable.json"
    
    // Verificar si el archivo existe en local
    if existLocalFile(filename: nameJSONBook) {
        // cargar archivo desde local
        return try loadFromLocalFile(fileName: nameJSONBook)
    } else {
        // cargar archivo desde la red
        return try loadFromNetworkFile(fileName: nameJSONBook)
    }
}

func loadFromLocalFile(fileName name: String) throws -> JSONArray {
    let sourcePaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let path = sourcePaths[0]
    let url: URL = URL(fileURLWithPath: name, relativeTo: path)
    
    if let data = try? Data(contentsOf: url),
        let maybeArray = try? JSONSerialization.jsonObject(
            with: data,
            options: JSONSerialization.ReadingOptions.mutableContainers) as? JSONArray,
        let array = maybeArray {
        return array
        
    } else {
        throw BookError.jsonParsingError
    }
}

func loadFromNetworkFile(fileName name: String) throws -> JSONArray {
    // Descargar los datos desde internet
    let urlJSONFile = "https://t.co/K9ziV0z3SJ"
    let jsonFile = try? Data(contentsOf: URL(string: urlJSONFile)!)
    
    guard let downloadData = jsonFile else {
        throw BookError.resourcePointedByURLNotReachable
    }
    
    // almacenar los datos en un archivo
    let sourcePaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let path = sourcePaths[0]
    let file: URL = URL(fileURLWithPath: name, relativeTo: path)
    let fileManager = FileManager.default
    
    fileManager.createFile(atPath: file.path, contents: downloadData, attributes: nil)

    return try loadFromLocalFile(fileName: name)
}

/*
func loadFromLocalFileBundle(fileName name: String,
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
 */

func existLocalFile(filename name: String) -> Bool {
    let sourcePaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let path = sourcePaths[0]
    let file: URL = URL(fileURLWithPath: name, relativeTo: path)
    let fileManager = FileManager.default
    
    if fileManager.fileExists(atPath: file.path) {
        return true
    } else {
        return false
    }
}




