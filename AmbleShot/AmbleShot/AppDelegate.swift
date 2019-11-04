//
//  AppDelegate.swift
//  AmbleShot
//
//  Created by myf on 01/11/2019.
//  Copyright © 2019 nerdyak. All rights reserved.
//

import UIKit
import Combine

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let search = FlickrSearch()
    
    var response : FlickrResponse? = nil {
        didSet {
            FlickrSearch.placeImagePublisher(urlPath: response?.firstPhotoPath())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (completion) in
                print ("sinkCompletion")
            }, receiveValue: {
                print ($0)
            })
            .store(in: &self.subscriptions)
        }
    }
    private var subscriptions = Set<AnyCancellable>()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FlickrSearch.locationPhotosPublisher(lng: 15.9392406, lat: 49.5626336)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("received error: ", error)
                }
            }, receiveValue: {
                self.response = $0
                print ($0)
            })
            .store(in: &self.subscriptions)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

