//
//  CommentsView.swift
//  Skymie
//
//  Created by Nethan on 22/11/22.
//

import SwiftUI

struct CommentsView: View {
    @State var comment = ""
    @FocusState var focus:Bool
    @ObservedObject var model = UserModel()
    @ObservedObject var commentsModel = CommentsModel()
    @AppStorage("username") var username = ""
    @State var cannotDeleteComm = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timeRemaining = 0.5
    
    var body: some View {
        NavigationView {
            List {
                
                
                Section {
                    
                    TextEditor(text: $comment)
                        .focused($focus)
                    HStack {
                        Spacer()
                        Button("Comment") {
                            
                            let actualComment = comment.trimmingCharacters(in: .whitespaces)
                            
                            let components = Calendar.current.dateComponents([.day, .month, .year], from: Date.now)
                            
                            let year = components.year ?? 0
                            let month = components.month ?? 0
                            let day = components.day ?? 0
                                
                        
                                        if comment != "" {
                                            
                                            if username == "Mister365b" ||  username == "mister365b"{
                                                commentsModel.addData(post: thisPost, username: username, comment: actualComment, postId: thisPost.id, pfp: "\(day)/\(month)/\(year)", verified: true)
                                            } else {
                                                commentsModel.addData(post: thisPost, username: username, comment: actualComment, postId: thisPost.id, pfp: "\(day)/\(month)/\(year)", verified: false)
                                            }
                                        }
                               
                                
                            
                            comment = ""
                            
                        }
                        Spacer()
                    }
                } header: {
                    Text("Post a comment here")
                } footer: {
                    Text("Consider writing something cool and nice.")
                }
                HStack {
                    Spacer()
                    Text("Comments on this post")
                        .font(.title2)
                    Spacer()
                }
                
                
                ForEach(commentsModel.list) { comment in
                    
                    
                        Section {
                            HStack {
                                
                           
                                Text("\(comment.username)")
                                    .fontWeight(.bold)
                                if comment.verified == true {
                                    Image(systemName: "checkmark.seal.fill")
                                        .foregroundColor(.blue)
                                }
                                Spacer()
                                Text("\(comment.pfp)")
                            }
                            Text("\(comment.comment)")
                                .fontWeight(.light)
                            
                            if comment.username == username {
                                Button {
                                    
                                    if username == comment.username {
                                        commentsModel.deleteData(thepost: thisPost, commentToDelete: comment)
                                    } else if username == "Mister365b" || username == "mister365b" {
                                        commentsModel.deleteData(thepost: thisPost, commentToDelete: comment)
                                    } else {
                                        cannotDeleteComm = true
                                    }
                                } label: {
                                    Image(systemName: "trash.fill")
                                        .font(.title2)
                                }
                                .confirmationDialog("You can't delete this comment", isPresented: $cannotDeleteComm, titleVisibility: .visible) {
                                    
                                } message: {
                                    Text("You can't delete this comment because you didn't create it.")
                                }
                            }
                        }
                    
                }
                
            }
           
            .refreshable {
                commentsModel.getData(post: thisPost)
            }
            .navigationTitle("Comments")
            .onReceive(timer) { time in
                commentsModel.getData(post: thisPost)
                timeRemaining = 0.5
            }
        }
    }
    
    init() {
        commentsModel.getData(post: thisPost)
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView()
    }
}
