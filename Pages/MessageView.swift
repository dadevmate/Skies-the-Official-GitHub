//
//  MessageView.swift
//  Skymie
//
//  Created by Nethan on 20/11/22.
//

import SwiftUI
import Firebase
struct MessageView: View {
    @ObservedObject var commModel = CommModel()
    @ObservedObject var messageModel = MessageModel()
    @State var messageText = ""
    @StateObject var network = Network()
    @ObservedObject var model = UserModel()
    @FocusState var focus: Bool
    @AppStorage("username") var username = ""
    @AppStorage("savedProfilePic") var savedProfilePic = ""
    @State var back = false
    @State var swearWords1 = ["fuck", "sex", "fucking", "fucked", "nigga", "bitch", "nude", "naked", "genitals", "vagina", "penis", "sperm", "sperms", "sexual", "intercourse", "cunt", "chink", "nigger", "porn", "pornography", "pornhub", "bitching", "dick", "dicks", "virginity", "virgin", "pussy", "erect", "dildo"]
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timeRemaining = 0.2
    @State var swearWords2 = [ "sex", "nude", "naked", "genitals", "vagina", "penis", "sperm", "sperms", "chink",  "porn", "pornography", "pornhub", "dick", "dicks"]
    @State var badWord = false
@State var imageLink = ""
    var body: some View {
       
    
            if back == false {
                VStack {
                    
                    HStack {
                        Spacer()
                        Button {
                            back = true
                        } label: {
                            Image(systemName: "chevron.backward.square.fill")
                                .foregroundColor(.gray)
                                .font(.title)
                        }
                        
                        Spacer()
                        
                        Text("\(thisComm.name)")
                        
                        Spacer()
                        
                        if focus == true {
                            Button("Done") {
                                focus = false
                            }
                        }
                        
                        
                        Spacer()
                        
                    }
                    
                    List(messageModel.list) { message in
                        
                        Section {
                            
                            HStack {
                                
                                AsyncImage(url: URL(string: "\(message.pfp)")) { image in image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    
                                    if message.pfp != "" {
                                        ProgressView()
                                            .progressViewStyle(.circular)
                                    }
                                }
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                                Text("\(message.username)")
                                    .fontWeight(.bold)
                                if message.verified == true {
                                    Image(systemName: "checkmark.seal.fill")
                                        .foregroundColor(.blue)
                                }
                                Spacer()
                                Text("\(message.time)")
                                    .fontWeight(.ultraLight)
                                
                                if message.username == username || username == "Mister365b" || username == "mister365b"{
                                    Button {
                                        messageModel.deleteData(theComm: thisComm, messageToDelete: message)
                                    } label: {
                                        Image(systemName: "trash.fill")
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                            
                            if message.image != "" {
                                AsyncImage(url: URL(string: "\(message.image)")) { image in image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    
                                 
                                        ProgressView()
                                            .progressViewStyle(.circular)
                                    
                                }
                                
                            }
                            
                            Text("\(message.message)")
                                .fontWeight(.light)
                            
                        }
                        
                        
                    }
                    .onAppear {
                        network.checkConnection()
                    }
                    .refreshable {
                        network.checkConnection()
                        messageModel.getData(comm: thisComm)
                    }
                    .onReceive(network.$connected, perform: { connected in
                        
                        print(connected)
                    })
                    .onReceive(timer) { time in
                        messageModel.getData(comm: thisComm)
                        messageModel.order(comm: thisComm)
                        timeRemaining = 0.2
                    }
                    
                    TextField("Add an image link", text: $imageLink)
                        .focused($focus)
                        .border(Color.gray)
                        .padding()
                        .frame(width: 350, height: 45)
                        .cornerRadius(5)
                    HStack {
                        Spacer()
                      
                        if messageText.count < 150 {
                            TextEditor(text: $messageText)
                                .focused($focus)
                                .frame(width: 300, height: 75)
                                .cornerRadius(5)
                                .border(Color.black)
                        } else if messageText.count > 150 && messageText.count < 250 {
                            TextEditor(text: $messageText)
                                .focused($focus)
                                .frame(width: 300, height: 100)
                                .cornerRadius(5)
                                .border(Color.black)
                        }  else if messageText.count > 250 && messageText.count < 350 {
                            TextEditor(text: $messageText)
                                .focused($focus)
                                .frame(width: 300, height: 125)
                                .cornerRadius(5)
                                .border(Color.black)
                        } else if messageText.count > 350 && messageText.count < 450 {
                            TextEditor(text: $messageText)
                                .focused($focus)
                                .frame(width: 300, height: 150)
                                .cornerRadius(5)
                                .border(Color.black)
                        } else if messageText.count > 450 {
                            TextEditor(text: $messageText)
                                .focused($focus)
                                .frame(width: 300, height: 175)
                                .cornerRadius(5)
                                .border(Color.black)
                        }
                        Spacer()
                        Button {
                            
                            
                            
                            if thisComm.restricted == "18 and above" {
                                
                                for word in swearWords2 {
                                    if messageText.lowercased().contains(word) {
                                        badWord = true
                                    }
                                }
                                if badWord == false {
                                    if messageText.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                                        let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
                                        let hour = components.hour ?? 0
                                        let minute = components.minute ?? 0
                                        
                                        if minute <  10 {
                                            
                                            if username == "Mister365b" || username == "mister365b" {
                                                messageModel.addData(comm: thisComm, username: username, message: messageText.trimmingCharacters(in: .whitespacesAndNewlines), commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: imageLink, timestamp: messageModel.list.count + 1, verified: true)
                                            } else {
                                                messageModel.addData(comm: thisComm, username: username, message: messageText.trimmingCharacters(in: .whitespacesAndNewlines), commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: imageLink, timestamp: messageModel.list.count + 1, verified: false)
                                            }
                                            
                                          
                                        } else if minute >= 10 {
                                            if username == "Mister365b" || username == "mister365b" {
                                                messageModel.addData(comm: thisComm, username: username, message: messageText.trimmingCharacters(in: .whitespacesAndNewlines), commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: imageLink, timestamp: messageModel.list.count + 1, verified: true)
                                            } else {
                                                messageModel.addData(comm: thisComm, username: username, message: messageText.trimmingCharacters(in: .whitespacesAndNewlines), commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: imageLink, timestamp: messageModel.list.count + 1, verified: false)
                                            }
                                       
                                        }
                                        messageModel.getData(comm: thisComm)
                                        
                                        messageText = ""
                                        imageLink = ""
                                        focus = false
                                    }
                                }
                            } else {
                                for word in swearWords1 {
                                    if messageText.lowercased().contains(word) {
                                        badWord = true
                                    }
                                }
                                if badWord == false {
                                    if messageText.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                                        let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
                                        let hour = components.hour ?? 0
                                        let minute = components.minute ?? 0
                                        
                                        if minute <  10 {
                                            
                                            if username == "Mister365b" || username == "mister365b" {
                                                messageModel.addData(comm: thisComm, username: username, message: messageText.trimmingCharacters(in: .whitespacesAndNewlines), commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: imageLink, timestamp: messageModel.list.count + 1, verified: true)
                                            } else {
                                                messageModel.addData(comm: thisComm, username: username, message: messageText.trimmingCharacters(in: .whitespacesAndNewlines), commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: imageLink, timestamp: messageModel.list.count + 1, verified: false)
                                            }
                                            
                                          
                                        } else if minute >= 10 {
                                            if username == "Mister365b" || username == "mister365b" {
                                                messageModel.addData(comm: thisComm, username: username, message: messageText.trimmingCharacters(in: .whitespacesAndNewlines), commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: imageLink, timestamp: messageModel.list.count + 1, verified: true)
                                            } else {
                                                messageModel.addData(comm: thisComm, username: username, message: messageText.trimmingCharacters(in: .whitespacesAndNewlines), commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: imageLink, timestamp: messageModel.list.count + 1, verified: false)
                                            }
                                       
                                        }
                                        messageModel.getData(comm: thisComm)
                                        messageText = ""
                                        imageLink = ""
                                        focus = false
                                    }
                                }
                            }
                            
                            
                        } label: {
                            Image(systemName: "arrow.up.square.fill")
                                .foregroundColor(.gray)
                                .font(.largeTitle)
                        }
                        .alert("This content is not allowed in this community", isPresented: $badWord) {
                            Button("Alright") {
                                messageText = ""
                                badWord = false
                                
                            }
                        } message: {
                            Text("The content in your message is banned from this community, according to our Terms of Service. Communities for everyone have more banned words than communities designed for people 18 years old and above. Please help us keep Skies a fun place for everyone.")
                        }
                        Spacer()
                    }
                    
                    Spacer()
                    Spacer()
                    
                    
                }
            } else {
                HomeView()
            }
    
    }
    
    init() {
        messageModel.getData(comm: thisComm)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
