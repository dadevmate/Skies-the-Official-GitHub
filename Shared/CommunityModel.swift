//
//  CommunityModel.swift
//  Skymie
//
//  Created by Nethan on 13/10/22.
//


import Foundation
import Firebase

class CommModel: ObservableObject {
    @Published var list = [CommData]()

    func report(commToUnreport: CommData, reportStatus: Bool) {
        // Get a reference to the database
        let db = Firestore.firestore()
        // Set the data to update
        db.collection("communities").document(commToUnreport.id).setData(["reported": reportStatus], merge: true) { error in
            // the merge specifies whether we should blow away all data in the document and the replace with new data, or keep the data that isn't being replaced and only change the data that we want to update
            
            
            // Check for errors
            
            if error == nil {
                self.getData()
            }
        } // I can update multiple pieces of data in my document or just 1
    }

    func deleteData(commToDelete: CommData) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        // Specify the document to delete
        db.collection("communities").document(commToDelete.id).delete { error in
            // Check for errors
            if error == nil {
               // No errors
                
                DispatchQueue.main.async { // Update UI from main thread
                    
                
                // Remove todo that was just deleted
                self.list.removeAll { community in
                    // Check for the todo to remove
                    return community.id == commToDelete.id
                }
                    
                }
            }
            
        }
        
    }
    
    func addData(name: String, pic: String, about: String, restricted: String, fiveWords: String, reported: Bool) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        // Add a document to a collection
        db.collection("communities").addDocument(data: ["name": name, "pic": pic, "about": about, "restricted": restricted, "fiveWords": fiveWords, "reported": reported]) { error in
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
        db.collection("communities").getDocuments { snapshot, error in // Snap shot gets the documents from firebase. Error is any errors that many occur
            
            // Check for errors
            
            if error == nil {
                // No errors
                
                if let snapshot = snapshot { // check is snapshot is nil
                    
                    DispatchQueue.main.async { // Update the list property in the main thread
                    
                        self.list = snapshot.documents.map { doc in // Goes through each element in array of documents in snapshot one by one
                        
                    // it assigns all the documents to the variable, list, which saved it in an array
                        
                        
                        
                        
                      // Create a Todo item for each document returned
                            return CommData(id: doc.documentID, name: doc["name"] as? String ?? "", pic: doc["pic"] as? String ?? "", about: doc["about"] as? String ?? "", restricted: doc["restricted"] as? String ?? "", fiveWords: doc["fiveWords"] as? String ?? "", reported: doc["reported"] as? Bool ?? false)
                    }
                    }
                }
                
            } else {
                // Handle the error
            }
            
        } // Getting the collection from firebase. Must put collection name as string
        
        
    }
    
}

