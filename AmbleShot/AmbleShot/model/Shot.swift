//
//  Shot.swift
//  AmbleShot
//
//  Created by myf on 01/11/2019.
//  Copyright © 2019 nerdyak. All rights reserved.
//

import Foundation
import Combine

enum ShotState : Int, Codable {
    case justLocation = 0
    case loading = 1 // loading of image description and downloading of data is understood as a single operation
    case loaded = 2
}

class Shot : Identifiable, Codable, ObservableObject{
    let id: Int // unique identifier
    let lat: Double
    let lng: Double
    @Published var imageFilename: String?
    @Published var state : ShotState

    
    private var loadSubscriber: AnyCancellable? = nil
    
    init(id: Int, lat: Double, lng: Double) {
        self.id = id
        self.lat = lat
        self.lng = lng
        self.imageFilename = nil
        self.state = .justLocation
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case lat
        case lng
        case imageFilename
        case state
    }
    
    required init(from decoder: Decoder) throws{
    
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decode(Int.self, forKey: .id)
        self.lat = try values.decode(Double.self, forKey: .lat)
        self.lng = try values.decode(Double.self, forKey: .lng)
        self.imageFilename = try values.decode(String.self, forKey: .imageFilename)
        self.state = try values.decode(ShotState.self, forKey: .state)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(lat, forKey: .lat)
        try container.encode(lng, forKey: .lng)
        try container.encode(imageFilename, forKey: .imageFilename)
        try container.encode(state, forKey: .state)
    }
    
    func loadImage() {
        self.loadSubscriber = FlickrSearch.locationPhotoPublisher(lng: 15.9392406, lat: 49.5626336)
            .receive(on: RunLoop.main)
            .handleEvents(receiveSubscription: { _ in
                self.state = ShotState.loading
            }, receiveCompletion: { _ in
                self.state = ShotState.loaded
            }, receiveCancel: {
                self.state = ShotState.justLocation
            })
            .mapError { $0 as Error }
            .sink(receiveCompletion: { (completion) in
                print ("sinkCompletion")
            }, receiveValue: {
                print ("stored to:\($0)")
                self.imageFilename = $0
            })
    }
    
    func fullImagePath()->String? {
        if let filename = self.imageFilename {
            let url = FilesystemHelper.fileURL(filename: filename)
            return url?.path
        }
        return nil
    }
    
    func displayName()->String {
        return "Shot \(id + 1)"
    }
    
    func formattedLocation()->String {
        return "[\(self.lng),\(self.lat)]"
    }
}
