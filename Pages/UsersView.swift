//
//  UsersView.swift
//  Skymie
//
//  Created by Nethan on 9/7/22.
//

import SwiftUI


struct UsersView: View {
    @State var back  = false
    @ObservedObject var model = UserModel()
@State var sureFollow = false
    @StateObject var network = Network()
    @State private var followers: [String] = UserDefaults.standard.object(forKey: "followers") as? [String] ?? []
    @State var alreadyFollow = false
    var body: some View {
      
            if back == true {
                SocialView()
            } else {
                
                VStack {
                    NavigationView {
                        
                        
                        List {
                            ForEach(usersFound, id: \.self) { username in
                                
                                
                                
                                Section {
                                    
                                    HStack {
                                        Spacer()
                                        Button {
                                            
                                            
                                            sureFollow = true
                                            
                                        } label: {
                                            VStack {
                                                HStack {
                                                    
                                                    Image(systemName: "person.fill")
                                                        .font(.title)
                                                    
                                                    Text("\(username)")
                                                    Spacer()
                                                }
                                                
                                            }
                                        }
                                        .confirmationDialog("Are you sure about this?", isPresented: $sureFollow, titleVisibility: .visible) {
                                            
                                            if followers.contains(username) != true {
                                                
                                                Button("Yes, I wanna follow") {
                                                    
                                                    
                                                    
                                                    if followers.contains(username) {
                                                        
                                                    } else {
                                                        followers.append(username)
                                                        UserDefaults.standard.set(followers, forKey: "followers")
                                                        print(followers)
                                                    }
                                                    
                                                    
                                                }
                                            } else if followers.contains(username) {
                                                
                                                Button("Unfollow") {
                                                    if followers.contains(username) {
                                                        alreadyFollow = true
                                                        
                                                    }
                                                }
                                            }
                                     
                                            
                                            
                                        } message: {
                                            
                                            if followers.contains(username) != true {
                                                
                                                Text("You'll be able to keep up with them more easily. You'll receive exclusive updates from them that are only visible to people who follow them. You can see those updates from the Socialise page.")
                                            } else if followers.contains(username) {
                                                
                                                Text("You will no longer receive exclusive updates from this user. About posts from this user will not show up in your special feed.")
                                            }
                                            
                                        }
                                        .confirmationDialog("Unfollow this user?", isPresented: $alreadyFollow, titleVisibility: .visible) {
                                            
                                            Button("Yes, unfollow!") {
                                                followers.removeAll { follower in
                                                    return follower == username
                                                }
                                                print("SUCCCCESSSSS")
                                                print(followers)
                                            }
                                            
                                        } message: {
                                            Text("You'll no longer receive exclusive updates from this user if you unfollow them.")
                                        }
                                        Spacer()
                                        Button {
                                            
                                        } label: {
                                            Text("")
                                        }
                                        Spacer()
                                    }
                                    
                                } footer: {
                                    Text("Click above to follow/unfollow")
                                }
                                
                                BannerAd(unitId: "ca-app-pub-6142532326654511/4548690533")
                                    .frame(width: 300, height: 50)
                                
                                
                            }
                            
                            
                        }
                        .onAppear {
                            network.checkConnection()
                        }
                        .refreshable {
                            network.checkConnection()
                            model.getData()
                        }
                        .onReceive(network.$connected, perform: { connected in
                          
                            print(connected)
                        })
                        .navigationTitle("Users")
               
                    }
                    .navigationViewStyle(.stack)
                }
            }
      
}
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}

