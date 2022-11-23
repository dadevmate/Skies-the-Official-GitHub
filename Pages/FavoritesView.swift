//
//  FavoritesView.swift
//  Skymie
//
//  Created by Nethan on 8/7/22.
//

import SwiftUI

struct FavoritesView: View {
    @State var page = 1
    @StateObject var network = Network()
    @ObservedObject var model = UserModel()
    @State var openComm = false
    @AppStorage("username") var username = ""
    @State var notAllowed = false
    @ObservedObject var commModel = CommModel()
    @State private var favComms: [String] = UserDefaults.standard.object(forKey: "favComms") as? [String] ?? []
    @State var comm1 = CommData(id: "", name: "", pic: "", about: "", restricted: "", fiveWords: "", reported: false)
    @State var comm2 = CommData(id: "", name: "", pic: "", about: "", restricted: "", fiveWords: "", reported: false)
    @State var comm3 = CommData(id: "", name: "", pic: "", about: "", restricted: "", fiveWords: "", reported: false)
    @State var comm4 = CommData(id: "", name: "", pic: "", about: "", restricted: "", fiveWords: "", reported: false)
    @State var comm5 = CommData(id: "", name: "", pic: "", about: "", restricted: "", fiveWords: "", reported: false)
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timeRemaining = 300
    var body: some View {
    
    
            
            VStack {
                NavigationView {
                    
                    VStack {
                        List(favComms, id: \.self) { fav in
                            
                            ForEach(commModel.list) { community in
                                if community.name == fav {
                                    
                                    Section {
                                        HStack {
                                            
                                            Button {
                                                
                                                for userie in model.list {
                                                    
                                                    if userie.username == username {
                                                        
                                                        if community.restricted == "18 and above" && userie.person == "teenager" {
                                                            notAllowed = true
                                                        } else {
                                                            
                                                            
                                                        }
                                                    }
                                                }
                                            } label: {
                                                HStack {
                                                    
                                                    AsyncImage(url: URL(string: "\(community.pic)")) { image in image
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
                                                        Text("\(community.name)")
                                                            .foregroundColor(Color.primary)
                                                            .fontWeight(.bold)
                                                            .font(.title)
                                                        Spacer()
                                                        Text("\(community.fiveWords)")
                                                            .foregroundColor(Color.primary)
                                                            .fontWeight(.light)
                                                        
                                                        Spacer()
                                                    }
                                                    
                                                    Spacer()
                                                    Spacer()
                                                    
                                                    if community.restricted == "18 and above" {
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
                                            .navigationTitle("Favourites")
                                            
                                            
                                        }
                                        
                                    }
                                    .navigationViewStyle(.stack)
                                    
                                }
                            }
                            
                        }
                        .navigationTitle("Favourites")
                        .onAppear {
                            network.checkConnection()
                        }
                        .refreshable {
                            network.checkConnection()
                            model.getData()
                            commModel.getData()
                        }
                        .onReceive(network.$connected, perform: { connected in
                            
                            print(connected)
                        })
                        
                        List {
                            
                            Section {
                                Text("Discover")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                            } footer: {
                                Text("5 communities randomly appear randomly. If you like one, go search it up and talk!")
                            }
                            
                            Section {
                                HStack {
                                    
                                    Button {
                                        
                                   
                                    } label: {
                                        HStack {
                                            
                                            AsyncImage(url: URL(string: "\(comm1.pic)")) { image in image
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
                                                Text("\(comm1.name)")
                                                    .foregroundColor(Color.primary)
                                                    .fontWeight(.bold)
                                                    .font(.title)
                                                Spacer()
                                                Text("\(comm1.fiveWords)")
                                                    .foregroundColor(Color.primary)
                                                    .fontWeight(.light)
                                                
                                                Spacer()
                                            }
                                            
                                            Spacer()
                                            Spacer()
                                            
                                            if comm1.restricted == "18 and above" {
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
                                    .navigationTitle("Favourites")
                                    
                                    
                                }
                                
                            }
                            .navigationViewStyle(.stack)
                            
                            Section {
                                HStack {
                                    
                                    Button {
                                        
                                        for userie in model.list {
                                            
                                            if userie.username == username {
                                                
                                                if comm2.restricted == "18 and above" && userie.person == "teenager" {
                                                    notAllowed = true
                                                } else {
                                                    
                                                    
                                                }
                                            }
                                        }
                                    } label: {
                                        HStack {
                                            
                                            AsyncImage(url: URL(string: "\(comm2.pic)")) { image in image
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
                                                Text("\(comm2.name)")
                                                    .foregroundColor(Color.primary)
                                                    .fontWeight(.bold)
                                                    .font(.title)
                                                Spacer()
                                                Text("\(comm2.fiveWords)")
                                                    .foregroundColor(Color.primary)
                                                    .fontWeight(.light)
                                                
                                                Spacer()
                                            }
                                            
                                            Spacer()
                                            Spacer()
                                            
                                            if comm2.restricted == "18 and above" {
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
                                    .navigationTitle("Favourites")
                                    
                                    
                                }
                                
                            }
                            .navigationViewStyle(.stack)
                            
                            Section {
                                HStack {
                                    
                                    Button {
                                        
                                        for userie in model.list {
                                            
                                            if userie.username == username {
                                                
                                                if comm3.restricted == "18 and above" && userie.person == "teenager" {
                                                    notAllowed = true
                                                } else {
                                                    
                                                    
                                                }
                                            }
                                        }
                                    } label: {
                                        HStack {
                                            
                                            AsyncImage(url: URL(string: "\(comm3.pic)")) { image in image
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
                                                Text("\(comm3.name)")
                                                    .foregroundColor(Color.primary)
                                                    .fontWeight(.bold)
                                                    .font(.title)
                                                Spacer()
                                                Text("\(comm3.fiveWords)")
                                                    .foregroundColor(Color.primary)
                                                    .fontWeight(.light)
                                                
                                                Spacer()
                                            }
                                            
                                            Spacer()
                                            Spacer()
                                            
                                            if comm3.restricted == "18 and above" {
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
                                    .navigationTitle("Favourites")
                                    
                                    
                                }
                                
                            }
                            .navigationViewStyle(.stack)
                            
                            
                            Section {
                                HStack {
                                    
                                    Button {
                                        
                                        for userie in model.list {
                                            
                                            if userie.username == username {
                                                
                                                if comm4.restricted == "18 and above" && userie.person == "teenager" {
                                                    notAllowed = true
                                                } else {
                                                    
                                                    
                                                }
                                            }
                                        }
                                    } label: {
                                        HStack {
                                            
                                            AsyncImage(url: URL(string: "\(comm4.pic)")) { image in image
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
                                                Text("\(comm4.name)")
                                                    .foregroundColor(Color.primary)
                                                    .fontWeight(.bold)
                                                    .font(.title)
                                                Spacer()
                                                Text("\(comm4.fiveWords)")
                                                    .foregroundColor(Color.primary)
                                                    .fontWeight(.light)
                                                
                                                Spacer()
                                            }
                                            
                                            Spacer()
                                            Spacer()
                                            
                                            if comm4.restricted == "18 and above" {
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
                                    .navigationTitle("Favourites")
                                    
                                    
                                }
                                
                            }
                            .navigationViewStyle(.stack)
                            
                            Section {
                                HStack {
                                    
                                    Button {
                                        
                                        for userie in model.list {
                                            
                                            if userie.username == username {
                                                
                                                if comm5.restricted == "18 and above" && userie.person == "teenager" {
                                                    notAllowed = true
                                                } else {
                                                    
                                                    
                                                }
                                            }
                                        }
                                    } label: {
                                        HStack {
                                            
                                            AsyncImage(url: URL(string: "\(comm5.pic)")) { image in image
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
                                                Text("\(comm5.name)")
                                                    .foregroundColor(Color.primary)
                                                    .fontWeight(.bold)
                                                    .font(.title)
                                                Spacer()
                                                Text("\(comm5.fiveWords)")
                                                    .foregroundColor(Color.primary)
                                                    .fontWeight(.light)
                                                
                                                Spacer()
                                            }
                                            
                                            Spacer()
                                            Spacer()
                                            
                                            if comm5.restricted == "18 and above" {
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
                                    .navigationTitle("Favourites")
                                    
                                    
                                }
                                
                            }
                            .navigationViewStyle(.stack)
                        }
                        .onReceive(timer) { time in
                            
                            if commModel.list.count >= 5 {
                                
                                comm1 = commModel.list.randomElement() ?? CommData(id: "", name: "", pic: "", about: "", restricted: "", fiveWords: "", reported: false)
                                
                                
                                comm2 = commModel.list.randomElement() ?? CommData(id: "", name: "", pic: "", about: "", restricted: "", fiveWords: "", reported: false)
                                comm3 = commModel.list.randomElement() ?? CommData(id: "", name: "", pic: "", about: "", restricted: "", fiveWords: "", reported: false)
                                comm4 = commModel.list.randomElement() ?? CommData(id: "", name: "", pic: "", about: "", restricted: "", fiveWords: "", reported: false)
                                comm5 = commModel.list.randomElement() ?? CommData(id: "", name: "", pic: "", about: "", restricted: "", fiveWords: "", reported: false)
                                
                          
                            }
                            timeRemaining = 300
                        }

                       
                    }
                   
                }
                .navigationViewStyle(.stack)
                
                
                
            }
        
      


   
    }
    
    init() { // On this initialisation of this view, we get the data
        model.getData()
        commModel.getData()
  
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
