//
//  Extensions.swift
//  BottomNavBar (iOS)
//
//  Created by Ali Raza on 24/02/2022.
//

import SwiftUI
import ReplayKit

//Mark: App record extensions
extension View{
    
    //mark: Start Recording
    func startRecording(enableMicrophone: Bool = false ,completion: @escaping (Error?)->()){
        let recorder = RPScreenRecorder.shared()
        
        //MicroPhone Option
        recorder.isMicrophoneEnabled = false
        
        //start Recording
        recorder.startRecording(handler:  completion)
        
    }
    
    //mark: stop recording
    //it will return the recorded video url
    func stopRecording()async throws->URL{
        //File will be store in temporary directory
        //video name
        let name = UUID().uuidString + ".mp4"
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(name)
        let recorder = RPScreenRecorder.shared()
        try await recorder.stopRecording(withOutput: url)
        return url
    }
    
    //MARK: cancle recording
    //optional
    func cancleRecording(){
        let recorder = RPScreenRecorder.shared()
        recorder.discardRecording {}
    }
    
    //MARK: share sheet
    //Its a custom modifer
    func shareSheet(show: Binding<Bool>,items: [Any?])->some View{
        return self
            .sheet(isPresented: show){
                
            }content:{
                //wrapping the optionals
                let items = items.compactMap{
                    item -> Any? in
                    return item
                }
                if !items.isEmpty{
                    ShareSheet(items: items)
                }
            }
    }
    
}
