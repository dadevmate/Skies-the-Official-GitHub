//
//  SettingsView.swift
//  Skymie
//
//  Created by Nethan on 8/7/22.
//

import SwiftUI



struct SettingsView: View {
    @State var page = 3
    @ObservedObject var model = UserModel()
    @StateObject var network = Network()
    @ObservedObject var aboutModel = AboutModel()
    @AppStorage("username") var username = ""
    @AppStorage("person") var person = ""
    @AppStorage("savedBio") var savedBio = ""
    @AppStorage("savedFavourites") var savedFavourites = ""
    @AppStorage("savedHobbies") var savedHobbies = ""
    @AppStorage("savedMediaLink") var savedMediaLink = ""
    @AppStorage("savedProfilePic") var savedProfilePic = ""
    @State var bio = ""
    @AppStorage("newUser10") var newUser = true
    @State var favourites = ""
    @State var hobbies = ""
    @State var mediaLink = ""
    @State var failedToUpdateBio = false
    @State var aboutText = ""
    @State var aboutImageLink = ""
    @State var sureDelete = false
    @FocusState var focus:Bool
    @State var writeSomething = false
    @State var invalidLink = false
 @State var sureAbout = false
    @State var sureChangeProfilePic = false
    @State var profilePicLink = ""
    @State var sureLogOut = false
    @State var deleteText = ""
    var body: some View {
        
        
      
            ZStack {
                
                VStack {
                    NavigationView {
                        List {
                            
                            Section {
                                
                                HStack {
                                    Spacer()
                                    Button("Logout") {
                                        sureLogOut = true
                                    }
                                    .alert("Are you sure you wanna log out?", isPresented: $sureLogOut) {
                                        Button("Yes") {
                                            newUser = true
                                        }
                                        
                                        Button("No") {
                                            
                                        }
                                    }
                                    
                                    
                                }
                                HStack {
                                    Spacer()
                                    
                                    
                                    
                                    ForEach(model.list, id: \.self) { user in
                                        
                                        if user.username == username {
                                            AsyncImage(url: URL(string: "\(user.pfp)")) { image in image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 150, height: 150)
                                                    .clipShape(Circle())
                                            } placeholder: {
                                                Image(systemName: "person.fill")
                                                    .font(.system(size: 70))
                                                
                                            }
                                            
                                        }
                                    }
                                    
                                    
                                    
                                    
                                    Spacer()
                                }
                                
                                ForEach(model.list, id: \.self) { user in
                                    
                                    if user.username == username {
                                        
                                        
                                        
                                        Text("Username: \(user.username)")
                                        Text("Person: \(user.person)")
                                        Text("Bio: \(user.bio)")
                                        Text("Favourites: \(user.favourites)")
                                        Text("Hobbies: \(user.hobbies)")
                                        Text("Media Link: \(user.mediaLink)")
                                        
                                        
                                        
                                    }
                                }
                                HStack {
                                    Spacer()
                                Button("Delete your account", role: .destructive) {
                                    sureDelete = true
                                }
                                .sheet(isPresented: $sureDelete) {
                                    NavigationView {
                                        List {
                                            HStack {
                                                Spacer()
                                                Button("Dismiss") {
                                                    sureDelete = false
                                                }
                                               
                                            }
                                            HStack {
                                                Spacer()
                                                Text("Are you sure you wanna delete your account?")
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.red)
                                                    .font(.title)
                                             Spacer()
                                            }
                                            Text("We're sorry to see you leave. You can always leave feedback on the App Store if you don't like something.")
                                                .fontWeight(.ultraLight)
                                          
                                            Section {
                                                TextField("", text: $deleteText)
                                                    .focused($focus)
                                                HStack {
                                                    Spacer()
                                                    Button("Yes") {
                                                        if deleteText == username {
                                                            
                                                            for userie in model.list {
                                                                if userie.username == username {
                                                                    model.deleteData(user: userie)
                                                                    newUser = true
                                                                }
                                                            }
                                                            
                                                        }
                                                    }
                                                    Spacer()
                                                }
                                            } header: {
                                                Text("Type your username in to confirm")
                                            }
                                            
                                        }
                                        
                                        
                                    }
                                }
                                    
                            }
                            }
                            
                            Section {
                                
                                
                                
                                TextEditor(text: $bio)
                                    .focused($focus)
                                
                                HStack {
                                    Spacer()
                                    Button("Submit") {
                                        
                                        
                                        for user in model.list {
                                            
                                            if bio != "" {
                                                if user.username.contains(username) {
                                                    
                                                    model.updateData(userUpdate: user, edit: bio)
                                                    savedBio = bio
                                                    bio = ""
                                                    
                                                }
                                            }
                                        }
                                        
                                    }
                                    
                                    Spacer()
                                }
                            } header: {
                                Text("Edit your bio here")
                            }
                            
                            
                            Section {
                                Text("Tell your followers what you're up to...")
                                    .fontWeight(.bold)
                                    .font(.title2)
                            }
                            
                            Section {
                                
                                AsyncImage(url: URL(string: "\(aboutImageLink)")) { image in image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                }
                                
                                TextField("An image link (optional) (non-copyright)",text: $aboutImageLink)
                                    .focused($focus)
                                
                                
                                TextEditor(text: $aboutText)
                                    .focused($focus)
                            }  header: {
                                Text("Your about")
                            }
                            Section {
                                HStack {
                                    Spacer()
                                    Button("Post") {
                                        
                                        if username != "" {
                                            if aboutText.trimmingCharacters(in: .whitespaces) != "" {
                                                sureAbout = true
                                            } else {
                                                writeSomething = true
                                            }
                                        }
                                    }
                                    .alert("Please write something...",  isPresented: $writeSomething) {
                                        
                                    } message: {
                                        Text("Please write something in the text box below the image link before posting your about.")
                                    }
                                    .alert("Are you sure you want to post this about?",  isPresented: $sureAbout) {
                                        Button("Yes") {
                                            if username != "" {
                                                
                                                if aboutText.trimmingCharacters(in: .whitespaces) != "" {
                                                    let components = Calendar.current.dateComponents([.day, .month, .year], from: Date.now)
                                                    
                                                    let year = components.year ?? 0
                                                    let month = components.month ?? 0
                                                    let day = components.day ?? 0
                                                    let actualAbout = aboutText.trimmingCharacters(in: .whitespaces)
                                                    
                                                    for userie in model.list {
                                                        if userie.username == username {
                                                            aboutModel.addData(username: username, about: actualAbout, date: "\(day)/\(month)/\(year)", reported: false, imageURL: aboutImageLink, pfp: "\(userie.pfp)", verified: userie.verified)
                                                        }
                                                    }
                                                    aboutImageLink = ""
                                                    aboutText = ""
                                                }
                                            }
                                        }
                                        
                                        Button("No") {
                                            
                                        }
                                    } message: {
                                        Text("You will not be able to edit abouts once they're posted. Only your followers will be able to see this about. You cannot see who your followers are. All abouts are permanent and appear in your followers' social page. To follow someone, you can search their name in the social page.")
                                    }
                                    Spacer()
                                }
                                
                            }
                            
                            
                            
                            
                            
                            Section {
                                
                            } footer: {
                                Text("* Note that everyone you follow is\nsaved locally and when you delete\nthe app the people you follow\nare not saved. ")
                            }
                            
                            Section {
                                
                            } footer: {
                                Text("* You can follow yourself if you \n want to see your updates in \n the feed.")
                            }
                            Group {
                                Section {
                                    
                                    
                                    
                                    TextEditor(text: $favourites)
                                        .focused($focus)
                                    
                                    HStack {
                                        Spacer()
                                        Button("Submit") {
                                            
                                            
                                            for user in model.list {
                                                
                                                if favourites != "" {
                                                    if user.username.contains(username) {
                                                        
                                                        model.updateFavourites(userUpdate: user, edit: favourites)
                                                        savedFavourites = favourites
                                                        favourites = ""
                                                        
                                                    }
                                                }
                                            }
                                            
                                        }
                                        
                                        Spacer()
                                    }
                                } header: {
                                    Text("Edit your Favourites here")
                                }
                                
                                Section {
                                    
                                    
                                    
                                    TextEditor(text: $hobbies)
                                        .focused($focus)
                                    
                                    HStack {
                                        Spacer()
                                        Button("Submit") {
                                            
                                            
                                            for user in model.list {
                                                
                                                if hobbies != "" {
                                                    if user.username.contains(username) {
                                                        
                                                        model.updateHobbies(userUpdate: user, edit: hobbies)
                                                        savedHobbies = hobbies
                                                        hobbies = ""
                                                        
                                                    }
                                                }
                                            }
                                            
                                        }
                                        
                                        Spacer()
                                    }
                                } header: {
                                    Text("Edit your Hobbies here")
                                }
                                
                                Section {
                                    
                                    
                                    
                                    TextEditor(text: $mediaLink)
                                        .focused($focus)
                                    
                                    HStack {
                                        Spacer()
                                        Button("Submit") {
                                            
                                            
                                            for user in model.list {
                                                
                                                if mediaLink != "" {
                                                    
                                                    
                                                    if user.username.contains(username) {
                                                        
                                                        model.updateMediaLink(userUpdate: user, edit: mediaLink)
                                                        savedMediaLink = mediaLink
                                                        mediaLink = ""
                                                        
                                                    }
                                                    
                                                }
                                            }
                                            
                                        }
                                        .alert("Invalid link", isPresented: $invalidLink) {
                                            
                                        }
                                        
                                        Spacer()
                                    }
                                } header: {
                                    Text("Edit your Media Link here")
                                }
                            }
                            
                            Section {
                                AsyncImage(url: URL(string: "\(profilePicLink)")) { image in image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                }
                                
                                TextField("An image link (non-copyright)",text: $profilePicLink)
                                    .focused($focus)
                                
                                
                                HStack {
                                    Spacer()
                                    Button("Submit") {
                                        
                                        sureChangeProfilePic = true
                                        
                                    }
                                    .confirmationDialog("Change profile picture?", isPresented: $sureChangeProfilePic) {
                                        Button("Yes", role: .destructive) {
                                            
                                            for user in model.list {
                                                if profilePicLink != "" {
                                                    model.updatePfp(userUpdate: user, edit: profilePicLink)
                                                    savedProfilePic = profilePicLink
                                                    profilePicLink = ""
                                                }
                                            }
                                        }
                                        
                                        Button("No") {
                                            
                                        }
                                    } message: {
                                        Text("Are you sure about this? Everyone on Skies will be able to see this profile picture.")
                                    }
                                    Spacer()
                                }
                            } header: {
                                Text("Edit profile picture")
                            } footer: {
                                Text("* Profile picture will be adjusted to 150 by 150 size.\n   It will be cropped to a circular shape.")
                            }
                            
                            
                            
                            Section {
                                Section {
                                    NavigationLink {
                                        
                                    } label: {
                                        Text("Terms of Service")
                                    }
                                }
                                Section {
                                    NavigationLink {
                                        
                                    } label: {
                                        Text("Privacy Policy")
                                    }
                                }
                            } header: {
                                Text("Some information")
                            }
                            
                            
                        }
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                Button("Done") {
                                    focus = false
                                    
                                }
                                .foregroundColor(.blue)
                            }
                            
                            
                        }
                        .navigationTitle("Settings")
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
                    }
                    .navigationViewStyle(.stack)
                }
                
            }
 

    }
    
    init() { // On this initialisation of this view, we get the data
        model.getData()
        aboutModel.getData()
        
        for userie in model.list {
            
            if userie.username == username {
                username = userie.username
                person = userie.person
                savedBio = userie.bio
                savedFavourites = userie.favourites
                savedHobbies = userie.hobbies
                savedProfilePic = userie.pfp
                savedMediaLink = userie.mediaLink
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
