//
//  RestaurantTableCellView.swift
//  Rest
//
//  Created by John Baker on 3/16/23.
//

import Foundation
import SwiftUI

class RestaurantTableCellViewModel: ObservableObject {
    @Environment(\.managedObjectContext) private var context

    var restaurant: Restaurant
    @Published var averageStars: Double?
    
    var reviews: [Review] = []

    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        self.reviews = restaurant.review?.compactMap{ $0 } as? [Review] ?? []
        
        if self.reviews.count != 0 {
            self.averageStars = self.reviews.compactMap { Double($0.stars) }.reduce(0, +) / Double(reviews.count)
        }
    }
}

struct RestaurantTableCellView: View {
    
    @ObservedObject var vm: RestaurantTableCellViewModel
    
    var body: some View {
        HStack {
            AverageStarsView(averageStars: vm.averageStars)
            
            VStack {
                Text("\(vm.restaurant.name ?? "")")
                    .fontWeight(.bold)
                Text("\(vm.restaurant.restaurantType ?? "")")
            }
            
            Spacer()
            ZStack {
                Image(systemName: "circle.fill")
                    .foregroundColor(.teal)
                    .font(.system(size: 50))
                Text("\(vm.reviews.count)")
            }
            
        }
    }
}
