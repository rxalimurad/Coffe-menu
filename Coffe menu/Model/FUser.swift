//
//  FUser.swift
//  Coffe menu
//
//  Created by Ali Murad on 02/09/2022.
//

import Foundation
import FirebaseAuth

class FUser {
    let id: String
    var email: String
    var firstName: String
    var lastName: String
    var fullName: String
    var phoneNumber: String
    var fullAddress: String?
    var onBoarding: Bool
    
    init(_ id: String, _ email: String, _ firstName: String, _ lastName: String, _ phoneNumber: String) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = firstName + " " + lastName
        self.phoneNumber = phoneNumber
        self.onBoarding = false
    }
    
    class func currentId() -> String {
        return Auth.auth().currentUser!.uid
    }
    class func currentUser() -> FUser? {
        if Auth.auth().currentUser != nil {
            if let dictionary = userDefault.object(forKey: kCURRENTUSER) {
                return nil //,,..
            }
        }
        return nil
    }
    class func loginUserWith(email: String, password: String, completed: @escaping(_ error: Error?, _ isEmailVerified: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            if error == nil {
                if authDataResult!.user.isEmailVerified {
                    //download fuser data locally ,,..
                }
                
            } else {
                completed(error, false)
            }
            
        }
    }
    
    class func registerUserWith(email: String, password: String, completed: @escaping(_ error: Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            completed(error)
            
            if error == nil {
                authDataResult!.user.sendEmailVerification() {error in
                    print("Verification email sent error is : \(error?.localizedDescription)")
                }
            }
            
        }
    }
    
    
}
