//
//  AverageStarsView.swift
//  Rest
//
//  Created by John Baker on 3/16/23.
//

import Foundation
import SwiftUI

struct AverageStarsView: View {
    
    var averageStars: Double?
    
    var body: some View {
        ZStack {
            Image(systemName: "star.fill")
                .foregroundColor(.teal)
                .font(.system(size: 50)) // potentially scale by screen size instead of hardcoded value if more time

            if let averageStars = averageStars {
                Text("\(String(format: "%.1f", averageStars))")
            }
        }
    }
    
    init(averageStars: Double?) {
        self.averageStars = averageStars
    }
    
    init(averageStars: Int?) {
        self.averageStars = Double(averageStars ?? 0)
    }
}
