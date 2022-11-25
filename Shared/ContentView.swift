//
//  ContentView.swift
//  Shared
//
//  Created by Nethan on 2/7/22.
//

import SwiftUI
import CryptoKit
import Firebase


struct ContentView: View {
    
    @AppStorage("newUser10") var newUser = true
    @ObservedObject var model = UserModel()
    @AppStorage("password") var password = ""
    @State var enteredPassword = ""
     @AppStorage("username") var username = ""
    @State var enteredUsername = ""
    @State private var tipPercentage = "5 to 15"
    @FocusState var focus:Bool
    let tipPercentages = ["5 to 12", "13 to 20", ">20"]
    @State var pleaseUsername = false
    @State var age = "Less than 13"
    @State var ages = ["Less than 13","13 to 17","18 and above"]
    @AppStorage("person") var person = ""
    @State var notOld = false
    @StateObject var network = Network()
    @State var shortPass = false
    @State var confirmPassword = ""
    @AppStorage("veryFirstTime") var veryFirstTime = true
    @AppStorage("notOldEnough3") var notOldEnough = false
    @State var passwordNoMatch = false
    @State var duplicateUsername = false
    @State var loginSheet = false
    @State var loginUsername = ""
    @State var loginPassword = ""
    @State var loginFailed =  false
    @State var forgot = false
    @AppStorage("savedBio") var savedBio = ""
    @AppStorage("savedFavourites") var savedFavourties = ""
    @AppStorage("savedHobbies") var savedHobbies = ""
    @AppStorage("savedMediaLink") var savedMediaLink = ""
    var body: some View {
        NavigationView {
        VStack {
            
            if network.connected == true {
                
                if notOldEnough == true {
                    NotOldView()
                }
                
                if newUser == false {
                    
                    NavBar()
                    
                } else if notOldEnough != true {
                    
                    VStack {
                        
                        LinearGradient(gradient: Gradient(colors: [.blue,.purple, .black]), startPoint: .top, endPoint: .bottom)
                                .mask(Image(systemName: "cloud.fill"))
                                .font(.system(size:110))
                                .frame(width: 200, height: 100)
                        
                        Spacer()
                        
                        Text("Skies")
                            .fontWeight(.bold)
                            .font(.largeTitle)
                        Text("Start socialising. \n          Easily.")
                        
                        
                        Spacer()
                        
                        Button {
                            network.checkConnection()
                            
                            if network.connected == true {
                                loginSheet = true
                            }
                        } label: {
                            Text("Already have an account? Login!")
                        }
                        Spacer()
                        Spacer()
                        VStack {
                            
                            
                            
                            Text("Sign up!")
                                .font(.title)
                                .fontWeight(.medium)
                            
                      
                            
                            TextField("Enter a username", text: $enteredUsername)
                                .textFieldStyle(.roundedBorder)
                                .frame(width: 300)
                                .focused($focus)
                            SecureField("Enter a password", text: $enteredPassword)
                                .textFieldStyle(.roundedBorder)
                                .frame(width: 300)
                                .focused($focus)
                            SecureField("Confirm password", text: $confirmPassword)
                                .textFieldStyle(.roundedBorder)
                                .frame(width: 300)
                                .focused($focus)
                            
                            Spacer()
                            
                            Section {
                                Picker("Age", selection: $age) {
                                    ForEach(ages, id: \.self) {
                                        Text("\($0)")
                                    }
                                }
                                .frame(width: 300)
                                .pickerStyle(.segmented)
                            } header: {
                                Text("Tell us your age:")
                                    .font(.footnote)
                            }
                            Link("By Signing up, you agree to our\nTerms of Service & Privacy Policy.\nClick here to view them.",
                                 destination: URL(string: "https://www.example.com/TOS.html")!)
                            
                            .font(.footnote)
                            
                            
                            Spacer()
                            Button {
                                network.checkConnection()
                                
                                if network.connected == true {
                                    
                                    if enteredUsername != "" && enteredPassword != "" {
                                        for userie in model.list {
                                            if userie.username.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == enteredUsername.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) {
                                                duplicateUsername = true
                                            }
                                        }
                                        
                                        if duplicateUsername == false {
                                            if enteredPassword.count >= 10 {
                                                
                                                
                                                
                                                if enteredPassword == confirmPassword {
                                                    
                                                    if age != "Less than 13" {
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        newUser = false
                                                        if age == "13 to 17" {
                                                            person = "teenager"
                                                            password = enteredPassword
                                                            username = enteredUsername
                                                            let password2 = password
                                                            let data = Data(password2.utf8)
                                                            let digest = SHA256.hash(data: data)
                                                            let hash = digest.compactMap{String(format:"%02x", $0)}.joined()
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            model.addData(username: username, person: person, password: hash, bio: "", favourites: "", hobbies: "", mediaLink: "", pfp: "", verified: false)
                                                            
                                                            
                                                        } else {
                                                            person = "adult"
                                                            password = enteredPassword.trimmingCharacters(in: .whitespacesAndNewlines)
                                                            let actualUsername = enteredUsername.trimmingCharacters(in: .whitespacesAndNewlines)
                                                            username = actualUsername
                                                            let password2 = password
                                                            let data = Data(password2.utf8)
                                                            let digest = SHA256.hash(data: data)
                                                            let hash = digest.compactMap{String(format:"%02x", $0)}.joined()
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            model.addData(username: username, person: person, password: hash, bio: "", favourites: "", hobbies: "", mediaLink: "", pfp: "", verified: false)
                                                            Auth.auth().createUser(withEmail: username, password: password) { result, err in
                                                                
                                                                if let err = err {
                                                                    print("failed to create user", err)
                                                                    return
                                                                }
                                                                
                                                                print("SUCCESSFULLY CREATED USER")
                                                                
                                                            }
                                                            
                                                        }
                                                    } else {
                                                        notOld = true
                                                        notOldEnough = true
                                                    }
                                                } else {
                                                    passwordNoMatch = true
                                                }
                                            } else {
                                                shortPass = true
                                            }
                                        }
                                    } else {
                                        pleaseUsername = true
                                    }
                                } else {
                                    print("NOT CONNECTEDDDD")
                                }
                            } label: {
                                Text("Let's go!")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                                
                                
                            }
                            
                            .buttonStyle(.bordered)
                            .confirmationDialog("Please make sure to fill in everything.", isPresented: $pleaseUsername, titleVisibility: .visible) {
                                
                            } message: {
                                Text("You have missing fields. Please try again.")
                            }
                            .confirmationDialog("You are not old enough!", isPresented: $notOld, titleVisibility: .visible) {
                                
                            } message: {
                                Text("You are not old enough to join Skies. Please delete this app and come back when you're older.")
                            }
                            .confirmationDialog("Short password", isPresented: $shortPass, titleVisibility: .visible) {
                                
                            } message: {
                                Text("You have a short password. Please enter a password that is at least 10 characters long.")
                            }
                            .confirmationDialog("Passwords do not match", isPresented: $passwordNoMatch, titleVisibility: .visible) {
                                
                            } message: {
                                Text("Your passwords do not match. Please try again.")
                            }
                            .confirmationDialog("This username is not available.", isPresented: $duplicateUsername, titleVisibility: .visible) {
                                
                            } message: {
                                Text("Someone has already taken this username. Please try another username.")
                            }
                            .sheet(isPresented: $loginSheet) {
                                NavigationView {
                                    VStack {
                                        
                                        VStack {
                                            Spacer()
                                            Text("Login")
                                                .font(.largeTitle)
                                                .fontWeight(.light)
                                            
                                            Text("Welcome back to Skies.")
                                                .font(.body)
                                                .fontWeight(.ultraLight)
                                            Spacer()
                                            Spacer()
                                            Spacer()
                                            
                                        }
                                        Spacer()
                                        
                                        TextField("Username", text: $loginUsername)
                                            .textFieldStyle(.roundedBorder)
                                            .frame(width: 300)
                                            .focused($focus)
                                        SecureField("Password", text: $loginPassword)
                                            .textFieldStyle(.roundedBorder)
                                            .frame(width: 300)
                                            .focused($focus)
                                        
                                        Spacer()
                                        
                                        Button {
                                            
                                            network.checkConnection()
                                            
                                            if network.connected == true {
                                                let password2 = loginPassword
                                                let data = Data(password2.utf8)
                                                let digest = SHA256.hash(data: data)
                                                let hash = digest.compactMap{String(format:"%02x", $0)}.joined()
                                                for userie in model.list {
                                                    
                                                    
                                                    if userie.username.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == loginUsername.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) && userie.password == hash {
                                                        username = loginUsername
                                                        password = loginPassword
                                                        person = userie.person
                                                        savedBio = userie.bio
                                                        savedFavourties = userie.favourites
                                                        savedHobbies = userie.hobbies
                                                        savedMediaLink = userie.mediaLink
                                                        newUser = false
                                                    } else {
                                                        loginFailed = true
                                                    }
                                                }
                                            }
                                        } label: {
                                            
                                            Text("Login")
                                                .font(.title2)
                                                .foregroundColor(.gray)
                                            
                                        }
                                        .buttonStyle(.bordered)
                                        .confirmationDialog("Your username or password is incorrect!", isPresented: $loginFailed, titleVisibility: .visible) {
                                            
                                        } message: {
                                            Text("It seems either your username, password or both is incorrect. Please try to login again.")
                                        }
                                        Spacer()
                                        
                                        Button("Forgot password?") {
                                            forgot = true
                                        }
                                        .alert("Forgot your password?", isPresented: $forgot) {
                                    
                                        } message: {
                                            Text("Please email nerellanethan@gmail.com with your username and give us 1-2 business days to get back to you.")
                                        }
                                        Spacer()
                                        Spacer()
                                        
                                    }
                                    
                                }
                            }
                            
                            Spacer()
                            
                            
                        }
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                Button("Done") {
                                    focus = false
                                }
                                .foregroundColor(.blue)
                            }
                        
                    }
                }
                    .onAppear {
                        network.checkConnection()
                    }
                
                    .onReceive(network.$connected, perform: { connected in
                      
                        print(connected)
                    })
                    
             
                }
            } else {
               NoConnectionView()
            }
            }
        .onAppear {
            network.checkConnection()
        }
        }
       
        .navigationViewStyle(.stack)
        
        }
    init() { // On this initialisation of this view, we get the data
        model.getData()
        
      
    }

      
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

