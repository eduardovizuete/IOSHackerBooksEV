//
//  Tag.swift
//  HackerBooksEV
//
//  Created by usuario on 2/3/17.
//  Copyright © 2017 evizcloud. All rights reserved.
//

import Foundation

class Tag: Hashable {
    
    //MARK: - StoredProperties
    let name    : String
    
    var hashValue: Int {
        get {
            return "\name".hashValue
        }
    }
    
    //MARK: - Initialization
    init(name: String) {
        self.name = name
    }
}

func ==(lhs: Tag, rhs: Tag) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
