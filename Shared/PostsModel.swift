//
//  PostsModel.swift
//  Skymie
//
//  Created by Nethan on 10/7/22.
//

import Foundation
import Firebase

class PostsModel: ObservableObject {
    @Published var list = [PostsData]()
    
    func updateData(postToUpdate: PostsData, edit: String) {
        // Get a reference to the database
        let db = Firestore.firestore()
        // Set the data to update
        db.collection("posts").document(postToUpdate.id).setData(["post": "\(edit)"], merge: true) { error in
            // the merge specifies whether we should blow away all data in the document and the replace with new data, or keep the data that isn't being replaced and only change the data that we want to update
            
            
            // Check for errors
            
            if error == nil {
                self.getData()
            }
        } // I can update multiple pieces of data in my document or just 1
    }
    func report(postToUnreport: PostsData, reportStatus: Bool) {
        // Get a reference to the database
        let db = Firestore.firestore()
        // Set the data to update
        db.collection("posts").document(postToUnreport.id).setData(["reported": reportStatus], merge: true) { error in
            // the merge specifies whether we should blow away all data in the document and the replace with new data, or keep the data that isn't being replaced and only change the data that we want to update
            
            
            // Check for errors
            
            if error == nil {
                self.getData()
            }
        } // I can update multiple pieces of data in my document or just 1
    }

    func deleteData(postToDelete: PostsData) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        // Specify the document to delete
        db.collection("posts").document(postToDelete.id).delete { error in
            // Check for errors
            if error == nil {
               // No errors
                
                DispatchQueue.main.async { // Update UI from main thread
                    
                
                // Remove todo that was just deleted
                self.list.removeAll { post in
                    // Check for the todo to remove
                    return post.id == postToDelete.id
                }
                    
                }
            }
            
        }
        
    }
    
    func addData(username: String, post: String, date: String, reported: Bool, imageURL: String, pfp: String, verified: Bool) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        // Add a document to a collection
        db.collection("posts").addDocument(data: ["username": username, "post": post, "date": date, "reported": reported, "imageURL": imageURL, "pfp": pfp, "verified": verified]) { error in
            // We don't have to worry about the ID for this new document because it'll automatically be generated
            
            // data is stored in a dictionary, with the data label followed by the value, which in this
            // case is our argument, name!
            
            // Check for errors
            
            
            
            if error == nil {
                // No errors
                
                self.getData()
                
            } else {
                // Handle the error
            }
            
        }
        
    }
    
    func getData() {
        

        
        
        // Get a reference to the database
        let db = Firestore.firestore()
        // Read the documents at a specific path
        db.collection("posts").getDocuments { snapshot, error in // Snap shot gets the documents from firebase. Error is any errors that many occur
            
            // Check for errors
            
            if error == nil {
                // No errors
                
                if let snapshot = snapshot { // check is snapshot is nil
                    
                    DispatchQueue.main.async { // Update the list property in the main thread
                    
                        self.list = snapshot.documents.map { doc in // Goes through each element in array of documents in snapshot one by one
                        
                    // it assigns all the documents to the variable, list, which saved it in an array
                        
                        
                        
                        
                      // Create a Todo item for each document returned
                            return PostsData(id: doc.documentID, username: doc["username"] as? String ?? "", post: doc["post"] as? String ?? "", date: doc["date"] as? String ?? "", imageURL: doc["imageURL"] as? String ?? "", reported: doc["reported"] as? Bool ?? false, pfp: doc["pfp"] as? String ?? "", verified: doc["verified"] as? Bool ?? false)
                    }
                    }
                }
                
            } else {
                // Handle the error
            }
            
        } // Getting the collection from firebase. Must put collection name as string
        
        
    }
    
}
