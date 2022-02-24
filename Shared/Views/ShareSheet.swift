//
//  ShareSheet.swift
//  BottomNavBar (iOS)
//
//  Created by Ali Raza on 24/02/2022.
//

import SwiftUI

//Mark: UIKit share sheet
struct ShareSheet: UIViewControllerRepresentable{
    
    var items: [Any]
    func makeUIViewController(context: Context) -> some UIViewController {
        let view = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return view
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    
}
