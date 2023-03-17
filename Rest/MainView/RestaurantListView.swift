//
//  ContentView.swift
//  Rest
//
//  Created by John Baker on 3/15/23.
//

import SwiftUI
import CoreData

// MARK: - Body
struct RestaurantListView: View {
    @Environment(\.managedObjectContext) private var context

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Restaurant.name, ascending: true)],
        animation: .default) //would probably handle creating fetch requests from @nonobjc class func if had more time
    
    private var restaurants: FetchedResults<Restaurant>
    
    @State var restaurantSelectedToEdit: Bool = false
    @State var selectedRestaurant: Restaurant?
    
        
    var body: some View {
        NavigationView { // might move navigation components to a parent level using a navigationstack if navigation were to get more complex than it's current state
            List {
                ForEach(restaurants) { restaurant in
                    
                    NavigationLink {
                        RestaurantDetailView(vm: RestaurantDetailViewModel(restaurant: restaurant))
                    } label: {
                        RestaurantTableCellView(vm: RestaurantTableCellViewModel(restaurant: restaurant))
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            deleteRestaurant(restaurant: restaurant)
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                        
                        Button(action: {
                            restaurantSelectedToEdit = true
                            self.selectedRestaurant = restaurant
                            
                        }) {
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(.yellow)
                    }
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        NewRestaurantView()
                    } label: {
                        Label("New Restaurant", systemImage: "plus")
                    }
                }
            }
        }
        .popover(item: $selectedRestaurant) { restaurant in
            let vm = NewRestaurantViewModel(restaurantToEdit: restaurant)
            NewRestaurantView(vm: vm)
        }
        
    }
}

// MARK: - Functions

extension RestaurantListView {
    private func deleteRestaurant(restaurant: Restaurant) {
        withAnimation {
            guard let restaurantToDelete = restaurants.first(where: { $0.id == restaurant.id }) else { return }
            
            context.delete(restaurantToDelete)

            do {
                try context.save()
            } catch {
               //using default deleteItems func provided by project template, would handle error (or at least not crash) with extra time
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
