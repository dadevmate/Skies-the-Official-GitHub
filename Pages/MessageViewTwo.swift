//
//  MessageViewTwo.swift
//  Skymie
//
//  Created by Nethan on 22/11/22.
//

import SwiftUI

struct MessageViewTwo: View {
    @ObservedObject var commModel = CommModel()
    @ObservedObject var messageModel = MessageModel()
    @State var messageText = ""
    @StateObject var network = Network()
    @ObservedObject var model = UserModel()
    @FocusState var focus: Bool
    @State var emojiView = false
    @State var stickerView = false
    @AppStorage("subscription") var subscription = ""
    @AppStorage("username") var username = ""
    @AppStorage("savedProfilePic") var savedProfilePic = ""
    @State var back = false
    @State var sures = false
      @State var sures2 = false
      @State var sures3 = false
      @State var sures4 = false
      @State var sures5 = false
      @State var sures6 = false
      @State var sures7 = false
      @State var sures8 = false
      @State var sures9 = false
      @State var sures10 = false
    @State var myArr = [MessageData(id: "", username: "", message: "", commId: "", time: "", pfp: "", image: "", timestamp: 0, verified: false, subscription: "none")]
      @State var sures11 = false
      @State var sures12 = false
      @State var sures13 = false
      @State var sures14 = false
      @State var sures15 = false
    @State var swearWords1 = ["fuck", "sex", "fucking", "fucked", "nigga", "bitch", "nude", "naked", "genitals", "vagina", "penis", "sperm", "sperms", "sexual", "intercourse", "cunt", "chink", "nigger", "porn", "pornography", "pornhub", "bitching", "dick", "dicks", "virginity", "virgin", "pussy", "erect", "dildo", "drugs", "smoking", "drug", "murder"]
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timeRemaining = 0.2
    @State var swearWords2 = [ "sex", "nude", "naked", "genitals", "vagina", "penis", "sperm", "sperms", "chink",  "porn", "pornography", "pornhub", "dick", "dicks", "drugs", "smoking", "drug"]
    @State var badWord = false
@State var imageLink = ""
    var body: some View {
       
    
            if back == false {
                VStack {
                    
                    HStack {
                        Spacer()
                        
                        
                        Text("\(thisComm.name)")
                        if thisComm.id == "5lXw4ap7feRKN83rhIcw" {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                        
                        if focus == true {
                            Button("Done") {
                                focus = false
                            }
                        }
                        
                        
                        Spacer()
                        
                    }
                
                    List(myArr) { message in
                        
                        Section {
                            
                            HStack {
                                
                                if message.pfp == "Man" {
                                    Image("Man1")
                                        .clipShape(Circle())
                                } else if message.pfp == "Alien" {
                                    Image("Alien1")
                                        .clipShape(Circle())
                              
                                    
                                } else if message.pfp == "Skeleton" {
                                    Image("Skeleton1")
                                        .clipShape(Circle())
                                       
                                } else if message.pfp == "Robot" {
                                    Image("Robot1")
                                        .clipShape(Circle())
                             
                                } else {
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
                                }
                                
                                Text("\(message.username)")
                                    .fontWeight(.bold)
                                
                                if message.verified == true {
                                    Image(systemName: "checkmark.seal.fill")
                                        .foregroundColor(.blue)
                                }
                                
                                if message.subscription != "none" {
                                    Image(systemName: "ticket.fill")
                                        .foregroundColor(.purple)
                                }
                                
                                Spacer()
                                Text("\(message.time)")
                                    .fontWeight(.ultraLight)
                                
                                if message.username.lowercased() == username.lowercased() || username == "Mister365b" {
                                    Button {
                                        messageModel.deleteData(theComm: thisComm, messageToDelete: message)
                                    } label: {
                                        Image(systemName: "trash.fill")
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                            
                            if message.image != "" {
                                
                                if message.image == "Angry" {
                                    HStack {
                                        Spacer()
                                        Image("Angry")
                                        Spacer()
                                    }
                                } else if message.image == "Cool" {
                                    HStack {
                                        Spacer()
                                        Image("Cool")
                                        Spacer()
                                    }
                                } else if message.image == "Disgust" {
                                    HStack {
                                        Spacer()
                                        Image("Disgust")
                                        Spacer()
                                    }
                                } else if message.image == "Embaressed" {
                                    HStack {
                                        Spacer()
                                        Image("Embaressed")
                                        Spacer()
                                    }
                                } else if message.image == "Happy" {
                                    HStack {
                                        Spacer()
                                        Image("Happy")
                                        Spacer()
                                    }
                                }else if message.image == "Laugh" {
                                    HStack {
                                        Spacer()
                                        Image("Laugh")
                                        Spacer()
                                    }
                                }else if message.image == "Love" {
                                    HStack {
                                        Spacer()
                                        Image("Love")
                                        Spacer()
                                    }
                                }else if message.image == "Meh" {
                                    HStack {
                                        Spacer()
                                        Image("Meh")
                                        Spacer()
                                    }
                                }else if message.image == "Sad" {
                                    HStack {
                                        Spacer()
                                        Image("Sad")
                                        Spacer()
                                    }
                                }else if message.image == "Scared" {
                                    HStack {
                                        Spacer()
                                        Image("Scared")
                                        Spacer()
                                    }
                                }else if message.image == "Car" {
                                    HStack {
                                        Spacer()
                                        Image("Car")
                                        Spacer()
                                    }
                                }else if message.image == "Clover" {
                                    HStack {
                                        Spacer()
                                        Image("Clover")
                                        Spacer()
                                    }
                                }else if message.image == "Panda" {
                                    HStack {
                                        Spacer()
                                        Image("Panda")
                                        Spacer()
                                    }
                                }else if message.image == "Plane" {
                                    HStack {
                                        Spacer()
                                        Image("Plane")
                                        Spacer()
                                    }
                                }else if message.image == "Whale" {
                                    HStack {
                                        Spacer()
                                        Image("Whale")
                                        Spacer()
                                    }
                                } else {
                                    AsyncImage(url: URL(string: "\(message.image)")) { image in image
                                            .resizable()
                                            .scaledToFit()
                                    } placeholder: {
                                        
                                        
                                        ProgressView()
                                            .progressViewStyle(.circular)
                                        
                                    }
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
                        myArr = messageModel.list.sorted { var1, var2 in
                             
                             var1.timestamp > var2.timestamp
                             
                         }
                        timeRemaining = 0.2
                    }
                    
                    TextField("  Add an image link (optional)", text: $imageLink)
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
                                .border(Color.primary)
                        } else if messageText.count > 150 && messageText.count < 250 {
                            TextEditor(text: $messageText)
                                .focused($focus)
                                .frame(width: 300, height: 100)
                                .cornerRadius(5)
                                .border(Color.primary)
                        }  else if messageText.count > 250 && messageText.count < 350 {
                            TextEditor(text: $messageText)
                                .focused($focus)
                                .frame(width: 300, height: 125)
                                .cornerRadius(5)
                                .border(Color.primary)
                        } else if messageText.count > 350 && messageText.count < 450 {
                            TextEditor(text: $messageText)
                                .focused($focus)
                                .frame(width: 300, height: 150)
                                .cornerRadius(5)
                                .border(Color.primary)
                        } else if messageText.count > 450 {
                            TextEditor(text: $messageText)
                                .focused($focus)
                                .frame(width: 300, height: 175)
                                .cornerRadius(5)
                                .border(Color.primary)
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
                                                messageModel.addData(comm: thisComm, username: username, message: messageText.trimmingCharacters(in: .whitespacesAndNewlines), commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: imageLink, timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                            } else {
                                                messageModel.addData(comm: thisComm, username: username, message: messageText.trimmingCharacters(in: .whitespacesAndNewlines), commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: imageLink, timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                            }
                                            
                                            
                                        } else if minute >= 10 {
                                            if username == "Mister365b" || username == "mister365b" {
                                                messageModel.addData(comm: thisComm, username: username, message: messageText.trimmingCharacters(in: .whitespacesAndNewlines), commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: imageLink, timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                            } else {
                                                messageModel.addData(comm: thisComm, username: username, message: messageText.trimmingCharacters(in: .whitespacesAndNewlines), commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: imageLink, timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
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
                                                messageModel.addData(comm: thisComm, username: username, message: messageText.trimmingCharacters(in: .whitespacesAndNewlines), commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: imageLink, timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                            } else {
                                                messageModel.addData(comm: thisComm, username: username, message: messageText.trimmingCharacters(in: .whitespacesAndNewlines), commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: imageLink, timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                            }
                                            
                                            
                                        } else if minute >= 10 {
                                            if username == "Mister365b" || username == "mister365b" {
                                                messageModel.addData(comm: thisComm, username: username, message: messageText.trimmingCharacters(in: .whitespacesAndNewlines), commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: imageLink, timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                            } else {
                                                messageModel.addData(comm: thisComm, username: username, message: messageText.trimmingCharacters(in: .whitespacesAndNewlines), commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: imageLink, timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
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
                    
                    
                    HStack {
                    
        
                        
                        Spacer()
                        
                        
                        Button {
                            emojiView = true
                        } label: {
                            Image(systemName: "face.smiling.fill")
                                .foregroundColor(.yellow)
                                .font(.title)
                        }
                        .sheet(isPresented: $emojiView) {
                            ScrollView {
                                
                                VStack {
                                    Text("Select an Emoji")
                                        .fontWeight(.bold)
                                        .font(.title)
                          
                                    Spacer()
                                    
                                    
                                    
                                    
                                    HStack {
                                        Spacer()
                                        Button {
                                          sures = true
                                        } label: {
                                            Image("Happy")
                                        }
                                        .alert("Are you sure?", isPresented: $sures) {
                                            
                                            Button("Yes") {
                                                let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
                                                let hour = components.hour ?? 0
                                                let minute = components.minute ?? 0
                                                
                                                
                                                if minute < 10 {
                                                    
                                                    if username == "Mister365b" || username == "mister365b" {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Happy", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                        sures = false
                                                    } else {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Happy", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                        sures = false
                                                    }
                                                } else if minute >= 10 {
                                                    if username == "Mister365b" || username == "mister365b" {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Happy", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                        sures = false
                                                    } else {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Happy", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                        sures = false
                                                    }
                                                }
                                                emojiView = false
                                            }
                                            
                                            Button("No") {
                                                
                                            }
                                        } message: {
                                            Text("Are you sure you wanna send this emoji? This can't be undone! You can't attach text to this message.")
                                        }
                                        Spacer()
                                        Button {
                                            sures2 = true
                                        } label: {
                                            Image("Sad")
                                        }
                                        .alert("Are you sure?", isPresented: $sures2) {
                                            
                                            Button("Yes") {
                                                let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
                                                let hour = components.hour ?? 0
                                                let minute = components.minute ?? 0
                                                
                                                
                                                if minute < 10 {
                                                    
                                                    if username == "Mister365b" || username == "mister365b" {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Sad", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                        sures2 = false
                                                    } else {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Sad", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                        sures2 = false
                                                    }
                                                } else if minute >= 10 {
                                                    if username == "Mister365b" || username == "mister365b" {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Sad", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                        sures2 = false
                                                    } else {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Sad", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                        sures2 = false
                                                    }
                                                }
                                                emojiView = false
                                            }
                                            
                                            Button("No") {
                                                
                                            }
                                        } message: {
                                            Text("Are you sure you wanna send this emoji? This can't be undone! You can't attach text to this message.")
                                        }
                                        Spacer()
                                    }
                                    
                                    
                                    HStack {
                                        Spacer()
                                        Button {
                                            sures3 = true
                                        } label: {
                                            Image("Angry")
                                        }
                                        .alert("Are you sure?", isPresented: $sures3) {
                                            
                                            Button("Yes") {
                                                let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
                                                let hour = components.hour ?? 0
                                                let minute = components.minute ?? 0
                                                
                                                
                                                if minute < 10 {
                                                    
                                                    if username == "Mister365b" || username == "mister365b" {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Angry", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                        sures3 = false
                                                    } else {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Angry", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                        sures3 = false
                                                    }
                                                } else if minute >= 10 {
                                                    if username == "Mister365b" || username == "mister365b" {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Angry", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                        sures3 = false
                                                    } else {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Angry", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                        sures3 = false
                                                    }
                                                }
                                                emojiView = false
                                            }
                                            
                                            Button("No") {
                                                
                                            }
                                        } message: {
                                            Text("Are you sure you wanna send this emoji? This can't be undone! You can't attach text to this message.")
                                        }
                                        Spacer()
                                        Button {
                                            sures4 = true
                                        } label: {
                                            Image("Embaressed")
                                        }
                                        .alert("Are you sure?", isPresented: $sures4) {
                                            
                                            Button("Yes") {
                                                let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
                                                let hour = components.hour ?? 0
                                                let minute = components.minute ?? 0
                                                
                                                
                                                if minute < 10 {
                                                    
                                                    if username == "Mister365b" || username == "mister365b" {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Embaressed", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                        sures4 = false
                                                    } else {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Embaressed", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                        sures4 = false
                                                        
                                                    }
                                                } else if minute >= 10 {
                                                    if username == "Mister365b" || username == "mister365b" {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Embaressed", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                        sures4 = false
                                                    } else {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Embaressed", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                        sures4 = false
                                                    }
                                                }
                                                emojiView = false
                                            }
                                            
                                            Button("No") {
                                                
                                            }
                                        } message: {
                                            Text("Are you sure you wanna send this emoji? This can't be undone! You can't attach text to this message.")
                                        }
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Spacer()
                                        Button {
                                            sures5 = true
                                        } label: {
                                            Image("Disgust")
                                        }
                                        .alert("Are you sure?", isPresented: $sures5) {
                                            
                                            Button("Yes") {
                                                let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
                                                let hour = components.hour ?? 0
                                                let minute = components.minute ?? 0
                                                
                                                
                                                if minute < 10 {
                                                    
                                                    if username == "Mister365b" || username == "mister365b" {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Disgust", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                        sures5 = false
                                                    } else {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Disgust", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                        sures5 = false
                                                    }
                                                } else if minute >= 10 {
                                                    if username == "Mister365b" || username == "mister365b" {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Disgust", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                        sures5 = false
                                                    } else {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Disgust", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                        sures5 = false
                                                    }
                                                }
                                                emojiView = false
                                            }
                                            
                                            Button("No") {
                                                
                                            }
                                        } message: {
                                            Text("Are you sure you wanna send this emoji? This can't be undone! You can't attach text to this message.")
                                        }
                                        Spacer()
                                        Button {
                                            sures6 = true
                                        } label: {
                                            Image("Laugh")
                                        }
                                        .alert("Are you sure?", isPresented: $sures6) {
                                            
                                            Button("Yes") {
                                                let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
                                                let hour = components.hour ?? 0
                                                let minute = components.minute ?? 0
                                                
                                                
                                                if minute < 10 {
                                                    
                                                    if username == "Mister365b" || username == "mister365b" {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Laugh", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                        sures6 = false
                                                    } else {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Laugh", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                        sures6 = false
                                                    }
                                                } else if minute >= 10 {
                                                    if username == "Mister365b" || username == "mister365b" {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Laugh", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                        sures6 = false
                                                    } else {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Laugh", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                        sures6 = false
                                                    }
                                                }
                                                emojiView = false
                                            }
                                            
                                            Button("No") {
                                                
                                            }
                                        } message: {
                                            Text("Are you sure you wanna send this emoji? This can't be undone! You can't attach text to this message.")
                                        }
                                        Spacer()
                                    }
                                    
                                    if subscription == "tier 2" {
                                        HStack {
                                            Spacer()
                                            Button {
                                                sures7 = true
                                            } label: {
                                                Image("Scared")
                                            }
                                            .alert("Are you sure?", isPresented: $sures7) {
                                                
                                                Button("Yes") {
                                                    let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
                                                    let hour = components.hour ?? 0
                                                    let minute = components.minute ?? 0
                                                    
                                                    
                                                    if minute < 10 {
                                                        
                                                        if username == "Mister365b" || username == "mister365b" {
                                                            messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Scared", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                            sures7 = false
                                                        } else {
                                                            messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Scared", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                            sures7 = false
                                                        }
                                                    } else if minute >= 10 {
                                                        if username == "Mister365b" || username == "mister365b" {
                                                            messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Scared", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                            sures7 = false
                                                        } else {
                                                            messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Scared", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                            sures7 = false
                                                        }
                                                    }
                                                    emojiView = false
                                                }
                                                
                                                Button("No") {
                                                    
                                                }
                                            } message: {
                                                Text("Are you sure you wanna send this emoji? This can't be undone! You can't attach text to this message.")
                                            }
                                            Spacer()
                                            Button {
                                                sures8 = true
                                            } label: {
                                                Image("Meh")
                                            }
                                            .alert("Are you sure?", isPresented: $sures8) {
                                                
                                                Button("Yes") {
                                                    let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
                                                    let hour = components.hour ?? 0
                                                    let minute = components.minute ?? 0
                                                    
                                                    
                                                    if minute < 10 {
                                                        
                                                        if username == "Mister365b" || username == "mister365b" {
                                                            messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Meh", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                            sures8 = false
                                                        } else {
                                                            messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Meh", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                            sures8 = false
                                                        }
                                                    } else if minute >= 10 {
                                                        if username == "Mister365b" || username == "mister365b" {
                                                            messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Meh", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                            sures8 = false
                                                        } else {
                                                            messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Meh", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                            sures8 = false
                                                        }
                                                    }
                                                    emojiView = false
                                                }
                                                
                                                Button("No") {
                                                    
                                                }
                                            } message: {
                                                Text("Are you sure you wanna send this emoji? This can't be undone! You can't attach text to this message.")
                                            }
                                            Spacer()
                                        }
                                        HStack {
                                            Spacer()
                                            Button {
                                               sures9 = true
                                            } label: {
                                                Image("Cool")
                                            }
                                            .alert("Are you sure?", isPresented: $sures9) {
                                                
                                                Button("Yes") {
                                                    let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
                                                    let hour = components.hour ?? 0
                                                    let minute = components.minute ?? 0
                                                    
                                                    
                                                    if minute < 10 {
                                                        
                                                        if username == "Mister365b" || username == "mister365b" {
                                                            messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Cool", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                            sures9 = false
                                                        } else {
                                                            messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Cool", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                            sures9 = false
                                                        }
                                                    } else if minute >= 10 {
                                                        if username == "Mister365b" || username == "mister365b" {
                                                            messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Cool", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                            sures9 = false
                                                        } else {
                                                            messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Cool", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                            sures9 = false
                                                        }
                                                    }
                                                    emojiView = false
                                                }
                                                
                                                Button("No") {
                                                    
                                                }
                                            } message: {
                                                Text("Are you sure you wanna send this emoji? This can't be undone! You can't attach text to this message.")
                                            }
                                            Spacer()
                                            Button {
                                                sures10 = true
                                            } label: {
                                                Image("Love")
                                            }
                                            .alert("Are you sure?", isPresented: $sures10) {
                                                
                                                Button("Yes") {
                                                    let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
                                                    let hour = components.hour ?? 0
                                                    let minute = components.minute ?? 0
                                                    
                                                    
                                                    if minute < 10 {
                                                        
                                                        if username == "Mister365b" || username == "mister365b" {
                                                            messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Love", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                            sures10 = false
                                                        } else {
                                                            messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Love", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                            sures10 = false
                                                        }
                                                    } else if minute >= 10 {
                                                        if username == "Mister365b" || username == "mister365b" {
                                                            messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Love", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                            sures10 = false
                                                        } else {
                                                            messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Love", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                            sures10 = false
                                                        }
                                                    }
                                                    emojiView = false
                                                }
                                                
                                                Button("No") {
                                                    
                                                }
                                            } message: {
                                                Text("Are you sure you wanna send this emoji? This can't be undone! You can't attach text to this message.")
                                            }
                                            Spacer()
                                        }
                                    }
                                    
                                    
                                }
                                Text("Screenshotting and redistributing this content\nwill result in instant termination of account.\nYou have been warned.")
                                    .fontWeight(.ultraLight)
                                    .font(.caption)
                            }
                        }
                        Spacer()
                    
                    
                    
      
                        Spacer()
                        Button {
                            stickerView = true
                        } label: {
                            ZStack {
                                Image(systemName: "seal.fill")
                                    .foregroundColor(.green)
                                    .font(.title)
                                
                                Image(systemName: "s.circle.fill")
                                    .foregroundColor(.blue)
                                    .font(.title2)
                            }
                        }
                        .sheet(isPresented: $stickerView) {
                            ScrollView {
                                
                                VStack {
                                    Text("Select a Sticker")
                                        .fontWeight(.bold)
                                        .font(.title)
                          
                                    Spacer()
                                    
                                    
                                    VStack {
                                        
                                        
                                    
                                    HStack {
                                        Spacer()
                                        Button {
                                          sures11 = true
                                        } label: {
                                            Image("Panda")
                                                .frame(width: 100, height: 100)
                                        }
                                        .alert("Are you sure?", isPresented: $sures11) {
                                            
                                            Button("Yes") {
                                                let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
                                                let hour = components.hour ?? 0
                                                let minute = components.minute ?? 0
                                                
                                                
                                                if minute < 10 {
                                                    
                                                    if username == "Mister365b" || username == "mister365b" {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Panda", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                        sures11 = false
                                                    } else {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Panda", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                        sures11 = false
                                                    }
                                                } else if minute >= 10 {
                                                    if username == "Mister365b" || username == "mister365b" {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Panda", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                        sures11 = false
                                                    } else {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Panda", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                        sures11 = false
                                                    }
                                                }
                                                stickerView = false
                                            }
                                            
                                            Button("No") {
                                                
                                            }
                                        } message: {
                                            Text("Are you sure you wanna send this sticker? This can't be undone! You can't attach text to this message.")
                                        }
                                        Spacer()
                                        Button {
                                            sures12 = true
                                        } label: {
                                            Image("Plane")
                                                .frame(width: 100, height: 100)
                                        }
                                        .alert("Are you sure?", isPresented: $sures12) {
                                            
                                            Button("Yes") {
                                                let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
                                                let hour = components.hour ?? 0
                                                let minute = components.minute ?? 0
                                                
                                                
                                                if minute < 10 {
                                                    
                                                    if username == "Mister365b" || username == "mister365b" {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Plane", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                        sures12 = false
                                                    } else {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Plane", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                        sures12 = false
                                                    }
                                                } else if minute >= 10 {
                                                    if username == "Mister365b" || username == "mister365b" {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Plane", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                        sures12 = false
                                                    } else {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Plane", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                        sures12 = false
                                                    }
                                                }
                                                stickerView = false
                                            }
                                            
                                            Button("No") {
                                                
                                            }
                                        } message: {
                                            Text("Are you sure you wanna send this plane? This can't be undone! You can't attach text to this message.")
                                        }
                                        Spacer()
                                    }
                                    
                                    
                                    HStack {
                                        Spacer()
                                        Button {
                                            sures13 = true
                                        } label: {
                                            Image("Car")
                                                .frame(width: 100, height: 100)
                                        }
                                        .alert("Are you sure?", isPresented: $sures13) {
                                            
                                            Button("Yes") {
                                                let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
                                                let hour = components.hour ?? 0
                                                let minute = components.minute ?? 0
                                                
                                                
                                                if minute < 10 {
                                                    
                                                    if username == "Mister365b" || username == "mister365b" {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Car", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                        sures13 = false
                                                    } else {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Car", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                        sures13 = false
                                                    }
                                                } else if minute >= 10 {
                                                    if username == "Mister365b" || username == "mister365b" {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Car", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                        sures13 = false
                                                    } else {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Car", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                        sures13 = false
                                                    }
                                                }
                                                stickerView = false
                                            }
                                            
                                            Button("No") {
                                                
                                            }
                                        } message: {
                                            Text("Are you sure you wanna send this sticker? This can't be undone! You can't attach text to this message.")
                                        }
                                        Spacer()
                                        Button {
                                            sures14 = true
                                        } label: {
                                            Image("Clover")
                                                .frame(width: 100, height: 100)
                                        }
                                        .alert("Are you sure?", isPresented: $sures14) {
                                            
                                            Button("Yes") {
                                                let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
                                                let hour = components.hour ?? 0
                                                let minute = components.minute ?? 0
                                                
                                                
                                                if minute < 10 {
                                                    
                                                    if username == "Mister365b" || username == "mister365b" {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Clover", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                        sures14 = false
                                                    } else {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Clover", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                        sures14 = false

                                                    }
                                                } else if minute >= 10 {
                                                    if username == "Mister365b" || username == "mister365b" {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Clover", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                        sures14 = false

                                                    } else {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Clover", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                        sures14 = false

                                                    }
                                                }
                                                stickerView = false
                                            }
                                            
                                            Button("No") {
                                                
                                            }
                                        } message: {
                                            Text("Are you sure you wanna send this sticker? This can't be undone! You can't attach text to this message.")
                                        }
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Spacer()
                                        Button {
                                            sures15 = true
                                        } label: {
                                            Image("Whale")
                                                .frame(width: 100, height: 100)
                                        }
                                        .alert("Are you sure?", isPresented: $sures15) {
                                            
                                            Button("Yes") {
                                                let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
                                                let hour = components.hour ?? 0
                                                let minute = components.minute ?? 0
                                                
                                                
                                                if minute < 10 {
                                                    
                                                    if username == "Mister365b" || username == "mister365b" {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Whale", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                        sures15 = false
                                                    } else {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):0\(minute)", pfp: savedProfilePic, image: "Whale", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                        sures15 = false
                                                    }
                                                } else if minute >= 10 {
                                                    if username == "Mister365b" || username == "mister365b" {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Whale", timestamp: Int(NSDate().timeIntervalSince1970), verified: true, subscription: subscription)
                                                        sures15 = false
                                                    } else {
                                                        messageModel.addData(comm: thisComm, username: username, message: "", commId: thisComm.id, time: "\(hour):\(minute)", pfp: savedProfilePic, image: "Whale", timestamp: Int(NSDate().timeIntervalSince1970), verified: false, subscription: subscription)
                                                        sures15 = false
                                                    }
                                                }
                                                stickerView = false
                                            }
                                            
                                            Button("No") {
                                                
                                            }
                                        } message: {
                                            Text("Are you sure you wanna send this sticker? This can't be undone! You can't attach text to this message.")
                                        }
                                        Spacer()
                                    }
                                    
                                }
                                    
                                }
                  
                                Text("Screenshotting and redistributing this content\nwill result in instant termination of account.\nYou have been warned.")
                                    .fontWeight(.ultraLight)
                                    .font(.caption)
                            }
                        }
                        Spacer()
                    
                    
                }
                        
                    
                    
                 
              
                    
                    
                }
            } else {
                HomeView()
            }
    
    }
    
    init() {
        messageModel.getData(comm: thisComm)
    }
}

struct MessageViewTwo_Previews: PreviewProvider {
    static var previews: some View {
        MessageViewTwo()
    }
}
