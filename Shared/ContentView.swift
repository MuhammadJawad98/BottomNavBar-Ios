//
//  ContentView.swift
//  Shared
//
//  Created by Ali Raza on 18/02/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    //Recording status
    @State var isRecording:Bool = false
    @State var url:URL?
    @State var shareVideo: Bool =  false
    init() {
           UITabBar.appearance().backgroundColor = UIColor.white
       }
    var body: some View {
        TabView (selection: $selection){
            

            HomeScreen()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }.tag(1)
             
            SearchScreen()
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .tabItem {
                        Image(systemName: "bookmark.circle.fill")
                        Text("Bookmark")
                    }.tag(2)
             
            ProfileScreen()
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .tabItem {
                        Image(systemName: "video.circle.fill")
                        Text("Video")
                    }.tag(3)
             
            SettingScreen()
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }.tag(4)
            

        }.overlay(alignment: .bottomTrailing){
            //mark: recording button
            Button{
              //  isRecording.toggle()
                if isRecording{
                    //stopping
                    //since its an async task
                    Task{
                        do{
                            self.url = try await stopRecording()
                            isRecording = false
                            shareVideo.toggle()
                            // print(self.url)
                            
                        }catch{
                            print(error.localizedDescription)
                        }
                    }
                }else{
                    //Start recording
                        startRecording{error in
                                       if let error = error {
                            print(error.localizedDescription)
                            return
                        }
                        //success
                            isRecording = true
                        }
                               }
            }label: {
                Image(systemName: isRecording ? "record.circle.fill" : "record.circle")
                    .font(.largeTitle)
                    .foregroundColor(isRecording ? .red: .white)
                
            }.padding()
        }
        //simply call share sheet modifier
        .shareSheet(show: $shareVideo, items: [url])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
