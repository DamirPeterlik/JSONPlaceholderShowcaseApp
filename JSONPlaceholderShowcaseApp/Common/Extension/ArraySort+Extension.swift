//
//  ArraySort+Extension.swift
//  JSONPlaceholderShowcaseApp
//
//  Created by Damir Peterlik on 17/04/2017.
//  Copyright © 2017 Damir Peterlik. All rights reserved.
//

import Foundation

extension Array {
    
    func getFirstCharactersFromUsersToLetterArrayAndLetterUserDict(namesArray: [User]) -> (Array<String>, [String : [User]]) {
        
        var contacts = [String : [User]]()
        var lettersArray: Array<String> = []
        
        for user in namesArray {
            print(user.name)
            let letterCapitalized = user.name.capitalized
            let letter = letterCapitalized[letterCapitalized.startIndex]
            let stringLetter: String = "\(letter)"
            
            print(stringLetter)
            
            if lettersArray.count > 0 {
                if lettersArray.contains(stringLetter) {
                    print("it contains the letter - \(stringLetter)")
                    contacts[stringLetter]?.append(user)
                } else {
                    lettersArray.append("\(stringLetter)")
                    contacts[stringLetter] = [user]
                }
            } else {
                lettersArray.append("\(stringLetter)")
                contacts[stringLetter] = [user]
            }
        }
        
        print(contacts)

        return (lettersArray, contacts)
        
    }
    
}
