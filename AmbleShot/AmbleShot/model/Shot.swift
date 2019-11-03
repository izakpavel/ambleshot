//
//  Shot.swift
//  AmbleShot
//
//  Created by myf on 01/11/2019.
//  Copyright © 2019 nerdyak. All rights reserved.
//

import Foundation

enum ShotState : Int, Codable {
    case justLocation = 0
    case loading = 1 // loading of image description and downloading of data is understood as a single operation
    case loaded = 2
}

class Shot : Identifiable, Codable, ObservableObject{
    let id: Int // unique identifier
    let lat: Double
    let lng: Double
    var imageUrl: String?
    @Published var state : ShotState
    
    init(id: Int, lat: Double, lng: Double) {
        self.id = id
        self.lat = lat
        self.lng = lng
        self.imageUrl = nil
        self.state = .justLocation
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case lat
        case lng
        case imageUrl
        case state
    }
    
    required init(from decoder: Decoder) throws{
    
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decode(Int.self, forKey: .id)
        self.lat = try values.decode(Double.self, forKey: .lat)
        self.lng = try values.decode(Double.self, forKey: .lng)
        self.imageUrl = try values.decode(String.self, forKey: .imageUrl)
        self.state = try values.decode(ShotState.self, forKey: .state)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(lat, forKey: .lat)
        try container.encode(lng, forKey: .lng)
        try container.encode(imageUrl, forKey: .imageUrl)
        try container.encode(state, forKey: .state)
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
