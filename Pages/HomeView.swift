//
//  HomeView.swift
//  Skymie
//
//  Created by Nethan on 2/7/22.
//

import SwiftUI
import RevenueCat
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

var num = 0
var thisComm = CommData(id: "", name: "", pic: "", about: "", restricted: "", fiveWords: "", reported: false)


var connectOtherStuff = false

var commSearchie = ""
var commFound:[CommData] = []
struct HomeView: View {
    @State var noWIFI = true
    @StateObject var network = Network()
    @ObservedObject var commModel = CommModel()
    @AppStorage("username") var username = ""
    @AppStorage("firstTime") var firstTime = true
    @ObservedObject var model = UserModel()
    @ObservedObject var messageModel = MessageModel()
    @AppStorage("person") var person = ""
    @AppStorage("savedBio") var savedBio = ""
    @AppStorage("savedFavourites") var savedFavourites = ""
    @AppStorage("savedHobbies") var savedHobbies = ""
    @AppStorage("savedMediaLink") var savedMediaLink = ""
    @AppStorage("favourites") var favourites = ""
 
    @State var colorie = Color.black
    @AppStorage("veryFirstTime") var veryFirstTime = true
    @State private var followers: [String] = UserDefaults.standard.object(forKey: "followers") as? [String] ?? [""]
    @State var exactTime = false
    @State var createCommunity = false
    @State private var blocked: [String] = UserDefaults.standard.object(forKey: "blocked") as? [String] ?? [""]
    @State var commName = ""
    @State var searchedCommView = false
    @State var commPic = ""
    @State var commeSearched = ""
    @State var about = ""
    @State var restrictedGroup = false
    @State private var favComms: [String] = UserDefaults.standard.object(forKey: "favComms") as? [String] ?? []
    @State var searchText = ""
    @State var firstWord = ""
    @State var secondWord = ""
    @State var thirdWord = ""
    @State var fourthWord = ""
    @AppStorage("savedProfilePic") var savedProfilePic = ""
    @State var firstie = false
    @State var fifthWord = ""
    @State var ages = ["Everyone","18 and above"]
    @State var age = "Everyone"
    @State var page = 2
    @State var combined = ""
    @State var donie = false
    @State var sureCreate = false
    @State var unsuccessful = false
    @State var openComm = false
    @State var cannotDelMess = false
    @State var notAllowed = false
    @FocusState var focus: Bool
    @State var messageText = ""
    @AppStorage("pfp") var pfp = ""
    @State var someDate = Date.now
    @State var aboutComm = false
    @State var fullyConnected = true
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timeRemaining = 10800
    @State var commu = [CommData(id: "", name: "", pic: "", about: "", restricted: "", fiveWords: "Scroll up and refresh to load more communities", reported: false)]
    @State var doneIt = false
    @State var yourNotOld = false
    let oneWeekInSeconds = 604_800.0
    var body: some View {

          
                
                if openComm == false {
                    
                    ZStack {
                        
                        if firstTime == true {
                            
                            VStack {
                                
                            }.sheet(isPresented: $firstTime) {
                                VStack {
                                    Spacer()
                                    Spacer()
                                    Text("Welcome to Skies!")
                                        .font(.title)
                                        .fontWeight(.light)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "face.smiling.fill")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 110))
                                    Spacer()
                                    
                                    Text("Welcome to Skies! Explore communities, make \nfriends, discover people, socialise and more!")
                                        .fontWeight(.light)
                                    
                                    
                                    Spacer()
                                    Spacer()
                                    Spacer()
                                    
                                }
                            }
                            
                        } else {
                            
                            NavigationView {
                                VStack {
                                    
                  
                                    LinearGradient(gradient: Gradient(colors: [.blue,.purple, .black]), startPoint: .top, endPoint: .bottom)
                                            .mask(Image(systemName: "cloud.fill"))
                                            .font(.system(size:110))
                                            .frame(width: 200, height: 100)
                                        
                                        HStack {
                                            Spacer()
                                            
                                            
                                            
                                            
                                            Button {
                                                exactTime = true
                                            } label: {
                                                Text(Date.now, format: .dateTime.hour())
                                                    .font(.largeTitle)
                                                    .foregroundColor(.gray)
                                                
                                            }
                                            .buttonStyle(.bordered)
                                            .confirmationDialog("\(Date.now, format: .dateTime.hour().minute().second())", isPresented: $exactTime, titleVisibility: .visible) {
                                                
                                                
                                                
                                            } message: {
                                                Text("This is the exact time right now.")
                                            }
                                            
                                            
                                            
                                            Button {
                                                createCommunity = true
                                            } label: {
                                                Image(systemName: "plus.circle.fill")
                                                    .foregroundColor(.primary)
                                                    .font(.largeTitle)
                                            }
                                            .sheet(isPresented: $createCommunity) {
                                                NavigationView {
                                                    List {
                                                        
                                                        VStack {
                                                            
                                                            Section {
                                                                Spacer()
                                                                Text("Create a Skies \n    Community.")
                                                                    .font(.title)
                                                                    .fontWeight(.bold)
                                                                Spacer()
                                                            }
                                                            HStack {
                                                                Spacer()
                                                                Text("Skies communities are fun!\nGlad that you're making one.")
                                                                    .font(.body)
                                                                    .fontWeight(.light)
                                                                Spacer()
                                                            }
                                                            
                                                        }
                                                        Group {
                                                            
                                                            Section {
                                                                TextField("Community name", text: $commName)
                                                                    .focused($focus)
                                                            }
                                                            
                                                            
                                                            
                                                            Section {
                                                                TextField("Community icon link", text: $commPic)
                                                                    .focused($focus)
                                                            } footer: {
                                                                Text("* Non-copyright")
                                                            }
                                                        }
                                                        
                                                        Group {
                                                            Section {
                                                                TextEditor(text: $about)
                                                                    .focused($focus)
                                                            } header: {
                                                                Text("Community Description (include the rules)")
                                                            }
                                                            
                                                            Section {
                                                                Picker("Age", selection: $age) {
                                                                    ForEach(ages, id: \.self) {
                                                                        Text("\($0)")
                                                                    }
                                                                }
                                                            } header: {
                                                                Text("Target age group")
                                                            }
                                                            
                                                            Section {
                                                                Text("Give five words to describe your community")
                                                                    .font(.title)
                                                                    .fontWeight(.bold)
                                                            }
                                                            
                                                        }
                                                        Group {
                                                            Section {
                                                                TextField("Word 1", text: $firstWord)
                                                                    .focused($focus)
                                                            }
                                                            Section {
                                                                TextField("Word 2", text: $secondWord)
                                                                    .focused($focus)
                                                            }
                                                            Section {
                                                                TextField("Word 3", text: $thirdWord)
                                                                    .focused($focus)
                                                            }
                                                            Section {
                                                                TextField("Word 4", text: $fourthWord)
                                                                    .focused($focus)
                                                            }
                                                            
                                                            Section {
                                                                TextField("Word 5", text: $fifthWord)
                                                                    .focused($focus)
                                                            }
                                                            
                                                            HStack {
                                                                Spacer()
                                                                Button("Submit") {
                                                                
                                                                
                                                                    // code from here again
                                                                    if person == "teenager" && age == "18 and above" {
                                                                        yourNotOld = true
                                                                    } else {
                                                                        
                                                                        
                                                                    
                                                                        
                                                                        if commName != "" && about != "" && commPic != "" && firstWord != "" && secondWord != "" && thirdWord != "" && fourthWord != "" && fifthWord != "" {
                                                                            sureCreate = true
                                                                        } else {
                                                                            unsuccessful = true
                                                                        }
                                                                    }
                                                                }
                                                                .alert("Are you sure you wanna create this community?", isPresented: $sureCreate) {
                                                                    Button("Yes") {
                                                                        
                                                                     
                                                                            combined = "\(firstWord), \(secondWord), \(thirdWord), \(fourthWord), \(fifthWord)"
                                                                            commModel.addData(name: commName, pic: commPic, about: about, restricted: age, fiveWords: combined, reported: false)
                                                                            pfp = commPic
                                                                            combined = ""
                                                                            commName = ""
                                                                            commPic = ""
                                                                            about = ""
                                                                            age = "Everyone"
                                                                            firstWord = ""
                                                                            secondWord = ""
                                                                            thirdWord = ""
                                                                            fourthWord = ""
                                                                            fifthWord = ""
                                                                        createCommunity = false
                                                                        }
                                                                       
                                                                    
                                                                    
                                                                    Button("No") {
                                                                        
                                                                    }
                                                                } message: {
                                                                    Text("You can't delete a community. Make sure a similar community doesn't exist. Only create a community if you think people will think the topic is interesting to discuss. Anyone can message in your community in Skies, there's no private community.")
                                                                }
                                                                .alert("Incomplete fields!", isPresented: $unsuccessful) {
                                                                    
                                                                } message: {
                                                                    Text("Make sure you fill in all fields!")
                                                                }
                                                                .alert("Error!", isPresented: $yourNotOld) {
                                                                    
                                                                } message: {
                                                                    Text("Your not old enough to create an 18+ community")
                                                                }
                                                                Spacer()
                                                            }
                                                        }
                                                        
                                                        
                                                        
                                                        
                                                        
                                                    }
                                                }
                                            }
                                            
                                            if focus == true {
                                                Button("Done") {
                                                    focus = false
                                                }
                                            }
                                            
                                            Spacer()
                                            
                                        }
                                  
                                    
                                    Spacer()
                                    Spacer()
                                    HStack {
                                        Image(systemName: "person.text.rectangle.fill")
                                            .foregroundColor(.red)
                                            .font(.title3)
                                        Text(" -> 18+ community")
                                            .fontWeight(.light)
                                    }
                                    Spacer()
                                    
                                    
                                    Section {
                                    HStack {
                                        TextField("  Search for communities", text: $commeSearched)
                                            .focused($focus)
                                            .frame(width: 300, height: 50)
                                            .border(Color.primary)
                                           
                                        
                                        Button {
                                            
                                     
                                            
                                            commFound.removeAll()
                                            
                                            for comm in commModel.list {
                                              
                                                if comm.name.lowercased() == commeSearched.lowercased() || comm.name.lowercased().contains(commeSearched.lowercased()){
                                                    
                                                    
                                                    commFound.append(comm)
                                                    
                                                    searchedCommView = true
                                                    
                                                      
                                                    
                                                } else {
                                                    if commeSearched != "" {
                                                       
                                                    }
                                                }
                                            }
                                           
                                        } label: {
                                            
                                            Image(systemName: "magnifyingglass.circle.fill")
                                                .font(.title)
                                                .foregroundColor(.secondary)
                                            
                                            
                                        }
                                        .sheet(isPresented: $searchedCommView) {
                                            CommSearchView()
                                        }
                                        
                                        
                                    }
                                    } footer: {
                                        Text("* Nothing happens if you search for an invalid community")
                                            .foregroundColor(.gray)
                                            .font(.caption)
                                    }
                                
                                    Spacer()
                                    Text("Swipe down and refresh this screen in\n↓ the box to load more communities ↓")
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)
                                        .font(.caption)
                             
                                     
                                        NavigationView {
                                            
                                            
                                            List(commu) { community in
                                                
                                                if community.name != "" {
                                                    
                                                    Section {
                                                        HStack {
                                                            
                                                            Button {
                                                                
                                                                for userie in model.list {
                                                                    
                                                                    if userie.username.lowercased() == username.lowercased() {
                                                                        
                                                                        if community.restricted == "18 and above" && userie.person == "teenager" {
                                                                            notAllowed = true
                                                                        } else {
                                                                            
                                                                            thisComm = community
                                                                            openComm = true
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
                                                                        
                                                                        HStack {
                                                                            Text("\(community.name)")
                                                                                .foregroundColor(Color.primary)
                                                                                .fontWeight(.bold)
                                                                                .font(.title)
                                                                            
                                                                            if community.id == "5lXw4ap7feRKN83rhIcw" {
                                                                                Image(systemName: "checkmark.seal.fill")
                                                                                    .foregroundColor(.gray)
                                                                                    .font(.title)
                                                                            }
                                                                            
                                                                        }
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
                                                            .navigationTitle("Communities")
                                                            
                                                            
                                                        }
                                                        HStack {
                                                            Spacer()
                                                            Button {
                                                                if favComms.contains(community.name) {
                                                                    favComms.removeAll { fav in
                                                                        return fav == community.name
                                                                    }
                                                                    
                                                                    UserDefaults.standard.set(favComms, forKey: "favComms")
                                                                } else {
                                                                    favComms.append(community.name)
                                                                    UserDefaults.standard.set(favComms, forKey: "favComms")
                                                                }
                                                            } label: {
                                                                
                                                                if favComms.contains(community.name) {
                                                                    Image(systemName: "star.fill")
                                                                        .font(.title)
                                                                        .foregroundColor(.pink)
                                                                } else {
                                                                    Image(systemName: "star")
                                                                        .font(.title)
                                                                        .foregroundColor(.pink)
                                                                }
                                                                
                                                            }
                                                        }
                                                    }
                                                    .navigationViewStyle(.stack)
                                                    
                                                }
                                            }
                                            
                                            .onAppear {
                                                network.checkConnection()
                                                commModel.getData()
                                            }
                                            
                                            .refreshable {
                                                
                                                
                                                colorie = Color.white
                                          
                                                
                                                
                                                network.checkConnection()
                                                
                                                commModel.getData()
                                                model.getData()
                                                
                                                
                                                if donie == false {
                                                    if commu.count < 2 {
                                                        
                                                        for comie in commModel.list {
                                                            
                                                            
                                                            commu.append(comie)
                                                            
                                                            donie = true
                                                        }
                                                        print(commu)
                                                    }
                                                }
                                                
                                                
                                            }
                                            
                                            .onReceive(network.$connected, perform: { connected in
                                                
                                                print(connected)
                                            })
                                            
                                        }
                                        .border(colorie)
                                    
                                        
                                    
                          
                                }
                       
                             
                            }
                            .navigationViewStyle(.stack)
                      
                            
                        }
                    }
                    
           
                    .onAppear {
                        
               
                        commModel.getData()
               
                        
                                               if donie == false {
                            if commu.count < 2 {
                                
                                for comie in commModel.list {
                                    
                                    
                                    commu.append(comie)
                                    donie = true
                                }
                                print(commu)
                                
                            }
                        }
                        
                    
                        
                    }
                } else {
                    MessageView()
                }
      
            
        
        
    }
    
  

    init() { // On this initialisation of this view, we get the data
        
        model.getData()
        commModel.getData()
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
        
        veryFirstTime = false
        
        
        
        firstie = false
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
