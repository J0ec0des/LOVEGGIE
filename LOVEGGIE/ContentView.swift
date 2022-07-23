//
//  ContentView.swift
//  UBER_practice
//
//  Created by Hitomi Nakamura on 2022/07/13.
//

import SwiftUI
import FirebaseStorage

struct ContentView: View {
    var body: some View {
        TabView
        {
            FirstView().tabItem
            {
                Image(systemName: "heart")
            }
            
            SecondView().tabItem
            {
                Image(systemName: "magnifyingglass")
            }
            
            ThirdView().tabItem
            {
                Image("Tomato_Icon")
                    .renderingMode(.original)
                .resizable()
                .frame(width: 3.5, height: 3.5)
                .padding(.horizontal)
            }
            
            FourthView().tabItem
            {
                Image(systemName: "message")
            }
            
            FifthView().tabItem
            {
                Image(systemName: "clock").opacity(0.1)
            }
        }
        .accentColor(Color.black) // color of when the button was pressed
        .onAppear{
            UITabBar.appearance().backgroundColor = UIColor(white: 1, alpha: 0.4)
            UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FirstView: View
{
    var body: some View
    {
        ZStack
        {
            Color.white.ignoresSafeArea(edges: .top)
        }
    }
}

struct SecondView: View
{
    var body: some View
    {
        ZStack
        {
            Color.white.ignoresSafeArea(edges: .top)
        }
    }
}

struct ThirdView: View
{
    @State var isPickerShowing = false
    @State var selectedImage: UIImage?
    var body: some View
    {
        ZStack
        {
            Color.white.ignoresSafeArea(edges: .top)
            
            //image picker stack
            VStack {
                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .frame(width: 200, height: 200)
                }
                
                Button {
                    // show image previews
                    isPickerShowing = true
                } label: {
                    Text("Select a Photo")
                }
                
                // Upload Button
                if selectedImage != nil {
                    Button {
                        //Upload the image
                        uploadPhoto()
                    } label: {
                        Text("Upload Photo")
                    }
                }
            }
             .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
                //Image picker
                ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
            }
        }
    }
    
    func uploadPhoto() {
        // image exists
        guard selectedImage != nil else {
            return
        }
        
        // Create storage reference
        let storageRef = Storage.storage().reference()
        
        
        // turn image to data
        let imageData = selectedImage!.jpegData(compressionQuality: 0.0)
        guard imageData != nil else{
            return
        }
        
        // specify file path and name
        let fileRef = storageRef.child("images/\(UUID().uuidString).jpg")
        
        // Upload data
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            // check error
            if error == nil && metadata != nil {
                
            }
            
        }
        
        // Save referecne to that data
    }
}
    
struct FourthView: View
{
    var body: some View
    {
        ZStack
        {
            Color.white.ignoresSafeArea(edges: .top)
        }
    }
}
    
struct FifthView: View
{
    var body: some View
    {
        ZStack
        {
            Color.white.ignoresSafeArea(edges: .top)
        }
    }
}
