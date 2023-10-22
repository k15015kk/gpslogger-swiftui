//
//  Item.swift
//  gpslogger-swiftui
//
//  Created by 井上晴稀 on 2023/10/22.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
