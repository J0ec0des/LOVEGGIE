//
//  ThirdView.swift
//  LOVEGGIE
//
//  Created by Joe Kojima on 7/24/22.
//
import SwiftUI
import FirebaseStorage
import FirebaseFirestore
import CoreLocation

struct ThirdView: View {
    
    @StateObject private var viewmodel = ThirdViewModel()
    
    @State var isPickerShowing = false
    @State var selectedImage: UIImage?
    @State var retrievedImages = [UIImage]()
    @State var name = ""
    @State var price = ""
    @State var location: CLLocation?
    @ObservedObject var locationManager = LocationManager.shared
    
    var body: some View {
        ZStack
        {
            Color ("Light-Green")
                .edgesIgnoringSafeArea(.all)
            
            //image picker stack
            if locationManager.userLocation == nil {
                LocationRequestView()
            } else {
                VStack {
                    
                    TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 250, height: 50)
                        .padding(10)
                        .font(.system(size: 20, weight: .bold))
                    
                    Divider()
                    
                    if selectedImage != nil {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                    }
                    
                    Button {
                        // show image previews
                        isPickerShowing = true
                        //print(locationManager.userLocation!)
                        location = locationManager.userLocation
                        
                        
                    } label: {
                        VStack {
                        Image("Tomato_Icon_Big")
                            .resizable()
                            .frame(width: 180, height: 180)
                            .padding(10)
                        Text("Click to Upload")
                            .multilineTextAlignment(.center)
                        }
                            
                    }
                    
                    Divider()
                    
                    
                    TextField("Price", text: $price)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .frame(width: 250, height: 50)
                        .padding(10)
                        .font(.system(size: 20, weight: .bold))
                    
                    // Upload Button
                    if selectedImage != nil {
                        Button {
                            //Upload the image
                            upload(name: name, price: price, location: location!)
                            name = ""
                            price = ""
                        } label: {
                            Text("Upload")
                        }
                        
                    }
                    
                    Divider()
                    
                    HStack {
                        //loop through images
                        ForEach(retrievedImages, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                    }
                }
                .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
                    //Image picker
                    ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
                }
            }
            
        }
        
        
    }
    
    
    func upload(name: String, price: String, location: CLLocation) {
        // image exists
        guard selectedImage != nil else {
            return
        }
        let coord = location.coordinate
        let longitude = coord.longitude //Latitude & Longitude as String
        let latitude = coord.latitude
        //print(location)
        let locationstringlong = String(format: "%f", longitude)
        let locationstringlat = String(format: "%f", latitude)
        
        // Create storage reference
        let storageRef = Storage.storage().reference()
        
        // turn image to data
        let imageData = selectedImage!.jpegData(compressionQuality: 0.0)
        guard imageData != nil else{
            return
        }
        
        // specify file path and name
        let uuid = UUID().uuidString
        let path = "posts/\(uuid).jpg"
        let fileRef = storageRef.child(path)
        // Upload data
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            // check error
            if error == nil && metadata != nil {
                // save reference to the file in firestore database
                let db = Firestore.firestore()
                db.collection("posts").document().setData(["url":path, "name":name, "price":price, "date": Date(), "uuid": uuid, "latitude": locationstringlat, "longitude": locationstringlong]) { error in
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
        
        db.collection("posts").getDocuments { snapshot, error in
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
