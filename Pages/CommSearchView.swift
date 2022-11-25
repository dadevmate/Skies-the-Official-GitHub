//
//  CommSearchView.swift
//  Skymie
//
//  Created by Nethan on 22/11/22.
//

import SwiftUI

struct CommSearchView: View {
    @ObservedObject var model = UserModel()
    @AppStorage("username") var username = ""
    @AppStorage("person") var person = ""
    @State var openComm = false
    @State var notAllowed = false
    var body: some View {
        
        if openComm == false {
            NavigationView {
                
                List(commFound) { comm in
                    Section {
                        
                        
                        Button {
                
                      
                                   
                                    if comm.restricted == "18 and above" && person == "teenager" {
                                        notAllowed = true
                                    } else {
                                      
                                        thisComm = comm
                                        openComm = true
                                    }
                             
                        } label: {
                            HStack {
                                
                                AsyncImage(url: URL(string: "\(comm.pic)")) { image in image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                }
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                
                                Spacer()
                                
                                VStack {
                                    Spacer()
                                    Text("\(comm.name)")
                                        .foregroundColor(Color.primary)
                                        .fontWeight(.bold)
                                        .font(.title)
                                    Spacer()
                                    Text("\(comm.fiveWords)")
                                        .foregroundColor(Color.primary)
                                        .fontWeight(.light)
                                    
                                    Spacer()
                                }
                                
                                Spacer()
                                Spacer()
                                
                                if comm.restricted == "18 and above" {
                                    VStack {
                                        Image(systemName: "person.text.rectangle.fill")
                                            .foregroundColor(.red)
                                        Spacer()
                                    }
                                }
                                
                                Spacer()
                            }
                        }
                        .confirmationDialog("You're not old enough", isPresented: $notAllowed, titleVisibility: .visible) {
                            
                        } message: {
                            Text("This community was meant for people 18 and above. You're not old enough to talk inside it, yet.")
                        }
                        .navigationTitle("Communities")
                        
                        
                        
                        
                    }
                    BannerAd(unitId: "ca-app-pub-6142532326654511/4548690533")
                }
                .navigationTitle("Communities")
            }
        } else {
            MessageViewTwo()
        }
    }
}

struct CommSearchView_Previews: PreviewProvider {
    static var previews: some View {
        CommSearchView()
    }
}
