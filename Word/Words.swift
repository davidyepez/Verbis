//
//  Words.swift
//  Word
//
//  Created by David Yépez on 4/23/19.
//  Copyright © 2019 David Yepez. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import Firebase





class Words {

    //FOR FIRESTORE
    var favoritesArray = [Word]()
    var db: Firestore!
    var firebaseWord = Word()
    
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ())  {
        db.collection("words").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("*** ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.favoritesArray = []
            // there are querySnapshot!.documents.count documents in teh spots snapshot
            for document in querySnapshot!.documents {
                let word = Word(dictionary: document.data())
                word.documentID = document.documentID
                self.favoritesArray.append(word)
            }
            completed()
        }
    }
    //END OF FOR FIREBASE
    
    struct randomURLStruct {
        var word = ""
        var def = ""
    }
    
    var wordArray : [WordInfo] = []
    var definitionArray : [WordInfo] = []
    var randomArray : [randomURLStruct] = []
    
    
    func getWords (word : String, apiType: String, completed: @escaping () -> () ) {
        let string = "https://wordsapiv1.p.mashape.com/words/\(word)/\(apiType)"
        let url = URL(string: string)
        var request = URLRequest(url: url!)
        let session = URLSession.shared
        request.setValue("793f73a60dmsh1790e790597dd92p1bd378jsnb4c22b4262f9", forHTTPHeaderField: "X-Mashape-Key")
        request.httpMethod = "GET"
        
        Alamofire.request(request).responseJSON { response in
            switch response.result {
            case.success(let value):
                let json = JSON(value)
                if apiType == "rhymes" {
                    let numberOfRhymes = json["rhymes"]["all"].count
                    for index in 0..<numberOfRhymes {
                        let rhymes = json["rhymes"]["all"][index].stringValue
                        //self.wordArray.append(WordInfo(rhymes: rhymes))
                        self.wordArray.append(WordInfo(rhymes: rhymes, definition: "", partOfSpeech: ""))
                    }
                }
                if apiType == "definitions" {
                    let definitionDataArrayFromAPI = json["definitions"]
                    for index in 0..<definitionDataArrayFromAPI.count {
                        //
                        let word = json["word"].stringValue
                        //
                        let definition = json["definitions"][index]["definition"].stringValue
                        let partOfSpeech = json["definitions"][index]["partOfSpeech"].stringValue
                        self.definitionArray.append(WordInfo(rhymes: "", definition: definition, partOfSpeech: partOfSpeech))
                       //FOR FIRESTORE
                        let word1 = Word()
                        word1.word = word
                        word1.definition = definition
                        self.firebaseWord = word1
                        self.favoritesArray.append(self.firebaseWord)
                        print("%%%: \(self.firebaseWord.word)")
                        
                        //END OF FOR FIRESTORE
                        
                        
                    }
                }
            case.failure(let value):
                print("FAILURE")
            }
        
            completed()

            
        }
    }
    
//    func getRandomWord(completed: @escaping () -> () ) {
//        let string = "https://wordsapiv1.p.mashape.com/words?random=true"
//        let url = URL(string: string)
//        var request = URLRequest(url: url!)
//        let session = URLSession.shared
//        request.setValue("793f73a60dmsh1790e790597dd92p1bd378jsnb4c22b4262f9", forHTTPHeaderField: "X-Mashape-Key")
//        request.httpMethod = "GET"
//
//    Alamofire.request(request).responseJSON { response in
//    switch response.result {
//    case.success(let value):
//        let json = JSON(value)
//        let word = json["word"].stringValue
//        print("@@: \(word)")
//        print("@@@: \(json["word"])")
//        print("@@@@: \(json["word"].stringValue)")
//
//        let definition = json["word"]["results"]["definition"].stringValue
//        self.randomArray.append(randomURLStruct(word: word, def: definition))
//    case.failure(let value):
//        print("FAILURE")
//        }
//    completed()
//    }
//
//    }

    
}
