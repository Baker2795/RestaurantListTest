//
//  RestaurantDetailView.swift
//  Rest
//
//  Created by John Baker on 3/15/23.
//

import Foundation
import SwiftUI
import CoreData

class RestaurantDetailViewModel: ObservableObject {
    @Environment(\.managedObjectContext) private var context
    
    var restaurant: Restaurant
    var reviews: [Review] = []
    
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        self.reviews = restaurant.review?.compactMap{ $0 } as? [Review] ?? []
    }
}

struct RestaurantDetailView: View {
    @ObservedObject var vm: RestaurantDetailViewModel
    
    var body: some View {
        VStack {
            RestaurantDescriptionView(restaurant: $vm.restaurant)
            List {
                ForEach(vm.reviews) { review in
                    ReviewTableCellView(review: review)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    NewReviewView(vm: NewReviewViewModel(restaurant: self.vm.restaurant))
                } label: {
                    Label("New Review", systemImage: "plus")
                }
            }
        }
    }
}

struct ReviewTableCellView: View {
    @State var review: Review
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(review.formattedDate)")
                .fontWeight(.bold)
            HStack {
                AverageStarsView(averageStars: Double(review.stars))
                Text("\(review.notes ?? "")")
                Spacer()
            }
        }
    }
}


struct RestaurantDescriptionView: View {
    @Binding var restaurant: Restaurant
    @State var averageStars: Double?
    
    var body: some View {
        HStack {
            AverageStarsView(averageStars: averageStars)
            Spacer()
            VStack {
                Text("\(restaurant.name ?? "")")
                    .fontWeight(.bold)
                Text("\(restaurant.restaurantType ?? "")")
            }
            Spacer()
        }
        .onAppear {
            self.averageStars = restaurant.averageStarsRating
        }
    }
}
