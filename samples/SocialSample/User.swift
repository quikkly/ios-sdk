//
//  User.swift
//  Samples
//
//  Created by Julian Gruber on 20/12/2016.
//  Copyright © 2016 Quikkly Ltd. All rights reserved.
//

import UIKit

class User: NSObject {
    var id:Int?
    var name:String?
    var dob:String?
    var profilePic:String?
    
    static var loggedInId:Int = 1481647718
    static var stored:[User]? {
        get {
            if let asset = NSDataAsset(name: "Users", bundle: Bundle.main) {
                do {
                    guard let array = try JSONSerialization.jsonObject(with: asset.data, options: []) as? [[String:Any]] else {
                        return nil
                    }
                    var users = [User]()
                    for x in array {
                        let user = User()
                        user.id = x["id"] as? Int
                        user.name = x["name"] as? String
                        user.dob = x["dob"] as? String
                        user.profilePic = x["profilePic"] as? String
                        users.append(user)
                    }
                    return users
                } catch {
                    print("Error!! Unable to parse users json")
                }
            }

            return nil
        }
    }
    
    class func storedUser(withId id:Int) -> User? {
        guard let storedUsers = User.stored else {
            return nil
        }
        
        for x in storedUsers {
            if let xId = x.id, xId == id {
                return x
            }
        }
        
        return nil
    }
}
