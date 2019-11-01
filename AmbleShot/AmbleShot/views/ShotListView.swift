//
//  ShotListView.swift
//  AmbleShot
//
//  Created by myf on 01/11/2019.
//  Copyright © 2019 nerdyak. All rights reserved.
//

import SwiftUI

struct ShotView: View {
    var shot: Shot
    var body: some View {
        VStack {
            Spacer()
            HStack{
                Text(self.shot.displayName())
                    .padding()
                Spacer()
                Text(self.shot.formattedLocation())
                    .padding()
            }
            .background(Color.gray)
        }
        .background(Color.green)
        .cornerRadius(20)
    }
}



struct ShotListView: View {
    @EnvironmentObject var locationService: LocationService
    var body: some View {
        VStack {
            ForEach (self.locationService.shots) { shot in
                ShotView(shot: shot)
                    .padding()
            }
        }
    }
}

struct ShotListView_Previews: PreviewProvider {
    static var previews: some View {
        ShotListView()
    }
}
