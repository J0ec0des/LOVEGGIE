//
//  ImagePicker.swift
//  LOVEGGIE
//
//  Created by Joe Kojima on 7/16/22.
//

import Foundation
import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Binding var isPickerShowing: Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var parent: ImagePicker
    
    init(_ picker: ImagePicker) {
        self.parent = picker
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancelled")
        //Dismiss the picker UI
        parent.isPickerShowing = false
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Image Selected")
        
        //key for image data
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //assigned to image if image not null
            DispatchQueue.main.async { //to run in main thread
                self.parent.selectedImage = image
            }
        }
        //Dismiss the picker UI
        parent.isPickerShowing = false
    }
}


