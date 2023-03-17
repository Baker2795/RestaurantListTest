//
//  RestaurantExtensions.swift
//  Rest
//
//  Created by John Baker on 3/16/23.
//

import Foundation
import CoreData

extension Restaurant {
    var averageStarsRating: Double? {
        let reviews = self.review?.compactMap{ $0 } as? [Review] ?? []
        
        if reviews.count != 0 {
            return reviews.compactMap { Double($0.stars) }.reduce(0, +) / Double(reviews.count)
        }
        return nil
    }
}
