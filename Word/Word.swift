//
//  Word.swift
//  Word
//
//  Created by David Yépez on 4/28/19.
//  Copyright © 2019 David Yepez. All rights reserved.
//

import Foundation
import Firebase

class Word {
    var word: String
    var definition: String
    var postingUserID: String
    var documentID: String
    
    var dictionary: [String: Any] {
        return ["word": word, "definition": definition, "postingUserID": postingUserID]
    }
    
    init(word: String, definition: String, postingUserID: String, documentID: String) {
        self.word = word
        self.definition = definition
        self.postingUserID = postingUserID
        self.documentID = documentID
    }
    
    convenience init() {
        self.init(word: "", definition: "", postingUserID: "", documentID: "")
    }
    
    convenience init(dictionary: [String: Any]) {
        let word = dictionary["word"] as! String? ?? ""
        let definition = dictionary["definition"] as! String? ?? ""
        let postingUserID = dictionary["postingUserID"] as! String? ?? ""
//        let documentID = dictionary["documentID"] as! String? ?? ""
        self.init(word: word, definition: definition, postingUserID: postingUserID, documentID: "")
    }
    
    func saveData(completed: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        // Grab the userID
        guard let postingUserID = (Auth.auth().currentUser?.uid) else {
            print("*** ERROR: Could not save data because we don't have a valid postingUserID")
            return completed(false)
        }
        self.postingUserID = postingUserID
        // Create the dictionary representing the data we want to save
        let dataToSave = self.dictionary
        // if we HAVE saved a record, we'll have a documentID
        if self.documentID != "" {
            let ref = db.collection("words").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                if let error = error {
                    print("*** ERROR: updating document \(self.documentID) \(error.localizedDescription)")
                    completed(false)
                } else {
                    print("^^^ Document updated with ref ID \(ref.documentID)")
                    completed(true)
                }
            }
        } else {
            var ref: DocumentReference? = nil // Let firestore create the new documentID
            ref = db.collection("words").addDocument(data: dataToSave) { error in
                if let error = error {
                    print("*** ERROR: creating new document \(error.localizedDescription)")
                    completed(false)
                } else {
                    print("^^^ new document created with ref ID \(ref?.documentID ?? "unknown")")
                    self.documentID = ref!.documentID
                    completed(true)
                }
            }
        }
    }
    
    
    
}
