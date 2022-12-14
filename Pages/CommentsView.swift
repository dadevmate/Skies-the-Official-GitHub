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
    @AppStorage("subscription") var subscription = ""
    @State var cannotDeleteComm = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timeRemaining = 3
    @State private var blocked: [String] = UserDefaults.standard.object(forKey: "blocked") as? [String] ?? [""]
    @State var myArr = [CommentData(id: "", username: "", comment: "", postId: "", pfp: "", verified: false, subscription: "", timestamp: 0)]
    var body: some View {
        NavigationView {
            List {
                
                
                Section {
                    
                    TextEditor(text: $comment)
                        .focused($focus)
                    HStack {
                        Spacer()
                        Button("Comment") {
                            
                            let actualComment = comment.trimmingCharacters(in: .whitespacesAndNewlines)
                            
                            let components = Calendar.current.dateComponents([.day, .month, .year], from: Date.now)
                            
                            let year = components.year ?? 0
                            let month = components.month ?? 0
                            let day = components.day ?? 0
                                
                        
                                        if comment != "" {
                                            
                                            if username == "Mister365b" ||  username == "mister365b"{
                                                commentsModel.addData(post: thisPost, username: username, comment: actualComment, postId: thisPost.id, pfp: "\(day)/\(month)/\(year)", verified: true, subscription: subscription, timestamp: Int(NSDate().timeIntervalSince1970))
                                            } else {
                                                commentsModel.addData(post: thisPost, username: username, comment: actualComment, postId: thisPost.id, pfp: "\(day)/\(month)/\(year)", verified: false, subscription: subscription, timestamp: Int(NSDate().timeIntervalSince1970))
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
                
                
                ForEach(myArr) { comment in
                    
            
                    
                        if blocked.contains(where: {$0.contains(comment.username)}) == false {
                        
                        Section {
                        HStack {
                            
                            
                            Text("\(comment.username)")
                                .fontWeight(.bold)
                            if comment.verified == true {
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(.blue)
                            }
                            
                            if subscription != "none" {
                                Image(systemName: "ticket.fill")
                                    .foregroundColor(.purple)
                            }
                            
                            Spacer()
                            Text("\(comment.pfp)")
                        }
                        Text("\(comment.comment)")
                            .fontWeight(.light)
                        
                        if comment.username.lowercased() == username.lowercased() {
                            Button {
                                
                                if username.lowercased() == comment.username.lowercased() {
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
                
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button("Done") {
                        focus = false
                    }
                    .foregroundColor(.blue)
                }
            }
            .refreshable {
                commentsModel.getData(post: thisPost)
            }
            .navigationTitle("Comments")
            .onReceive(timer) { time in
                commentsModel.getData(post: thisPost)
                myArr = commentsModel.list.sorted { var1, var2 in
                     
                     var1.timestamp > var2.timestamp
                     
                 }
                timeRemaining = 3
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
