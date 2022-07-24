//
//  LocationRequestView.swift
//  LOVEGGIE
//
//  Created by Reo Saito on 2022/07/24.
//

import SwiftUI

struct LocationRequestView: View {
    var body: some View {
        ZStack {
            Color(.systemBlue).ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Image(systemName: "paperplane.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 32)
                
                Text("Would you like to explore VEGGIES nearby?")
                    .font(.system(size: 28, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("Start sharing your location with LOVEGGIE!")
                    .multilineTextAlignment(.center)
                    .frame(width: 200)
                    .padding()
                
                Spacer()
                
                VStack {
                    Button {
                        LocationManager.shared.requestLocation()
                    } label: {
                        Text("Allow location")
                            .padding()
                            .font(.headline)
                            .foregroundColor(Color(.systemBlue))
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.horizontal, -32)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .padding()
                    
                    //Maybe later button, but we don't want anyone to press that
                    /*Button {
                        print("Dismiss")
                    } label: {
                        Text("Maybe later:")
                            .padding()
                            .font(.headline)
                            .foregroundColor(.white)
                    }*/
                }
                .padding(.bottom, 32)
            }
            .foregroundColor(.white)
        }
    }
}

struct LocationRequestView_Previews: PreviewProvider {
    static var previews: some View {
        LocationRequestView()
    }
}
