//
//  DeletedUserModel.swift
//  Skymie
//
//  Created by Nethan on 23/11/22.
//


import Foundation
import Firebase

class DeletedUserModel: ObservableObject {
    @Published var list = [DeletedUserData]()
    
   

 
    
    func addData(username: String) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        // Add a document to a collection
        db.collection("deletedUsers").addDocument(data: ["username": username]) { error in
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
        db.collection("deletedUsers").getDocuments { snapshot, error in // Snap shot gets the documents from firebase. Error is any errors that many occur
            
            // Check for errors
            
            if error == nil {
                // No errors
                
                if let snapshot = snapshot { // check is snapshot is nil
                    
                    DispatchQueue.main.async { // Update the list property in the main thread
                    
                        self.list = snapshot.documents.map { doc in // Goes through each element in array of documents in snapshot one by one
                        
                    // it assigns all the documents to the variable, list, which saved it in an array
                        
                        
                        
                        
                      // Create a Todo item for each document returned
                            return DeletedUserData(id: doc.documentID, username: doc["username"] as? String ?? "")
                    }
                    }
                }
                
            } else {
                // Handle the error
            }
            
        } // Getting the collection from firebase. Must put collection name as string
        
        
    }
 
    
}
