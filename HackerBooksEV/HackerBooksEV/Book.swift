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
    var tags        : tagType
    let imageUrl    : AsyncData
    let pdfUrl      : AsyncData
    
    weak var delegate    : BookDelegate?
    
    //MARK: - Initialization
    init(title: String,
         authors: [String],
         tags: tagType,
         image_url: AsyncData,
         pdf_url: AsyncData)
    {
        self.title = title
        self.authors = authors
        self.tags = tags
        self.imageUrl = image_url
        self.pdfUrl = pdf_url
        
        // Set delegate
        self.imageUrl.delegate = self
        self.pdfUrl.delegate = self
    }
    
    //MARK: - Proxies
    func proxieForEquality() -> String {
        return "\(title)"
    }
    
    func proxyForComparison() -> String {
        return proxieForEquality()
    }
}

//MARK: - Favorites
extension Book{
    
    private func hasFavoriteTag() -> Bool{
        let tagFav = Tag(name: "Favorite")
        return tags.contains(tagFav)
    }
    
    
    private func addFavoriteTag(){
        let tagFav = Tag(name: "Favorite")
        tags.append(tagFav)
    }
    
    private func removeFavoriteTag() {
        let tagFav = Tag(name: "Favorite")
        tags.remove(at: tags.index(of: tagFav)!)
    }
    
    
    var isFavorite : Bool{
        
        get{
            return hasFavoriteTag()
        }
        
        set{
            if newValue == true{
                addFavoriteTag()
                sendNotification(name: BookDidChange)
            }else{
                removeFavoriteTag()
                sendNotification(name: BookDidChange)
            }
        }
        
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

//MARK: - Communication - delegate
protocol BookDelegate: class{
    func bookDidChange(sender:Book)
    func bookCoverImageDidDownload(sender: Book)
    func bookPDFDidDownload(sender: Book)
}

// Default implementation of delegate methods
extension BookDelegate{
    
    func bookDidChange(sender:Book){}
    func bookCoverImageDidDownload(sender: Book){}
    func bookPDFDidDownload(sender: Book){}
}

let BookDidChange = Notification.Name(rawValue: "io.keepCoding.BookDidChange")
let BookKey = "io.keepCoding.BookDidChange.BookKey"

let BookCoverImageDidDownload = Notification.Name(rawValue: "io.keepCoding.BookCoverImageDidDownload")
let BookPDFDidDownload = Notification.Name(rawValue: "io.keepCoding.BookPDFDidDownload")

extension Book{
    
    func sendNotification(name: Notification.Name){
        
        let n = Notification(name: name, object: self, userInfo: [BookKey:self])
        let nc = NotificationCenter.default
        nc.post(n)
        
    }
}


//MARK: - AsyncDataDelegate
extension Book: AsyncDataDelegate{
    
    func asyncData(_ sender: AsyncData, didEndLoadingFrom url: URL) {
        
        let notificationName : Notification.Name
        
        
        switch sender {
        case imageUrl:
            notificationName = BookCoverImageDidDownload
            delegate?.bookCoverImageDidDownload(sender: self)
            
        case pdfUrl:
            notificationName = BookPDFDidDownload
            delegate?.bookPDFDidDownload(sender: self)
            
        default:
            fatalError("Should never get here")
        }
        
        
        sendNotification(name: notificationName)
    }
    
    func asyncData(_ sender: AsyncData, shouldStartLoadingFrom url: URL) -> Bool {
        return true
    }
    
    func asyncData(_ sender: AsyncData, willStartLoadingFrom url: URL) {
        print("Starting with \(url)")
    }
    
    func asyncData(_ sender: AsyncData, didFailLoadingFrom url: URL, error: NSError){
        print("Error loading \(url).\n \(error)")
    }
}




