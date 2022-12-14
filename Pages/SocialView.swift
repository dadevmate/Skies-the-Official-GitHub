//
//  SocialView.swift
//  Skymie
//
//  Created by Nethan on 8/7/22.
//

import SwiftUI
import AVKit
import Network

var viewUsers = false

var userSearchie = ""
var usersFound:[String] = []
struct SocialView: View {
    @StateObject var network = Network()
    @State var page = 4
    @ObservedObject var model = UserModel()
    @State var userSearched = userSearchie
    @AppStorage("person") var person = ""
    @AppStorage("savedBio") var savedBio = ""
    @AppStorage("savedFavourites") var savedFavourites = ""
    @AppStorage("savedHobbies") var savedHobbies = ""
    @AppStorage("savedMediaLink") var savedMediaLink = ""
    @AppStorage("savedProfilePic") var savedProfilePic = ""
    @AppStorage("subscription") var subscription = ""
    @State var postedText = ""
    @State var videoHelp = false
    @State var usersView = false
    @State var noSuchUser = false
    @State var usersF: [String] = usersFound
    @State var posts: [String] = []
    @State var videoLink = ""
    @State var showReportedVideos = false
    @AppStorage("username") var username = ""
    @ObservedObject var postsModel = PostsModel()
    @State var surePost = false
    @State var tooLong = false
    @State var editedPos = ""
    @FocusState var focus:Bool
    @State var inappropriate = false
    @State var showReportedPosts = false
    @State var sendPhoto = false
    @State var imageLink = ""
    @State var reinvoke = false
    @State var stop = false
  @State var imageHelp =  false
    @State var editedAbout = ""
    @ObservedObject var aboutModel = AboutModel()
    @State var showReportedAbouts = false
   
    @ObservedObject var videoModel = VideoModel()
    @Environment(\.colorScheme) var colorScheme
    
    @State var swearWords = ["fuck", "sex", "fucking", "fucked", "nigga", "bitch", "nude", "naked", "genitals", "vagina", "penis", "sperm", "sperms", "sexual", "intercourse", "cunt", "chink", "nigger", "porn", "pornography", "pornhub", "bitching", "dick", "dicks", "virginity", "virgin", "pussy", "erect", "dildo"]
  
    var body: some View {
        
     
            
      
                
                
                
                VStack {
                    
                    
                    NavigationView {
                        List {
                            
                            Section {
                            HStack {
                                TextField("Search for users", text: $userSearched)
                                    .focused($focus)
                                
                                
                                Button {
                                    
                                    usersFound.removeAll()
                                    
                                    for userie in model.list {
                                        print(model.list)
                                        if userie.username.lowercased() == userSearched.lowercased() || userie.username.lowercased().contains(userSearched.lowercased()){
                                            
                                            usersView = true
                                            
                                            usersFound.append("Username: \(userie.username) \n \n Person: \(userie.person) \n \n Bio: \(userie.bio) \n \n  Favourites: \(userie.favourites) \n \n Hobbies: \(userie.hobbies) \n \n Media Link: \(userie.mediaLink)")
                                            
                                        } else {
                                            if userSearched != "" {
                                                noSuchUser = true
                                            }
                                        }
                                    }
                                    
                                } label: {
                                    
                                    Image(systemName: "magnifyingglass.circle.fill")
                                        .font(.title)
                                        .foregroundColor(.secondary)
                                    
                                    
                                }
                                .sheet(isPresented: $usersView) {
                                    UsersView()
                                }
                                
                                
                            }
                            } footer: {
                                Text("* Nothing happens if you search for an invalid user")
                            }
                            Section {
                                
                                Text("Text you want to post:")
                                    .fontWeight(.light)
                                    .font(.body)
                                TextEditor(text: $postedText)
                                    .focused($focus)
                                
                                HStack {
                                    
                                    TextField("An Image URL (optional)", text: $imageLink)
                                        .focused($focus)
                                    Button {
                                        imageHelp = true
                                    } label: {
                                        Image(systemName: "questionmark.app.fill")
                                            .font(.title)
                                    }
                                    .sheet(isPresented: $imageHelp) {
                                        VStack {
                                            Spacer()
                                            Spacer()
                                            Text("Help with posting \n          images")
                                                .font(.title)
                                                .fontWeight(.light)
                                            
                                            Spacer()
                                            
                                            Text("You can post an image by pasting it's\n link from the web in here. However, \n please do not post any copyrighted \n content. Preferably, you can post \n images you made/took from your other \n social media accounts here. \n\n Please keep in mind not to post any \n NSFW content or anything that can be\n considered adultry or pornography. \n \n Failure to abide by these rules will \n lead to your account being \n banned/terminated. For more information \n on what's not allowed, please see our \n Terms of Service on our website. \n \n Let's keep Skies a fun place for \n everyone!")
                                            Spacer()
                                            Spacer()
                                            Image(systemName: "heart.circle.fill")
                                                .font(.system(size: 90))
                                            
                                            
                                            
                                            Spacer()
                                            Spacer()
                                        }
                                    }
                                    
                                    
                                }
                              
                                HStack {
                                    Spacer()
                                    Button("Post") {
                                        
                                        if postedText != "" {
                                            if postedText.count <= 450 {
                                                
                                                
                                                for swearWord in swearWords {
                                                    if postedText.trimmingCharacters(in:
                                                            .whitespacesAndNewlines).lowercased().contains(swearWord) {
                                                        inappropriate = true
                                                        postedText = ""
                                                    }
                                                }
                                                
                                                if inappropriate == false {
                                                    surePost = true
                                                }
                                                
                                                
                                                
                                            } else if postedText.count > 450 {
                                                tooLong = true
                                            }
                                        }
                                    }
                                    .alert("This post is inappropriate.", isPresented: $inappropriate) {
                                        
                                    } message: {
                                        Text("This post contains content against our guidelines and rules. It may contain swear words, sexual content or something else we deemed inappropriate. Check out what's allowed and not allowed on Skies in our Terms of Service. Let's keep Skies a great place for everyone!")
                                    }
                                    .confirmationDialog("Your post is too long.", isPresented: $tooLong) {
                                        
                                    } message: {
                                        Text("We limit all our posts to 450 characters. This is to allow a pleasant reading experience for users. Please shorten your post.")
                                    }
                                    .alert("Are you sure you want to post this?", isPresented: $surePost) {
                                        
                                        Button("Yes") {
                                            
                                            
                                            if username != "" {
                                                
                                                
                                                
                                                
                                                
                                                let components = Calendar.current.dateComponents([.day, .month, .year], from: Date.now)
                                                
                                                let year = components.year ?? 0
                                                let month = components.month ?? 0
                                                let day = components.day ?? 0
                                                let actualPost = postedText.trimmingCharacters(in: .whitespacesAndNewlines)
                                                
                                                for userie in model.list {
                                                    if userie.username.lowercased() == username.lowercased() {
                                                        postsModel.addData(username: username, post: actualPost, date: "\(day)/\(month)/\(year)", reported: false, imageURL: imageLink, pfp: "\(userie.pfp)", verified: userie.verified, subscription: subscription, timestamp: Int(NSDate().timeIntervalSince1970))
                                                    }
                                                }
                                                posts.append(actualPost)
                                                postedText = ""
                                                imageLink = ""
                                                videoLink = ""
                                                reinvoke = true
                                                
                                            }
                                            
                                        }
                                        
                                        Button("No") {
                                            
                                        }
                                        
                                    } message: {
                                        Text("The entire user base of Skies will see this. Make sure it's great, and it reflects you well.")
                                    }
                                    
                                    
                                    Spacer()
                                }
                            } header: {
                                Text("Post something to Skies here")
                            } footer: {
                                
                                Text("* The entire user base of Skies will see this \n on their feed. Make sure to write something \n amazing! \n \n * Images/Text posted must not be copyrighted content. If you post copyrighted content, your post will be deleted. You may receive bans and/or your account may be terminated. For more information on what's allowed and what's not, see our Terms of Service.")
                            }
                            
                            
                            
                            NavigationLink(destination: PostsView()) {
                                Text("See Skies posts")
                                
                            }
                            
                            if username == "Mister365b" || username == "mister365b" {
                                
                                Section {
                                    
                                    /*
                                     
                                     
                                     
                                     */
                                    
                                    Button {
                                        showReportedPosts = true
                                        postsModel.getData()
                                    } label: {
                                        Text("Reported posts")
                                            .fontWeight(.bold)
                                            .font(.title)
                                            .foregroundColor(.red)
                                    }
                                    .sheet(isPresented: $showReportedPosts) {
                                        
                                        NavigationView {
                                            
                                            
                                            List(postsModel.list) { post in
                                                if post.reported == true {
                                                    
                                                    
                                                    
                                                    
                                                    Section {
                                                        
                                                        if post.imageURL.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
                                                            
                                                            if let u = URL(string: post.imageURL) {
                                                                AsyncImage(url: URL(string: "\(post.imageURL)")) { image in image
                                                                        .resizable()
                                                                        .scaledToFit()
                                                                } placeholder: {
                                                                    ProgressView()
                                                                        .progressViewStyle(.circular)
                                                                }
                                                            }
                                                        }
                                                        
                                                        
                                                        Text("\(post.username)")
                                                            .fontWeight(.bold)
                                                        Text("\(post.date)")
                                                        Text("\(post.post)")
                                                        
                                                        
                                                        
                                                        Button("Delete this post") {
                                                            postsModel.deleteData(postToDelete: post)
                                                            
                                                        }
                                                        TextEditor(text: $editedPos)
                                                            .focused($focus)
                                                        Button("Edit this post") {
                                                            postsModel.updateData(postToUpdate: post, edit: editedPos)
                                                            editedPos = ""
                                                        }
                                                        
                                                        Button("Unreport this post", role: .destructive) {
                                                            postsModel.report(postToUnreport: post, reportStatus: false)
                                                        }
                                                    }
                                                }
                                            }
                                            
                                            
                                            
                                            
                                            .navigationTitle("Reported posts")
                                            .toolbar {
                                                ToolbarItem(placement: .navigationBarLeading) {
                                                    Button("Dismiss") {
                                                        showReportedPosts = false
                                                    }
                                                }
                                            }
                                            
                                            
                                        }
                                        
                                        
                                        
                                        
                                    }
                                    
                                    
                                    Button {
                                        showReportedAbouts = true
                                        aboutModel.getData()
                                    } label: {
                                        Text("Reported abouts")
                                            .fontWeight(.bold)
                                            .font(.title)
                                            .foregroundColor(.red)
                                    }
                                    .sheet(isPresented: $showReportedAbouts) {
                                        
                                        
                                        NavigationView {
                                            List(aboutModel.list) { about in
                                                if about.reported == true {
                                                    
                                                    
                                                    
                                                    
                                                    Section {
                                                        
                                                        if about.imageURL.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
                                                            
                                                            if let u = URL(string: about.imageURL) {
                                                                AsyncImage(url: URL(string: "\(about.imageURL)")) { image in image
                                                                        .resizable()
                                                                        .scaledToFit()
                                                                } placeholder: {
                                                                    ProgressView()
                                                                        .progressViewStyle(.circular)
                                                                }
                                                            }
                                                        }
                                                        
                                                        Text("\(about.username)")
                                                            .fontWeight(.bold)
                                                        Text("\(about.date)")
                                                        Text("\(about.about)")
                                                        
                                                        
                                                        
                                                        Button("Delete this about") {
                                                            aboutModel.deleteData(aboutToDelete: about)
                                                            
                                                        }
                                                        TextEditor(text: $editedAbout)
                                                            .focused($focus)
                                                        Button("Edit this about") {
                                                            aboutModel.updateData(aboutToUpdate: about, edit: editedAbout)
                                                            editedAbout = ""
                                                        }
                                                        
                                                        Button("Unreport this about", role: .destructive) {
                                                            aboutModel.report(aboutToUnreport: about, reportStatus: false)
                                                        }
                                                    }
                                                }
                                            }
                                            .navigationTitle("Reported abouts")
                                            .toolbar {
                                                ToolbarItem(placement: .navigationBarLeading) {
                                                    Button("Dismiss") {
                                                        showReportedAbouts = false
                                                    }
                                                }
                                            }
                                        }
                                        
                                    }
                                    
                                    
                                    
                                    
                                    
                                    
                                    Button {
                                        showReportedVideos = true
                                        videoModel.getData()
                                    } label: {
                                        Text("Reported videos")
                                            .fontWeight(.bold)
                                            .font(.title)
                                            .foregroundColor(.red)
                                    }
                                    .sheet(isPresented: $showReportedVideos) {
                                        
                                        ScrollView {
                                            
                                            ForEach(videoModel.list) { about in
                                                if about.reported == true {
                                                    
                                                    
                                                    
                                                    
                                                    VideoPlayer(player: AVPlayer(url:  URL(string: about.videoLink ?? "")!)) {
                                                        
                                                    }
                                                    .frame(width: 300, height: 300)
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    Button("Delete this Video") {
                                                        videoModel.deleteData(videoToDelete: about)
                                                        
                                                    }
                                                    
                                                    
                                                    Button("Unreport this Video", role: .destructive) {
                                                        videoModel.report(videoToUnreport: about, reportStatus: false)
                                                    }
                                                    
                                                    
                                                    
                                                    
                                                }
                                            }
                                        }
                                    }
                                    
                                }
                            }
                            Section {
                                NavigationLink(destination: AboutView()) {
                                    Text("See special abouts from people you're following")
                                    
                                }
                            
                            }
                            
                            Section {
                                HStack {
                                    TextField("Paste a video link", text: $videoLink)
                                        .focused($focus)
                                    Button {
                                        videoHelp = true
                                    } label: {
                                        Image(systemName: "questionmark.app.fill")
                                            .font(.title)
                                    }
                                    .sheet(isPresented: $videoHelp) {
                                        VStack {
                                            Spacer()
                                            Spacer()
                                            Text("Help with posting \n          videos")
                                                .font(.title)
                                                .fontWeight(.light)
                                            
                                            Spacer()
                                            
                                            Text("You can post a video by pasting it's\n link from the web in here. However, \n please do not post any copyrighted \n content. Preferably, you can post \n video you made/took from your other \n social media accounts here in mp4 format.\nStuff like YouTube links don't work,\nbecause they aren't direct video links. \n\n Please keep in mind not to post any \n NSFW content or anything that can be\n considered adultry or pornography. \n \n Failure to abide by these rules will \n lead to your account being \n banned/terminated. For more information \n on what's not allowed, please see our \n Terms of Service on our website. \n \n Let's keep Skies a fun place for \n everyone!")
                                            Spacer()
                                            Spacer()
                                            Image(systemName: "hand.thumbsup.fill")
                                                .font(.system(size: 90))
                                            
                                            
                                            
                                            Spacer()
                                            Spacer()
                                        }
                                    }
                                    
                                }
                                HStack {
                                    Spacer()
                                    Button("Post") {
                                        
                                        if videoLink.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                                            if let u = URL(string: videoLink) {
                                                let components = Calendar.current.dateComponents([.day, .month, .year], from: Date.now)
                                                
                                                let year = components.year ?? 0
                                                let month = components.month ?? 0
                                                let day = components.day ?? 0
                                                
                                                for user in model.list {
                                                    
                                                    if user.username.lowercased() == username.lowercased() {
                                                        videoModel.addData(username: username, videoLink: videoLink, date: "\(day)/\(month)/\(year)", reported: false, pfp: savedProfilePic, verified: user.verified, subscription: subscription, timestamp: Int(NSDate().timeIntervalSince1970))
                                                    }
                                                }
                                                
                                                videoLink = ""
                                            }
                                        }
                                    }
                                    Spacer()
                                }
                            } footer: {
                                Text("* Non-copyright videos only, mp4 video links preferred. Your video may not play/appear if you send a video link that's not in the correct format! Stuff like YouTube links don't work, because they aren't direct video links.")
                            }
                            
                            Section {
                                NavigationLink(destination: VideoView()) {
                                    Text("Watch Videos")
                                    
                                }
                            }
                         
                            
                        }
                        .onAppear {
                            network.checkConnection()
                        }
                        .refreshable {
                            network.checkConnection()
                            postsModel.getData()
                            model.getData()
                                
                            
                        }
                        .onReceive(network.$connected, perform: { connected in
                          
                            print(connected)
                        })
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                Button("Done") {
                                    focus = false
                                }
                                .foregroundColor(.blue)
                            }
                        }
                        .navigationTitle("Socialise")
                        
                        
                        
                    }
                    .navigationViewStyle(.stack)
                    
                    
                    
                    
                    
                    
                    
                    
                
                .onAppear {
                    network.checkConnection()
                }
            }
     
    }
    init() {
   
        // On this initialisation of this view, we get the data
        model.getData()
        postsModel.getData()
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

struct SocialView_Previews: PreviewProvider {
    static var previews: some View {
        SocialView()
    }
}

