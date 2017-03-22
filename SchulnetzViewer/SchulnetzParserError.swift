//
//  SchulnetzParserError.swift
//  SchulnetzViewer
//
//  Created by Lukas Weber on 26.06.16.
//  Copyright © 2016 Lukas Weber. All rights reserved.
//

import Foundation

enum SchulnetzParserError : Error{
    case noConfig
    case invailedUrl
    case invailedPin
    case noContent
    case unknownError
}
