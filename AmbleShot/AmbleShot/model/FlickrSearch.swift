//
//  FlickrSearch.swift
//  AmbleShot
//
//  Created by myf on 01/11/2019.
//  Copyright © 2019 nerdyak. All rights reserved.
//

//
// f36034673c1743f3
// sample query: https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=b3ed5f78045e00d6d770122978a1bb8a&format=json&geo_context=2&radius=1&lon=15.9392406&lat=49.5626336&geo_context=2&per_page=10
// sample response:
//jsonFlickrApi({"photos":{"page":1,"pages":18,"perpage":10,"total":"175","photo":[{"id":"46547606804","owner":"22982558@N07","secret":"28dafbea5b","server":"7808","farm":8,"title":"Modr\u00e1 hodina\/The blue hour (750.719 \u010cD, \u017d\u010f\u00e1r nad S\u00e1zavou, Sp 1437 \"Pern\u0161tejn\").","ispublic":1,"isfriend":0,"isfamily":0},{"id":"38174547041","owner":"141464170@N04","secret":"14572b9a8c","server":"4463","farm":5,"title":"Lamps After Sunset","ispublic":1,"isfriend":0,"isfamily":0},{"id":"46155887634","owner":"141464170@N04","secret":"84b6d694b4","server":"4848","farm":5,"title":"","ispublic":1,"isfriend":0,"isfamily":0},{"id":"43805818915","owner":"144912669@N02","secret":"1fa9a37870","server":"1898","farm":2,"title":"IMG_20180916_122945","ispublic":1,"isfriend":0,"isfamily":0},{"id":"42904854530","owner":"144912669@N02","secret":"162a314711","server":"1881","farm":2,"title":"IMG_20180916_122942","ispublic":1,"isfriend":0,"isfamily":0},{"id":"29778096007","owner":"144912669@N02","secret":"7a95996b5c","server":"1851","farm":2,"title":"IMG_20180916_122935","ispublic":1,"isfriend":0,"isfamily":0},{"id":"42702552894","owner":"141464170@N04","secret":"2b4be6f348","server":"1781","farm":2,"title":"","ispublic":1,"isfriend":0,"isfamily":0},{"id":"42702551634","owner":"141464170@N04","secret":"92321eeb94","server":"1829","farm":2,"title":"","ispublic":1,"isfriend":0,"isfamily":0},{"id":"29548605958","owner":"141464170@N04","secret":"7e6d68eedd","server":"1828","farm":2,"title":"","ispublic":1,"isfriend":0,"isfamily":0},{"id":"42702549294","owner":"141464170@N04","secret":"42333d9c74","server":"917","farm":1,"title":"","ispublic":1,"isfriend":0,"isfamily":0}]},"stat":"ok"})

// image url: https://farm2.staticflickr.com/1898/43805818915_1fa9a37870.jpg
//  https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg

import Foundation



class FlickrSearch {
    let apiKey = "b3ed5f78045e00d6d770122978a1bb8a"
    let endpoint = "https://api.flickr.com/services/rest"
    let searchMethod = "flickr.photos.search"
    let imageFormat = "https://farm%@.staticflickr.com/%@/%@_%@.jpg"
    let radius = 0.1
    let perPage = 1
    let geoContext = 2 // outdoors only
    
    let defaultSession = URLSession(configuration: .default)
    
    func searchForImagesAround(lng: Double, lat:Double) {
        //var dataTask: URLSessionDataTask?
        if var urlComponents = URLComponents(string: endpoint) {
            urlComponents.query = "method=\(searchMethod)&api_key=\(apiKey)&format=json&geo_context=\(geoContext)&radius=\(radius)&lat=\(lat)&lon=\(lng)&per_page=\(perPage)&nojsoncallback=1"
            
            guard let requestUrl = urlComponents.url else {
              return
            }
            let task = defaultSession.dataTask(with: requestUrl){
                 (data, response, error) in
                 if let error = error {
                    print(error.localizedDescription)
                 } else {
                    guard let data = data else {
                        // missing data
                        print ("no data recieved")
                        return
                    }
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                        print (json)
                    }
                    catch let error as NSError {
                        print(error.debugDescription)
                    }
                 }
            }
            task.resume()
        }
    }
}