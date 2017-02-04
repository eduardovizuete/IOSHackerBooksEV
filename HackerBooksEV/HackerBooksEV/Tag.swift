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
    
    //MARK: - Proxies
    func proxieForEquality() -> String {
        return "\(name)"
    }
    
    func proxyForComparison() -> String {
        return proxieForEquality()
    }
}

//MARK: - Protocols
extension Tag: Equatable {
    public static func ==(lhs: Tag, rhs: Tag) -> Bool {
        return (lhs.proxieForEquality() == rhs.proxieForEquality())
    }
}

extension Tag : Comparable {
    public static func <(lhs: Tag, rhs: Tag) -> Bool {
        return (lhs.proxyForComparison() < rhs.proxyForComparison())
    }
}

/*
 func ==(lhs: Tag, rhs: Tag) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
 */
 
