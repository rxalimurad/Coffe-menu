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
    
    
    init(_ dictionary: NSDictionary) {
        id = dictionary[kID] as? String ?? ""
        email = dictionary[kEMAIL] as? String ?? ""
        firstName = dictionary[kFIRSTNAME] as? String ?? ""
        lastName = dictionary[kLASTNAME] as? String ?? ""
        fullName = firstName + " " + lastName
        fullAddress = dictionary[kFULLADDRESS] as? String ?? ""
        phoneNumber = dictionary[kPHONENUMBER] as? String ?? ""
        onBoarding = dictionary[kONBOARD] as? Bool ?? false
        
    }
    
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
                return FUser(dictionary as! NSDictionary)
            }
        }
        return nil
    }
    class func loginUserWith(email: String, password: String, completed: @escaping(_ error: Error?, _ isEmailVerified: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            if error == nil {
                if authDataResult!.user.isEmailVerified {
                    downloadUserFromFirestore(userId: authDataResult!.user.uid, email: authDataResult!.user.email ?? "") {
                        error in
                        
                        if error != nil {
                            print ("Error in downloading user", error?.localizedDescription)
                        }
                        completed(error, true)
                    }
                } else {
                    completed(error, false)
                }
                
            } else {
                completed(error, false)
            }
            
        }
    }
    
    class func downloadUserFromFirestore(userId: String, email: String, completion: @escaping(_ error: Error?) -> Void ) {
        firebaseReference(.User).document(userId).getDocument { snapshot, error in
            guard let snapshot = snapshot else { return }
            if snapshot.exists {
                self.saveUserLocally(userDictionary: snapshot.data()! as NSDictionary)
            } else {
                let user = FUser(userId, email, "", "", "")
                saveUserLocally(userDictionary: userDictionaryFrom(user: user) as NSDictionary)
                saveUserToFirestore(fUser: user)
            }
            completion(error)
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
    
    class func saveUserToFirestore(fUser: FUser) {
        firebaseReference(.User).document(fUser.id).setData(userDictionaryFrom(user: fUser)) {error in
            if error != nil {
                print ("Error in Saving user to firestore \(error?.localizedDescription)")
            }
        }
    }
    class func saveUserLocally(userDictionary: NSDictionary) {
        userDefault.set(userDictionary, forKey: kCURRENTUSER)
        userDefault.synchronize()
    }
    
    
    class func userDictionaryFrom(user: FUser) -> [String : Any] {
        return [
            kID : user.id,
            kEMAIL : user.email,
            kFIRSTNAME : user.firstName,
            kLASTNAME : user.lastName,
            kFULLNAME : user.fullName,
            kFULLADDRESS : user.fullAddress ?? "",
            kONBOARD : user.onBoarding,
            kPHONENUMBER : user.phoneNumber
        ]
        
    }
    
    class func updateCurrentUser(withValues: [String: Any], completion: @escaping(_ error: Error?) -> Void) {
        if let dictionary = userDefault.object(forKey: kCURRENTUSER) {
            let userObject = (dictionary as! NSDictionary).mutableCopy() as! NSMutableDictionary
            userObject.setValuesForKeys(withValues)
            firebaseReference(.User).document(FUser.currentId()).updateData(withValues) {
                error in
                completion(error)
                if error == nil {
                    FUser.saveUserLocally(userDictionary: userObject)
                }
            }
        }
    }
    
    class func resetPassword(email: String, completion: @escaping(_ error: Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
        
    }
    
    class func logoutCurrentUser(completion: @escaping(_ error: Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            userDefault.removeObject(forKey: kCURRENTUSER)
            completion(nil)
            
        } catch let error as Error {
            completion(error)
        }
    
    }
    
    
}
