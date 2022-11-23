//
//  CommentsModel.swift
//  Skymie
//
//  Created by Nethan on 17/7/22.
//

import Foundation
import Firebase

class CommentsModel: ObservableObject {
    
    @Published var list = [CommentData]()
    
    func deleteData(thepost: PostsData, commentToDelete: CommentData) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        // Specify the document to delete
        db.collection("posts").document(thepost.id).collection("comments").document(commentToDelete.id).delete { error in
            // Check for errors
            if error == nil {
               // No errors
                
                DispatchQueue.main.async { // Update UI from main thread
                    
                
                // Remove todo that was just deleted
                self.list.removeAll { comment in
                    // Check for the todo to remove
                    
                    return comment.id == commentToDelete.id
                }
                    
                }
            }
            
        }
        
    }
    

    
    func addData(post: PostsData, username: String, comment: String, postId: String, pfp: String, verified: Bool) {
        // Get a reference to the database
        let db = Firestore.firestore()
        // Add a document to a collection
        db.collection("posts").document(post.id).collection("comments").addDocument(data: ["username": username, "comment": comment, "postId": postId, "pfp": pfp, "verified": verified]) { error in
            // We don't have to worry about the ID for this new document because it'll automatically be generated
            
            // data is stored in a dictionary, with the data label followed by the value, which in this
            // case is our argument, name!
            
            // Check for errors
            
            
            
            if error == nil {
                // No errors
                
                self.getData(post: post)
                
            } else {
                // Handle the error
            }
            
        }
        
    }
    
    func getData(post: PostsData) {
        

        
        
        // Get a reference to the database
        let db = Firestore.firestore()
        // Read the documents at a specific path
        db.collection("posts").document(post.id).collection("comments").getDocuments { snapshot, error in // Snap shot gets the documents from firebase. Error is any errors that many occur
            
            // Check for errors
            
            if error == nil {
                // No errors
                
                if let snapshot = snapshot { // check is snapshot is nil
                    
                    DispatchQueue.main.async { // Update the list property in the main thread
                    
                        self.list = snapshot.documents.map { doc in // Goes through each element in array of documents in snapshot one by one
                        
                    // it assigns all the documents to the variable, list, which saved it in an array
                        
                        
                        
                        
                      // Create a Todo item for each document returned
                            return CommentData(id: doc.documentID, username: doc["username"] as? String ?? "", comment: doc["comment"] as? String ?? "", postId: post.id, pfp: doc["pfp"] as? String ?? "", verified: doc["verified"] as? Bool ?? false)
                    }
                    }
                }
                
            } else {
                // Handle the error
            }
            
        } // Getting the collection from firebase. Must put collection name as string
        
        
    }
    
}
