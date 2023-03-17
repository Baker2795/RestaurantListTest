//
//  NewReviewView.swift
//  Rest
//
//  Created by John Baker on 3/15/23.
//

import Foundation
import SwiftUI

class NewReviewViewModel: ObservableObject {
    @Published var reviewNotes: String = ""
    @Published var starRating: Int = 5
    
    var date = Date()
    var restaurant: Restaurant
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }
}

struct NewReviewView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.presentationMode) var presentation
    
    @ObservedObject var vm: NewReviewViewModel
    
    var body: some View {
        VStack {
            DatePicker(
                "Start Date",
                selection: $vm.date,
                displayedComponents: [.date]
            )
            
            HStack {
                Text("Star Rating: ")
                Picker("Star Rating", selection: $vm.starRating) {
                    ForEach(1...5, id: \.self) {
                        Text($0.description)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Text("Review:")
                .frame(maxWidth: .infinity, alignment: .leading)
            TextEditor(text: $vm.reviewNotes)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.black, lineWidth: 1)
                        .opacity(0.3)
                )
                .frame(height: 200) // would probably do based on screen size instead of hardcoded value with moret ime
            Spacer()
            Button(action: {
                let review = Review(context: context)
                review.date = vm.date
                review.notes = vm.reviewNotes
                review.stars = Int16(vm.starRating)
                
                try? context.save() // properly handle error if had time // check if required fields are blank before save
                
                vm.restaurant.addToReview(review)
                self.presentation.wrappedValue.dismiss()
            }) {
                Text("Save")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
