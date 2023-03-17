//
//  NewRestaurantView.swift
//  Rest
//
//  Created by John Baker on 3/15/23.
//

import Foundation
import SwiftUI

class NewRestaurantViewModel: ObservableObject {
    @Published var restaurantName: String = ""
    @Published var restaurantType: RestaurantType = .American
    
    var restaurantToReplace: Restaurant?
    
    init() { }
    
    init(restaurantToEdit: Restaurant) {
        self.restaurantToReplace = restaurantToEdit
        self.restaurantName = restaurantToEdit.name ?? ""
        self.restaurantType = RestaurantType(rawValue: restaurantToEdit.restaurantType ?? "") ?? .American
    }
}

struct NewRestaurantView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.presentationMode) var presentation
    
    @ObservedObject var vm = NewRestaurantViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Restaurant Name: ", text: $vm.restaurantName)
                .textFieldStyle(.roundedBorder)
                .padding()
            HStack {
                Text("Restaurant Type: ")
                Picker("Restaurant Type", selection: $vm.restaurantType) {
                    ForEach(RestaurantType.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.menu)
            }
            .padding()
            
            HStack(alignment: .center) {
                Button(action: {
                    self.saveCurrentRestaurant()
                    presentation.wrappedValue.dismiss()
                }){
                    Text("Save")
                }
                .buttonStyle(.borderedProminent)
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
        }
    }
}

extension NewRestaurantView {
    private func saveCurrentRestaurant() {
        withAnimation {
            var restaurantToSave: Restaurant
            
            if let restaurant = vm.restaurantToReplace {
                restaurantToSave = restaurant
            }
            else {
                let newRestaurant = Restaurant(context: context)
                newRestaurant.id = UUID()
                restaurantToSave = newRestaurant
            }
            
            // would probably check if values are empty if more time
            restaurantToSave.name = vm.restaurantName
            restaurantToSave.restaurantType = vm.restaurantType.rawValue

            do {
                try context.save()
            } catch {
                // Would correctly handle error if more time
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}
