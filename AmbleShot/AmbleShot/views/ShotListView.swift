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
        .frame(height: 200)
    }
}



struct ShotListView: View {
    @EnvironmentObject var locationService: LocationService
    
    var toggleButton: some View {
        Button(action: {
            self.locationService.toggle()
            
        }) {
            Text(self.locationService.running ? "Stop" : "Start")
                .padding()
        }
    }
    
    var body: some View {
        NavigationView {
            List(self.locationService.shots, id: \.id) { shot in
                ShotView(shot: shot)
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle(Text("AmbleShot"))
            .navigationBarItems(trailing: toggleButton)
        }
        
    }
}

struct ShotListView_Previews: PreviewProvider {
    static var previews: some View {
        ShotListView()
    }
}
