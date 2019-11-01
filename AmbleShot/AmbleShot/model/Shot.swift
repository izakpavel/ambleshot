//
//  Shot.swift
//  AmbleShot
//
//  Created by myf on 01/11/2019.
//  Copyright © 2019 nerdyak. All rights reserved.
//

import Foundation

class Shot : Identifiable, Codable{
    let id: Int // unique identifier
    let lat: Double
    let lng: Double
    
    init(id: Int, lat: Double, lng: Double) {
        self.id = id
        self.lat = lat
        self.lng = lng
    }
    
    func imageName()->String {
        return "shot_\(id)"
    }
    
    func displayName()->String {
        return "Shot \(id + 1)"
    }
    
    func formattedLocation()->String {
        return "[\(self.lng),\(self.lat)]"
    }
}
