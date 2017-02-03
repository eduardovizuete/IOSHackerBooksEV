//
//  BookError.swift
//  HackerBooksEV
//
//  Created by usuario on 2/3/17.
//  Copyright © 2017 evizcloud. All rights reserved.
//

import Foundation

enum BookError: Error {
    case resourcePointedByURLNotReachable
    case wrongURLFormatForJSONResource
    case wrongJSONFormat
    case nilJSONObject
    case jsonParsingError
}
