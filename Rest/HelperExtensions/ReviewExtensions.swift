//
//  ReviewExtensions.swift
//  Rest
//
//  Created by John Baker on 3/16/23.
//

import Foundation

extension Review {
    var formattedDate: String {
        return self.date?.formatted() ?? "" // would change date formatting to match images if had more time
    }
}
