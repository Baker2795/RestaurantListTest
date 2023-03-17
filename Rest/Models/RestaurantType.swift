//
//  RestaurantType.swift
//  Rest
//
//  Created by John Baker on 3/15/23.
//

import Foundation


enum RestaurantType: String, CaseIterable {
    case Mexican
    case American
    case Chinese
    case Italian
    
    init?(rawValue: String) {
        switch rawValue {
        case "Mexican":
            self = .Mexican
        case "American":
            self = .American
        case "Chinese":
            self = .Chinese
        case "Italian":
            self = .Italian
        default:
            return nil
        }
    }
}
