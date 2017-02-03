//
//  FoundationExtensions.swift
//  HackerBooksEV
//
//  Created by usuario on 2/3/17.
//  Copyright © 2017 evizcloud. All rights reserved.
//

import Foundation

extension Bundle{
    
    func url(forResource name: String) -> URL?{
        
        // Partir el nombre por el .
        let tokens = name.components(separatedBy: ".")
        
        // Si sale bien crear la URL
        return url(forResource: tokens[0], withExtension: tokens[1])
    }
    
}

