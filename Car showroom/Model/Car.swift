//
//  Car.swift
//  Car showroom
//
//  Created by Viktor on 11/04/2019.
//  Copyright © 2019 Viktor Chernykh. All rights reserved.
//

import SceneKit

struct Car {
    var name: String
    var url: String
    var characteristics: String
    var rating: Int
    var timestamp: Date
}

// MARK: - Computed Properties
extension Car {
    var stars: String {
        var starRating = ""
        
        for _ in 1...min(rating, 10) {
            starRating += "⭐️"
        }
        
        return starRating
    }
    
    var date: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: timestamp)
    }
}

// MARK: - Methods
extension Car {
    static func loadSample() -> [Car] {
        return [
            Car(name: "ship", url: "art.scnassets/ship/ship.scn", characteristics: "Очень вкусный", rating: 10, timestamp: Date()),
            Car(name: "ZIS-8", url: "art.scnassets/ZIS-8/ZIS-8.dae", characteristics: "Очень вкусный завтрак", rating: 10, timestamp: Date()),
            Car(name: "ZIS-5B", url: "art.scnassets/dodge/dodge-challenger_model.dae", characteristics: "Неплохой обед", rating: 8, timestamp: Date()),
            Car(name: "Roadster", url: "art.scnassets/Roadster.dae", characteristics: "Сытый полдник", rating: 7, timestamp: Date()),
            Car(name: "ZIS-16", url: "art.scnassets/ZIS-16.dae", characteristics: "Отличный ужин", rating: 9, timestamp: Date())
        ]
    }
}
