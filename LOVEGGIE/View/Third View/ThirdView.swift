//
//  ThirdView.swift
//  LOVEGGIE
//
//  Created by Joe Kojima on 7/24/22.
//
import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct ThirdView: View {
    
    @StateObject private var viewmodel = ThirdViewModel()
    
    @State var isPickerShowing = false
    @State var selectedImage: UIImage?
    @State var retrievedImages = [UIImage]()
    
    var body: some View {
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
                
                Divider()
                
                HStack {
                    //loop through images
                    ForEach(retrievedImages, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                }
            }
            .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
                //Image picker
                ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
            }
             .onAppear {
                 retrievePhotos()
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
        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        // Upload data
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            // check error
            if error == nil && metadata != nil {
                // save reference to the file in firestore database
                let db = Firestore.firestore()
                db.collection("images").document().setData(["url":path]) { error in
                    // if there are no error display the new image
                    if error == nil {
                        DispatchQueue.main.async {
                            self.retrievedImages.append(self.selectedImage!)
                        }
                    }
                }
            }
            
        }
        // Save reference to that data
    }
    
    func retrievePhotos() {
        
        // Get data from database
        let db = Firestore.firestore()
        
        db.collection("images").getDocuments { snapshot, error in
            if error == nil && snapshot != nil {
                
                var paths = [String]()
                
                //Loops through all the returned images
                for doc in snapshot!.documents {
                    
                    //Extract the file path and add to array
                    paths.append(doc["url"] as! String)
                    
                }
                
                //Loops throguh file paths and fetches the data form firebase storage
                for path in paths {
                    
                    //Gets a reference to storage
                    let storageRef = Storage.storage().reference()
                    
                    //specifies path
                    let fileRef = storageRef.child(path)
                    
                    //retrieve the data
                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                        
                        //check error
                        if error == nil && data != nil {
                            //create ui image and insert to array
                            if let image = UIImage(data: data!) {
                                
                                DispatchQueue.main.async {
                                    retrievedImages.append(image)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        // Display image
        
    }
}
    
