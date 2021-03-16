//
//  NameModel.swift
//  MantraDemo
//
//  Created by Jeetendra on 16/03/21.
//

import Foundation
import UIKit

struct Category: Codable {
    
    var name: String!
    var sub_category: [SubCategory]!
    var collapsed: Bool? = false
}
struct SubCategory: Codable {
    
    var name: String!
    var display_name: String!
    
}
