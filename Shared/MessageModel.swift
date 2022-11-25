//
//  MessageModel.swift
//  Skymie
//
//  Created by Nethan on 24/10/22.
//

import Foundation
import Firebase

class MessageModel: ObservableObject {
    
    @Published var list = [MessageData]()
    
    func deleteData(theComm: CommData, messageToDelete: MessageData) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        // Specify the document to delete
        db.collection("communities").document(theComm.id).collection("messages").document(messageToDelete.id).delete { error in
            // Check for errors
            if error == nil {
               // No errors
                
                DispatchQueue.main.async { // Update UI from main thread
                    
                
                // Remove todo that was just deleted
                self.list.removeAll { message in
                    // Check for the todo to remove
                    
                    return message.id == messageToDelete.id
                }
                    
                }
            }
            
        }
        
    }
    
    func order(comm: CommData) -> Query {
        let db = Firestore.firestore()
        // My top posts by number of stars
        let myTopPostsQuery = db.collection("communities").document(comm.id).collection("messages").order(by: "timestamp")
        
      
     
        return myTopPostsQuery
    }

    
    func addData(comm: CommData, username: String, message: String, commId: String, time: String, pfp: String, image: String, timestamp: Int, verified: Bool) {
        // Get a reference to the database
        let db = Firestore.firestore()
        // Add a document to a collection
        db.collection("communities").document(comm.id).collection("messages").addDocument(data: ["username": username, "message": message, "commId": commId, "time": time, "pfp": pfp, "image": image, "timestamp": timestamp, "verified": verified]) { error in
            // We don't have to worry about the ID for this new document because it'll automatically be generated
            
            // data is stored in a dictionary, with the data label followed by the value, which in this
            // case is our argument, name!
            
            // Check for errors
            
            
            
            if error == nil {
                // No errors
                
                self.getData(comm: comm)
                
            } else {
                // Handle the error
            }
            
        }
       
    }
    
    func getData(comm: CommData) {
        

        
        
        // Get a reference to the database
        let db = Firestore.firestore()
        // Read the documents at a specific path
        db.collection("communities").document(comm.id).collection("messages").getDocuments { snapshot, error in // Snap shot gets the documents from firebase. Error is any errors that many occur
            
            // Check for errors
            
            if error == nil {
                // No errors
                
                if let snapshot = snapshot { // check is snapshot is nil
                    
                    DispatchQueue.main.async { // Update the list property in the main thread
                    
                        self.list = snapshot.documents.map { doc in // Goes through each element in array of documents in snapshot one by one
                        
                    // it assigns all the documents to the variable, list, which saved it in an array
                        
                            
                    
                        
                      // Create a Todo item for each document returned
                            return MessageData(id: doc.documentID, username: doc["username"] as? String ?? "", message: doc["message"] as? String ?? "", commId: comm.id, time: doc["time"] as? String ?? "", pfp: doc["pfp"] as? String ?? "", image: doc["image"] as? String ?? "", timestamp: doc["timestamp"] as? Int ?? 0, verified: doc["verified"] as? Bool ?? false)
                         
                    }
                    }
                }
                
            } else {
                // Handle the error
            }
            
        } // Getting the collection from firebase. Must put collection name as string
        
        
    }
    
}
