//
//  Library.swift
//  HackerBooksEV
//
//  Created by usuario on 2/3/17.
//  Copyright © 2017 evizcloud. All rights reserved.
//

import Foundation

class Library {
    
    //MARK: - StoredProperties
    
    // Array de libros
    var books: [Book]
    
    // Array de tags con todas las distintas tematicas en
    // orden alfabetico, no puede bajo ningun concepto haber 
    // ninguno repetido
    // Nota instrucciones: dos opciones, un array ordenado
    // (si es favorito, el Tag Favorite esta en la primera posicion)
    // o un Set<Tag>
    var tags: Set<Tag>
    
    //MARK: - Initialization
    init(books: [Book],
         tags: Set<Tag>
        )
    {
        self.books = books
        self.tags = tags
    }
    
    // Numero total de libros
    var bookCounts: Int {
        get {
            let count: Int = self.books.count
            return count
        }
    }
    
    // Cantidad de libros que hay en una tematica.
    // Si el tag no existe, debe devolver cero
    func bookCount(forTagName name: Tag) -> Int {
        var count = 0
        
        for book in books {
            if (book.tags.contains(name)) {
                count = count + 1
            }
        }
        
        return count
    }
    
    // Array de los libros (instancias de Book) que hay en un tematica
    // Un libro puede estar en una o mas tematicas. Si no hay
    // libros para una tematica, ha de devolver nil
    func books(forTagName name: Tag) -> [Book]? {
        var booksByTag: [Book]?
        for book in books {
            if (book.tags.contains(name)) {
                booksByTag?.append(book)
            }
        }
        
        return booksByTag
    }
    
    // Un Book para el libro que esta en la posicion 'index' 
    // de aquellos bajo un cierto tag. Mira a ver si puedes usar el 
    // metodo anterior para hacer parte de tu trabajo.
    // Si el indice no existe o el tag no existe, ha de devolver nil
    func book(forTagName name: Tag, at: Int) -> Book? {
        var bookAtIndex: Book?
        
        var booksByTag = books(forTagName: name)
        
        bookAtIndex = booksByTag?[at]
        
        return bookAtIndex
    }
}








