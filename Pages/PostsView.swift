//
//  PostsView.swift
//  Skymie
//
//  Created by Nethan on 10/7/22.
//

import SwiftUI
import Firebase
import AVKit

var thisPost = PostsData(id: "", username: "", post: "", date: "", imageURL: "", reported: false, pfp: "", verified: false, subscription: "", timestamp: 0)
struct PostsView: View {
    @State var page = 4
    @ObservedObject var model = UserModel()
    @State private var blocked: [String] = UserDefaults.standard.object(forKey: "blocked") as? [String] ?? [""]
    @State var userSearched = userSearchie
    @State var postedText = ""
    @State var usersView = false
    @State var noSuchUser = false
    @State var usersF: [String] = usersFound
    @State var posts: [String] = []
    @StateObject var network = Network()
    @AppStorage("username") var username = ""
    @ObservedObject var postsModel = PostsModel()
    @State var deletePost = false
    @State var surePost = false
    @State var sureDel = false
    @State var cannotDelete = false
    @State var editSheet = false
    @State var editedPostText = ""
    @State var commentsSheet = false
    @AppStorage("subscription") var subscription = ""
    @State var commentsView = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timeRemaining = 3
@State var deleteComm = false
@State var myArr = [PostsData(id: "", username: "", post: "", date: "", imageURL: "", reported: false, pfp: "", verified: false, subscription: "none", timestamp: 0)]
  
    @FocusState var focus:Bool
 @State var sureReport = false
    var body: some View {
        if commentsView == false {
            ZStack {
                
                
                
                VStack {
                    
                    
                    Text("↓ Swipe down to load more posts ↓")
                    
                    NavigationView {
                        
                        
                        
                        
                        
                        List(myArr) { postO in
                            
                            if blocked.contains(where: {$0.contains(postO.username)}) == false {
                                Section {
                                    
                                    
                                    
                                    HStack {
                                        if postO.pfp == "Man" {
                                            Image("Man1")
                                                .clipShape(Circle())
                                            
                                        } else if postO.pfp == "Alien" {
                                            Image("Alien1")
                                                .clipShape(Circle())
                                            
                                            
                                            
                                        } else if postO.pfp == "Skeleton" {
                                            Image("Skeleton1")
                                                .clipShape(Circle())
                                            
                                        } else if postO.pfp == "Robot" {
                                            Image("Robot1")
                                                .clipShape(Circle())
                                            
                                        } else {
                                            AsyncImage(url: URL(string: "\(postO.pfp)")) { image in image
                                                    .resizable()
                                                    .scaledToFit()
                                            } placeholder: {
                                                
                                                if postO.pfp != "" {
                                                    ProgressView()
                                                        .progressViewStyle(.circular)
                                                }
                                            }
                                            .frame(width: 30, height: 30)
                                            .clipShape(Circle())
                                        }
                                        
                                        Text("\(postO.username)")
                                            .fontWeight(.bold)
                                        
                                        if postO.verified == true {
                                            Image(systemName: "checkmark.seal.fill")
                                                .foregroundColor(.blue)
                                        }
                                        
                                        if postO.subscription != "none" {
                                            Image(systemName: "ticket.fill")
                                                .foregroundColor(.purple)
                                        }
                                        
                                        
                                        Spacer()
                                        Text("\(postO.date)")
                                            .fontWeight(.light)
                                    }
                                    
                                    if postO.imageURL.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
                                        
                                        if let u = URL(string: postO.imageURL) {
                                            AsyncImage(url: URL(string: "\(postO.imageURL)")) { image in image
                                                    .resizable()
                                                    .scaledToFit()
                                            } placeholder: {
                                                ProgressView()
                                                    .progressViewStyle(.circular)
                                            }
                                        }
                                    }
                                    
                                    
                                    Text("\(postO.post)")
                                    
                                    if postO.username.lowercased() == username.lowercased() {
                                        Section {
                                            
                                            TextEditor(text: $editedPostText)
                                                .border(.secondary)
                                                .focused($focus)
                                            
                                        } header: {
                                            HStack {
                                                Spacer()
                                                Text(" Edit this post below, then click the pencil icon. ")
                                                    .font(.footnote)
                                                    .fontWeight(.light)
                                                    .foregroundColor(.gray)
                                                Spacer()
                                            }
                                        }
                                        Button {
                                            if username.lowercased() == postO.username.lowercased() {
                                                postsModel.deleteData(postToDelete: postO)
                                            } else if username == "Mister365b" || username == "mister365b" {
                                                postsModel.deleteData(postToDelete: postO)
                                            } else {
                                                cannotDelete = true
                                            }
                                        } label: {
                                            Image(systemName: "trash.fill")
                                                .font(.title2)
                                        }
                                        
                                        
                                        .alert("You can't edit/delete this post.", isPresented: $cannotDelete) {
                                            
                                        } message: {
                                            Text("You're not the creator of this post, so you can't delete or edit it.")
                                        }
                                        
                                        
                                        
                                        
                                        Button {
                                            if username.lowercased() == postO.username.lowercased() {
                                                
                                                if editedPostText != "" {
                                                    let finalText = editedPostText.trimmingCharacters(in: .whitespacesAndNewlines)
                                                    postsModel.updateData(postToUpdate: postO, edit: finalText)
                                                    editSheet = false
                                                    editedPostText = ""
                                                }
                                            } else if username == "Mister365b" || username == "mister365b" {
                                                let finalText = editedPostText.trimmingCharacters(in: .whitespacesAndNewlines)
                                                postsModel.updateData(postToUpdate: postO, edit: finalText)
                                                editSheet = false
                                                editedPostText = ""
                                            } else {
                                                cannotDelete = true
                                            }
                                            
                                        } label: {
                                            Image(systemName: "pencil.circle.fill")
                                                .font(.title2)
                                        }
                                        
                                    }
                                    
                                    Button {
                                        thisPost = postO
                                        commentsView = true
                                        
                                    } label: {
                                        Image(systemName: "text.bubble.fill")
                                            .font(.title2)
                                    }
                                    
                                    
                                    
                                    Button {
                                        
                                        if username != "" {
                                            sureReport = true
                                        }
                                    } label: {
                                        Image(systemName: "exclamationmark.triangle.fill")
                                            .foregroundColor(.red)
                                            .font(.title2)
                                    }
                                    .alert("Do you want to report this post?", isPresented: $sureReport) {
                                        
                                        Button("Yes", role: .destructive) {
                                            postsModel.report(postToUnreport: postO, reportStatus: true)
                                        }
                                        
                                    } message: {
                                        Text("You are about to report this post. Only report it if you think it does not follow our rules and guidelines, which are written in our Terms and conditions. Some reasons include spam, swearing, sexual content etc.")
                                    }
                                    
                                    
                                }
                                
                                
                                BannerAd(unitId: "ca-app-pub-6142532326654511/4548690533")
                                    .frame(width: 300, height: 300)
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
                        .navigationTitle("My Feed")
                        .onAppear {
                            network.checkConnection()
                        }
                        .refreshable {
                            network.checkConnection()
                            model.getData()
                            postsModel.getData()
                            
                        }
                        .onReceive(network.$connected, perform: { connected in
                            
                            print(connected)
                        })
                        .onReceive(timer) { time in
                          
                            myArr = postsModel.list.sorted { var1, var2 in
                                 
                                 var1.timestamp > var2.timestamp
                                 
                             }
                            timeRemaining = 3
                        }
                    }
                    .navigationViewStyle(.stack)
                }
            }
        } else if commentsView == true {
            CommentsView()
        }
     
    }
    
    init() {
        model.getData()
        postsModel.getData()
        
    }
         }

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
