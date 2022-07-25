//
//  SecondView.swift
//  LOVEGGIE
//
//  Created by Joe Kojima on 7/24/22.
//
import Foundation
import SwiftUI
import FirebaseFirestore

struct SecondView: View
{
    //@ObservedObject var data = getData()
    var body: some View
    {
        ZStack
        {
            Color.white.ignoresSafeArea(edges: .top)
            Text("Coming Soon!")
        }
//        ZStack
//        {
//            Color.white.ignoresSafeArea(edges: .top)
//        }
//
//        NavigationView{
//
//            ZStack(alignment: .top){
//
//                GeometryReader{_ in
//
//                    // Home View....
//                    Text("Home").padding(.top)
//
//                }.background(Color("Color").edgesIgnoringSafeArea(.all))
//
//                //CustomSearchBar(data: self.$data.datas).padding(.top)
//
//            }.navigationBarTitle("")
//                .navigationBarHidden(true)
//        }.padding(.top)
    }
}

struct CustomSearchBar : View {

    @State var txt = ""
    @Binding var data : [dataType]

    var body : some View{

        VStack(spacing: 0){

            HStack{

                TextField("Search", text: self.$txt)

                if self.txt != ""{

                    Button(action: {

                        self.txt = ""

                    }) {

                        Text("Cancel")
                    }
                    .foregroundColor(.black)

                }

            }.padding()

            if self.txt != ""{

                if  self.data.filter({$0.name.lowercased().contains(self.txt.lowercased())}).count == 0{

                    Text("No Results Found").foregroundColor(Color.black.opacity(0.5)).padding()
                }
                else{

                List(self.data.filter{$0.name.lowercased().contains(self.txt.lowercased())}){i in

                    NavigationLink(destination: Detail(data: i)) {

                        Text(i.name)
                    }


                    }.frame(height: UIScreen.main.bounds.height / 5)
                }

            }


        }.background(Color.white)
        .padding()
    }
}
class getData : ObservableObject{

    @Published var datas = [dataType]()

    init() {

        let db = Firestore.firestore()

        db.collection("items").getDocuments { (snap, err) in

            if err != nil{

                print((err?.localizedDescription)!)
                return
            }

            for i in snap!.documents{

                let id = i.documentID
                let name = i.get("name") as! String
                let price = i.get("price") as! String

                self.datas.append(dataType(id: id, name: name, price: price))
            }
        }
    }
}

struct dataType : Identifiable {

    var id : String
    var name : String
    var price : String
}

struct Detail : View {

    var data : dataType

    var body : some View{

        Text(data.price)
    }
}
