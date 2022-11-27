//
//  NavBar.swift
//  Skymie
//
//  Created by Nethan on 15/7/22.
//

import SwiftUI

struct NavBar: View {
    @StateObject var network = Network()
    @State var fullyConnected = true

    var body: some View {
        
        if fullyConnected == true  {
           
        
            VStack {
                Button("Connect to WIFI") {
                    network.checkConnection()
                    fullyConnected = false
                }
            }
            .alert("Welcome to Skies!", isPresented: $fullyConnected) {
                Button("Let's go") {
                    network.checkConnection()
                    fullyConnected = false
                }
            } message: {
                Text("We're glad to see you!")
            }
            
        } else {
            
            if network.connected == true {
                
                TabView {
                    
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    if network.connected == true {
                        SocialView()
                            .tabItem {
                                Label("Social", systemImage: "person.3")
                            }
                        
                        SkiesPlusView(subModel: SubscriptionModel(), subModelTwo: SubscriptionModelTwo())
                            .tabItem {
                                Label("Skies+", systemImage: "s.circle.fill")
                            }
                        
                        FavoritesView()
                            .tabItem {
                                Label("Favourites", systemImage: "star")
                            }
                        SettingsView()
                            .tabItem {
                                Label("Settings", systemImage: "gear.circle")
                            }
                    }
                }
                
                .onAppear {
                    
                    network.checkConnection()
                    
                }
                .onReceive(network.$connected, perform: { connected in
                  
                    print(connected)
                })
            } else {
                NoConnectionView()
            }
        }
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
    }
}
