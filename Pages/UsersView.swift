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
    @State private var followers: [String] = UserDefaults.standard.object(forKey: "followers") as? [String] ?? [""]
    @State var alreadyFollow = false
    @State private var blocked: [String] = UserDefaults.standard.object(forKey: "blocked") as? [String] ?? [""]
@State var blockSuccess = false
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
                                            
                                            if followers.contains(username) != true {
                                                sureFollow = true
                                            } else if followers.contains(username) {
                                                alreadyFollow = true
                                            }
                                            
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
                                            
                       
                                                
                                                Button("Yes, I wanna follow") {
                                                    
                                                    
                                                    
                                                
                                                        followers.append(username)
                                                        UserDefaults.standard.set(followers, forKey: "followers")
                                                        print("FOLLOWING: \(followers)")
                                                    
                                                    
                                                    
                                                }
                          
                                                
                                        
                                            Button("Block/Unblock user") {
                                                
                                                if blocked.contains(username) == false {
                                                    blocked.append(username)
                                                    UserDefaults.standard.set(blocked, forKey: "blocked")
                                                    blockSuccess = true
                                                    print(blocked)
                                                } else {
                                                    blocked = blocked.filter {$0 != username}
                                                    UserDefaults.standard.set(blocked, forKey: "blocked")
                                                    blockSuccess = true
                                                    print(blocked)
                                                }
                                                
                                            }
                                     
                                            
                                            
                                        } message: {
                                            
                      
                                                
                                                Text("You'll be able to keep up with them more easily. You'll receive exclusive updates from them that are only visible to people who follow them. You can see those updates from the Socialise page.")
                                    
                             
                                            
                                            
                                        }
                                        .alert("Success!", isPresented: $blockSuccess) {
                                            
                                        } message: {
                                            
                                            if blocked.contains(username) == true {
                                                Text("This user has been successfully blocked. You will no longer receive posts, comments, about posts and videos from this user. Please restart the app for changes to take effect.")
                                            } else {
                                                Text("This user has been successfully unblocked. Please restart the app for changes to take effect.")
                                            }
                                        }
                                        .confirmationDialog("Are you sure about this?", isPresented: $alreadyFollow, titleVisibility: .visible) {
                                            Button("Unfollow") {
                                             
                                                    followers.removeAll { follower in
                                                        return follower == username
                                                    }
                                                    UserDefaults.standard.set(followers, forKey: "followers")
                                                print("UNFOLLOWING: \(followers)")
                                                
                                            }
                                            
                                            Button("Block/Unblock user") {
                                                
                                                if blocked.contains(username) == false {
                                                    blocked.append(username)
                                                    UserDefaults.standard.set(blocked, forKey: "blocked")
                                                    blockSuccess = true
                                                    print(blocked)
                                                } else {
                                                    blocked = blocked.filter {$0 != username}
                                                    UserDefaults.standard.set(blocked, forKey: "blocked")
                                                    blockSuccess = true
                                                    print(blocked)
                                                }
                                            }
                                        } message: {
                                            
                                            Text("You will no longer receive exclusive updates from this user. About posts from this user will not show up in your special feed.")
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

