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
            Car(name: "ship", url: "art.scnassets/ship/ship.scn", characteristics: "Отличный самолет", rating: 10, timestamp: Date()),
            Car(name: "ЗИС-8", url: "art.scnassets/ZIS-8/ZIS-8.dae", characteristics: "ЗИС-8 имел шестицилиндровый рядный карбюраторный мотор объемом 5,55 литров и мощностью в 73 л.с., который позволял автобусу полной массой 6,1 т разгоняться до 60 км/ч.", rating: 10, timestamp: Date()),
            Car(name: "ЗИС-5В", url: "art.scnassets/ZIS-5B/З®С-5В.dae", characteristics: "ЗИС-5 («трёхтонка») — советский грузовой автомобиль грузоподъёмностью 3 т; второй по массовости (после ГАЗ-АА) грузовик 1930-40-х, один из основных транспортных автомобилей Красной Армии во время Великой Отечественной войны. Выпускался с 1933 по 1948 на Автомобильном заводе имени И. В. Сталина. ", rating: 7, timestamp: Date()),
            Car(name: "ЗИС-16", url: "art.scnassets/ZIS-16/З®С-16.dae", characteristics: "ЗИС-16 — более совершенная модель по сравнению с предшественником — ЗИС-8. Производство автобуса ЗИС-16, отличавшегося обтекаемой формой кузова, но по-прежнему выполненному на деревянном каркасе, было с 1938 года до августа 1941 года. Автобус вмещал до 34 пассажиров. Форсированный примерно до 84 л.с. двигатель ЗИС-16 с алюминиевым блоком цилиндров разгонял машину полной массой 7,13 т до 65 км/ч.", rating: 9, timestamp: Date()),
            Car(name: "Dodge", url: "art.scnassets/dodge/dodge-challenger_model.dae", characteristics: "Dodge", rating: 8, timestamp: Date())
        ]
    }
}
