//
//  AboutModel.swift
//  Skymie
//
//  Created by Nethan on 8/10/22.
//



import Foundation
import Firebase

class AboutModel: ObservableObject {
    @Published var list = [AboutData]()
    
    func updateData(aboutToUpdate: AboutData, edit: String) {
        // Get a reference to the database
        let db = Firestore.firestore()
        // Set the data to update
        db.collection("abouts").document(aboutToUpdate.id).setData(["about": "\(edit)"], merge: true) { error in
            // the merge specifies whether we should blow away all data in the document and the replace with new data, or keep the data that isn't being replaced and only change the data that we want to update
            
            
            // Check for errors
            
            if error == nil {
                self.getData()
            }
        } // I can update multiple pieces of data in my document or just 1
    }
    func report(aboutToUnreport: AboutData, reportStatus: Bool) {
        // Get a reference to the database
        let db = Firestore.firestore()
        // Set the data to update
        db.collection("abouts").document(aboutToUnreport.id).setData(["reported": reportStatus], merge: true) { error in
            // the merge specifies whether we should blow away all data in the document and the replace with new data, or keep the data that isn't being replaced and only change the data that we want to update
            
            
            // Check for errors
            
            if error == nil {
                self.getData()
            }
        } // I can update multiple pieces of data in my document or just 1
    }

    func deleteData(aboutToDelete: AboutData) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        // Specify the document to delete
        db.collection("abouts").document(aboutToDelete.id).delete { error in
            // Check for errors
            if error == nil {
               // No errors
                
                DispatchQueue.main.async { // Update UI from main thread
                    
                
                // Remove todo that was just deleted
                self.list.removeAll { about in
                    // Check for the todo to remove
                    return about.id == aboutToDelete.id
                }
                    
                }
            }
            
        }
        
    }
    
    func addData(username: String, about: String, date: String, reported: Bool, imageURL: String, pfp: String, verified: Bool, subscription: String, timestamp: Int) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        // Add a document to a collection
        db.collection("abouts").addDocument(data: ["username": username, "about": about, "date": date, "reported": reported, "imageURL": imageURL, "pfp": pfp, "verified": verified, "subscription": subscription, "timestamp": timestamp]) { error in
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
        db.collection("abouts").getDocuments { snapshot, error in // Snap shot gets the documents from firebase. Error is any errors that many occur
            
            // Check for errors
            
            if error == nil {
                // No errors
                
                if let snapshot = snapshot { // check is snapshot is nil
                    
                    DispatchQueue.main.async { // Update the list property in the main thread
                    
                        self.list = snapshot.documents.map { doc in // Goes through each element in array of documents in snapshot one by one
                        
                    // it assigns all the documents to the variable, list, which saved it in an array
                        
                        
                        
                        
                      // Create a Todo item for each document returned
                            return AboutData(id: doc.documentID, username: doc["username"] as? String ?? "", about: doc["about"] as? String ?? "", date: doc["date"] as? String ?? "", imageURL: doc["imageURL"] as? String ?? "", reported: doc["reported"] as? Bool ?? false, pfp: doc["pfp"] as? String ?? "", verified: doc["verified"] as? Bool ?? false, subscription: doc["subscription"] as? String ?? "", timestamp: doc["timestamp"] as? Int ?? 0)
                    }
                    }
                }
                
            } else {
                // Handle the error
            }
            
        } // Getting the collection from firebase. Must put collection name as string
        
        
    }
    
}
