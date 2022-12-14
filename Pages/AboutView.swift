//
//  AboutView.swift
//  Skymie
//
//  Created by Nethan on 8/10/22.
//

import SwiftUI

struct AboutView: View {
    @ObservedObject var aboutModel = AboutModel()
    @State private var followers: [String] = UserDefaults.standard.object(forKey: "followers") as? [String] ?? [""]
@State var sureReport = false
    @StateObject var network = Network()
    @State var cannotDelete = false
    @ObservedObject var model = UserModel()
    @AppStorage("username") var username = ""
    @AppStorage("subscription") var subscription = ""
    @State private var blocked: [String] = UserDefaults.standard.object(forKey: "blocked") as? [String] ?? [""]
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var myArr = [AboutData(id: "", username: "", about: "", date: "", imageURL: "", reported: false, pfp: "", verified: false, subscription: "none", timestamp: 0)]
    @State var timeRemaining = 3
    var body: some View {
    
            ZStack {
                VStack {
                    Text("    ↓ Swipe down to load more abouts ↓")
                    Spacer()
                    Text("Restart app for the people you're following to update!\nPeople you're following are deleted when you delete the app.")
                        .foregroundColor(.gray)
                        .font(.caption)
                    
                    NavigationView {
                        
                        List(myArr) { about in
                            
                            // Notes for tomorrow
                            
                            if blocked.contains(where: {$0.contains(about.username)}) == false {
                                
                                
                                if followers.contains(where: {$0.contains(about.username)}) { // I'm trying to map through an array called followers and if it contains about.username, this View will be generated. It is inside another List that's mapping through an array called aboutModel.list
                                
                                
                                Section {
                                    
                                    HStack {
                                        
                                        
                                        if about.pfp == "Man" {
                                            Image("Man1")
                                            
                                            
                                                .clipShape(Circle())
                                            
                                            
                                        } else if about.pfp == "Alien" {
                                            Image("Alien1")
                                            
                                                .clipShape(Circle())
                                            
                                            
                                            
                                        } else if about.pfp == "Skeleton" {
                                            Image("Skeleton1")
                                            
                                            
                                                .clipShape(Circle())
                                            
                                        } else if about.pfp == "Robot" {
                                            Image("Robot1")
                                            
                                                .clipShape(Circle())
                                            
                                        } else {
                                            AsyncImage(url: URL(string: "\(about.pfp)")) { image in image
                                                    .resizable()
                                                    .scaledToFit()
                                            } placeholder: {
                                                
                                                if about.pfp != "" {
                                                    ProgressView()
                                                        .progressViewStyle(.circular)
                                                }
                                            }
                                            
                                            .clipShape(Circle())
                                        }
                                        
                                        
                                        Text("\(about.username)")
                                            .fontWeight(.bold)
                                        if about.verified == true {
                                            Image(systemName: "checkmark.seal.fill")
                                                .foregroundColor(.blue)
                                        }
                                        
                                        if about.subscription != "none" {
                                            Image(systemName: "ticket.fill")
                                                .foregroundColor(.purple)
                                        }
                                        
                                        Spacer()
                                        Text("\(about.date)")
                                            .fontWeight(.ultraLight)
                                    }
                                    if let u = URL(string: about.imageURL) {
                                        AsyncImage(url: URL(string: "\(about.imageURL)") ?? URL(string: "https://cataas.com/c")) { image in image
                                                .resizable()
                                                .scaledToFit()
                                        } placeholder: {
                                            ProgressView()
                                                .progressViewStyle(.circular)
                                        }
                                    }
                                    
                                    Text("\(about.about)")
                                    
                                    Button {
                                        
                                        if username != "" {
                                            sureReport = true
                                        }
                                    } label: {
                                        Image(systemName: "exclamationmark.triangle.fill")
                                            .foregroundColor(.red)
                                            .font(.title2)
                                    }
                                    .alert("Do you want to report this about?", isPresented: $sureReport) {
                                        
                                        Button("Yes", role: .destructive) {
                                            aboutModel.report(aboutToUnreport: about, reportStatus: true)
                                        }
                                        
                                    } message: {
                                        Text("You are about to report this about. Only report it if you think it does not follow our rules and guidelines, which are written in our Terms and conditions. Some reasons include spam, swearing, sexual content etc.")
                                    }
                                    
                                    if about.username.lowercased() == username.lowercased() {
                                        Button {
                                            if username.lowercased() == about.username.lowercased() {
                                                aboutModel.deleteData(aboutToDelete: about)
                                            } else if username == "Mister365b" || username == "mister365b" {
                                                aboutModel.deleteData(aboutToDelete: about)
                                            } else {
                                                cannotDelete = true
                                            }
                                        } label: {
                                            Image(systemName: "trash.fill")
                                                .font(.title2)
                                        }
                                        .alert("Unable to delete", isPresented: $cannotDelete) {
                                            
                                        } message: {
                                            Text("You can't delete this about because you didn't create it.")
                                        }
                                    }
                                }
                                BannerAd(unitId: "ca-app-pub-6142532326654511/4548690533")
                                    .frame(width: 300, height: 300)
                                
                            }
                        }
                            
                        }
                        .onAppear {
                            network.checkConnection()
                        }
                        .refreshable {
                            network.checkConnection()
                            aboutModel.getData()
                        }
                        .onReceive(network.$connected, perform: { connected in
                          
                            print(connected)
                        })
                        .onReceive(timer) { time in
                            
                            myArr = aboutModel.list.sorted { var1, var2 in
                                 
                                 var1.timestamp > var2.timestamp
                                 
                             }
                            timeRemaining = 3
                        }
                        .navigationTitle("Abouts")
                    }
                }
            }
            .navigationViewStyle(.stack)
    }
    
    init() {
        aboutModel.getData()
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
