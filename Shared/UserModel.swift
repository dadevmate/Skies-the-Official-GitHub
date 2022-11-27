//
//  UserModel.swift
//  Skymie
//
//  Created by Nethan on 3/7/22.
//

import Foundation
import Firebase


class UserModel: ObservableObject {
    @Published var list = [UserData]()
    
    func deleteData(user: UserData) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        // Specify the document to delete
        db.collection("users").document(user.id).delete { error in
            // Check for errors
            if error == nil {
               // No errors
                
                DispatchQueue.main.async { // Update UI from main thread
                    
                
                // Remove todo that was just deleted
                self.list.removeAll { userie in
                    // Check for the todo to remove
                    
                    return userie.id == user.id
                }
                    
                }
            }
            
        }
        
    }
    func updateData(userUpdate: UserData, edit: String) {
        // Get a reference to the database
        let db = Firestore.firestore()
        // Set the data to update
        db.collection("users").document(userUpdate.id).setData(["bio": "\(edit)"], merge: true) { error in
            // the merge specifies whether we should blow away all data in the document and the replace with new data, or keep the data that isn't being replaced and only change the data that we want to update
            
            
            // Check for errors
            
            if error == nil {
                self.getData()
            }
        } // I can update multiple pieces of data in my document or just 1
    }
    
    func updateFavourites(userUpdate: UserData, edit: String) {
        // Get a reference to the database
        let db = Firestore.firestore()
        // Set the data to update
        db.collection("users").document(userUpdate.id).setData(["favourites": "\(edit)"], merge: true) { error in
            // the merge specifies whether we should blow away all data in the document and the replace with new data, or keep the data that isn't being replaced and only change the data that we want to update
            
            
            // Check for errors
            
            if error == nil {
                self.getData()
            }
        } // I can update multiple pieces of data in my document or just 1
    }
    
    func updateHobbies(userUpdate: UserData, edit: String) {
        // Get a reference to the database
        let db = Firestore.firestore()
        // Set the data to update
        db.collection("users").document(userUpdate.id).setData(["hobbies": "\(edit)"], merge: true) { error in
            // the merge specifies whether we should blow away all data in the document and the replace with new data, or keep the data that isn't being replaced and only change the data that we want to update
            
            
            // Check for errors
            
            if error == nil {
                self.getData()
            }
        } // I can update multiple pieces of data in my document or just 1
    }
    
    func updateSubscription(userUpdate: UserData, edit: String) {
        // Get a reference to the database
        let db = Firestore.firestore()
        // Set the data to update
        db.collection("users").document(userUpdate.id).setData(["subscription": "\(edit)"], merge: true) { error in
            // the merge specifies whether we should blow away all data in the document and the replace with new data, or keep the data that isn't being replaced and only change the data that we want to update
            
            
            // Check for errors
            
            if error == nil {
                self.getData()
            }
        } // I can update multiple pieces of data in my document or just 1
    }
    
    func updateMediaLink(userUpdate: UserData, edit: String) {
        // Get a reference to the database
        let db = Firestore.firestore()
        // Set the data to update
        db.collection("users").document(userUpdate.id).setData(["mediaLink": "\(edit)"], merge: true) { error in
            // the merge specifies whether we should blow away all data in the document and the replace with new data, or keep the data that isn't being replaced and only change the data that we want to update
            
            
            // Check for errors
            
            if error == nil {
                self.getData()
            }
        } // I can update multiple pieces of data in my document or just 1
    }
    
    func updatePfp(userUpdate: UserData, edit: String) {
        // Get a reference to the database
        let db = Firestore.firestore()
        // Set the data to update
        db.collection("users").document(userUpdate.id).setData(["pfp": "\(edit)"], merge: true) { error in
            // the merge specifies whether we should blow away all data in the document and the replace with new data, or keep the data that isn't being replaced and only change the data that we want to update
            
            
            // Check for errors
            
            if error == nil {
                self.getData()
            }
        } // I can update multiple pieces of data in my document or just 1
    }
 

    func addData(username: String, person: String, password:String, bio:String, favourites:String, hobbies: String, mediaLink: String, pfp: String, verified: Bool, subscription: String) {
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Add a document to a collection
        db.collection("users").addDocument(data: ["username": username, "person": person, "password": password, "bio": bio, "favourites": favourites, "hobbies": hobbies, "mediaLink": mediaLink, "pfp": pfp, "verified": verified, "subscription": subscription]) { error in
            // We don't have to worry about the ID for this new document because it'll automatically be generated
            
            // data is stored in a dictionary, with the data label followed by the value, which in this
            // case is our argument, name!
            
            // Check for errors
            
            if error == nil {
                // No errors
                
                self.getData()
                print("ERROR")
            } else {
                // Handle the error
            }
            
        }
        
    }
    
    func getData() {
        

        
        
        // Get a reference to the database
        let db = Firestore.firestore()
        // Read the documents at a specific path
        db.collection("users").getDocuments { snapshot, error in // Snap shot gets the documents from firebase. Error is any errors that many occur
            
            // Check for errors
            
            if error == nil {
                // No errors
                
                if let snapshot = snapshot { // check is snapshot is nil
                    
                    DispatchQueue.main.async { // Update the list property in the main thread
                    
                    self.list = snapshot.documents.map { doc in // Goes through each element in array of documents in snapshot one by one
                        
                    // it assigns all the documents to the variable, list, which saved it in an array
                        
                        
                        
                        
                        
                      // Create a Todo item for each document returned
                        return UserData(id: doc.documentID, username: doc["username"] as? String ?? "", person: doc["person"] as? String ?? "", password: doc["password"] as? String ?? "", bio: doc["bio"] as? String ?? "", favourites: doc["favourites"] as? String ?? "", hobbies: doc["hobbies"] as? String ?? "",  mediaLink: doc["mediaLink"] as? String ?? "", pfp: doc["pfp"] as? String ?? "", verified: doc["verified"] as? Bool ?? false, subscription: doc["subscription"] as? String ?? "")
                    }
                    }
                }
                
            } else {
                // Handle the error
            }
            
        } // Getting the collection from firebase. Must put collection name as string
        
        
    }
    
}

