//
//  SettingsView.swift
//  Skymie
//
//  Created by Nethan on 8/7/22.
//

import SwiftUI



struct SettingsView: View {
    @State var page = 3
    @ObservedObject var commModel = CommModel()
    @ObservedObject var messageModel = MessageModel()
    @ObservedObject var postsModel = PostsModel()
    @ObservedObject var model = UserModel()
    @StateObject var network = Network()
    @ObservedObject var commentsModel = CommentsModel()
    @ObservedObject var aboutModel = AboutModel()
    @ObservedObject var delUserModel = DeletedUserModel()
    @AppStorage("username") var username = ""
    @AppStorage("person") var person = ""
    @AppStorage("savedBio") var savedBio = ""
    @AppStorage("savedFavourites") var savedFavourites = ""
    @AppStorage("savedHobbies") var savedHobbies = ""
    @AppStorage("savedMediaLink") var savedMediaLink = ""
    @AppStorage("savedProfilePic") var savedProfilePic = ""
    @AppStorage("subscription") var subscription = ""
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
    @State var premiumProfile = false
    var body: some View {
        
        
      
            ZStack {
                
                VStack {
                    NavigationView {
                        List {
                            
                            Section {
                          
                         
                                    HStack {
                                        Spacer()
                                        
                                        
                                        
                                     
                                            Button("Skies Avatars") {
                                                premiumProfile = true
                                            }
                                            .foregroundColor(.purple)
                                            .sheet(isPresented: $premiumProfile) {
                                                NavigationView {
                                                   
                                                    List(model.list) { user in
                                                        if user.username.lowercased() == username.lowercased() {
                                                      
                                                            Section {
                                                                HStack {
                                                                    Spacer()
                                                                    Button {
                                                                        model.updatePfp(userUpdate: user, edit: "Man")
                                                                        savedProfilePic = "Man"
                                                                        premiumProfile = false
                                                                    } label: {
                                                                        Image("Man")
                                                                            .clipShape(Circle())
                                                                    }
                                                                    Spacer()
                                                                }
                                                            }
                                                            
                                                            Section {
                                                                HStack {
                                                                    Spacer()
                                                                    Button {
                                                                        model.updatePfp(userUpdate: user, edit: "Robot")
                                                                        savedProfilePic = "Robot"
                                                                        premiumProfile = false
                                                                    } label: {
                                                                        
                                                                        
                                                                        Image("Robot")
                                                                            .clipShape(Circle())
                                                                    }
                                                                    Spacer()
                                                                }
                                                            }
                                                            
                                                            Section {
                                                                HStack {
                                                                    Spacer()
                                                                    Button {
                                                                        model.updatePfp(userUpdate: user, edit: "Alien")
                                                                        savedProfilePic = "Alien"
                                                                        premiumProfile = false
                                                                    } label: {
                                                                        Image("Alien")
                                                                            .clipShape(Circle())
                                                                    }
                                                                    Spacer()
                                                                }
                                                            }
                                                            
                                                            Section {
                                                                HStack {
                                                                    Spacer()
                                                                    Button {
                                                                        model.updatePfp(userUpdate: user, edit: "Skeleton")
                                                                        savedProfilePic = "Skeleton"
                                                                        premiumProfile = false
                                                                    } label: {
                                                                        Image("Skeleton")
                                                                            .clipShape(Circle())
                                                                    }
                                                                    Spacer()
                                                                }
                                                            }
                                                            HStack {
                                                                Spacer()
                                                                Text("Screenshotting and redistributing this content\nwill result in instant termination of account.\nYou have been warned.")
                                                                    .fontWeight(.ultraLight)
                                                                    .font(.caption)
                                                                Spacer()
                                                            }
                                                        }
                                                 
                                                   
                                                        
                                                    }
                                                    .navigationTitle("Avatars")
                                                 
                                                }
                                            }
                                           
                                            
                                            
                                        }
                                    
                                
                                HStack {
                                    Spacer()
                                    
                                  
                                    Button("Log out") {
                                        sureLogOut = true
                                    }
                                    .alert("Are you sure you wanna log out?", isPresented: $sureLogOut) {
                                        Button("Yes") {
                                           
                                            username = ""
                                            person = ""
                                            savedBio = ""
                                            savedFavourites = ""
                                            savedHobbies = ""
                                            savedMediaLink = ""
                                            savedProfilePic = ""
                                          
                                            newUser = true
                                            subscription = "none"
                                        
                                        }
                                        
                                        Button("No") {
                                            
                                        }
                                    }
                                    
                                    
                                }
                                HStack {
                                    Spacer()
                                    
                                    
                                    
                                    ForEach(model.list, id: \.self) { user in
                                        
                                        if user.username.lowercased() == username.lowercased() {
                                            
                                            if user.pfp == "Man" {
                                                Image("Man")
                                                    .clipShape(Circle())
                                            } else if user.pfp == "Alien" {
                                                Image("Alien")
                                                    .clipShape(Circle())
                                                
                                                
                                            } else if user.pfp == "Skeleton" {
                                                Image("Skeleton")
                                                    .clipShape(Circle())
                                            } else if user.pfp == "Robot" {
                                                Image("Robot")
                                                    .clipShape(Circle())
                                            } else {
                                                AsyncImage(url: URL(string: "\(user.pfp)")) { image in image
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 150, height: 150)
                                                        .clipShape(Circle())
                                                } placeholder: {
                                                    Image(systemName: "person.crop.circle")
                                                        .font(.system(size: 90))
                                                    
                                                }
                                            }
                                        }
                                    }
                                    
                                    
                                    
                                    
                                    Spacer()
                                }
                                
                                ForEach(model.list, id: \.self) { user in
                                    
                                    if user.username.lowercased() == username.lowercased() {
                                        
                                        
                                        
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
                                                            
                                                          subscription = "none"
                                                            
                                                            for post in postsModel.list {
                                                                if post.username.lowercased() == username.lowercased() {
                                                                    postsModel.deleteData(postToDelete: post)
                                                                }
                                                            }
                                                            
                                                            for about in aboutModel.list {
                                                                if about.username.lowercased() == username.lowercased() {
                                                                    aboutModel.deleteData(aboutToDelete: about)
                                                                }
                                                            }
                                                            
                                                            for post in postsModel.list {
                                                                
                                                                for comment in commentsModel.list {
                                                                    if comment.username.lowercased() == username.lowercased() {
                                                                        commentsModel.deleteData(thepost: post, commentToDelete: comment)
                                                                    }
                                                                }
                                                            }
                                                            
                                                            for comm in commModel.list {
                                                                for message in messageModel.list {
                                                                    if message.username.lowercased() == username.lowercased() {
                                                                        messageModel.deleteData(theComm: comm, messageToDelete: message)
                                                                    }
                                                                }
                                                            }
                                                            for userie in model.list {
                                                                if userie.username.lowercased() == username.lowercased() {
                                                                    model.deleteData(user: userie)
                                                                    delUserModel.addData(username: userie.username)
                                                                    newUser = true
                                                                    print("DONE")
                                                                }
                                                            }
                                                        }
                                                    }
                                                    Spacer()
                                                }
                                            } header: {
                                                Text("Type your username in to confirm")
                                            }
                                            
                                            
                                            HStack {
                                                Spacer()
                                                Text("When you delete an account, all data associated with it will be deleted from our database. Your account and about posts will be deleted immediately, while your posts, comments and messages will be deleted within the next 1 to 3 business days, manually.")
                                                    .fontWeight(.light)
                                                Spacer()
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
                                
                                ZStack {
                                    
                                    if aboutText.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                                        HStack {
                                            Text("Write your about here:")
                                                .foregroundColor(.gray)
                                                .fontWeight(.light)
                                            Spacer()
                                        }
                                    }
                                    TextEditor(text: $aboutText)
                                        .focused($focus)
                                }
                            }  header: {
                                Text("Your about")
                            }
                            Section {
                                HStack {
                                    Spacer()
                                    Button("Post") {
                                        
                                        if username != "" {
                                            if aboutText.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
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
                                                
                                                if aboutText.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                                                    let components = Calendar.current.dateComponents([.day, .month, .year], from: Date.now)
                                                    
                                                    let year = components.year ?? 0
                                                    let month = components.month ?? 0
                                                    let day = components.day ?? 0
                                                    let actualAbout = aboutText.trimmingCharacters(in: .whitespacesAndNewlines)
                                                    
                                                    for userie in model.list {
                                                        if userie.username.lowercased() == username.lowercased() {
                                                            aboutModel.addData(username: username, about: actualAbout, date: "\(day)/\(month)/\(year)", reported: false, imageURL: aboutImageLink, pfp: "\(userie.pfp)", verified: userie.verified, subscription: subscription, timestamp: Int(NSDate().timeIntervalSince1970))
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
                                        TermsOfService()
                                    } label: {
                                        Text("Terms of Service")
                                    }
                                }
                                Section {
                                    NavigationLink {
                                        PrivacyPolicy()
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
            
            if userie.username.lowercased() == username.lowercased() {
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
