//
//  PostsView.swift
//  Skymie
//
//  Created by Nethan on 10/7/22.
//

import SwiftUI
import Firebase
import AVKit

var thisPost = PostsData(id: "", username: "", post: "", date: "", imageURL: "", reported: false, videoURL: "", pfp: "", verified: false)
struct PostsView: View {
    @State var page = 4
    @ObservedObject var model = UserModel()
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
    @State var cannotDelete = false
    @State var editSheet = false
    @State var editedPostText = ""
    @State var commentsSheet = false
    @State var commentsView = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timeRemaining = 3
@State var deleteComm = false

  
    @FocusState var focus:Bool
 @State var sureReport = false
    var body: some View {
        if commentsView == false {
            ZStack {
                
                
                
                VStack {
                    
                    
                    Text("↓ Swipe down to load more posts ↓")
                    
                    NavigationView {
                        
                        
                        
                        
                        
                        List(postsModel.list) { postO in
                            
                            Section {
                                
                                
                                
                                HStack {
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
                                    Text("\(postO.username)")
                                        .fontWeight(.bold)
                                    
                                    if postO.verified == true {
                                        Image(systemName: "checkmark.seal.fill")
                                            .foregroundColor(.blue)
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
                                
                                if let u = URL(string: postO.videoURL) {
                                    VideoPlayer(player: AVPlayer(url:  URL(string: "\(postO.videoURL)")!)) {
                                        VStack {
                                            Text("Watermark")
                                                .foregroundColor(.black)
                                                .background(.white.opacity(0.7))
                                            Spacer()
                                        }
                                        
                                    }
                                    
                                }
                                
                                Text("\(postO.post)")
                                
                                if postO.username == username {
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
                                        if username == postO.username {
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
                                        if username == postO.username {
                                            
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
                            postsModel.getData()
                            timeRemaining = 3
                        }
                    }
                    .navigationViewStyle(.stack)
                }
            }
        } else {
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