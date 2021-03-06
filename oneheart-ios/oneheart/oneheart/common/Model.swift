//
//  Model.swift
//  oneheart
//
//  Created by fomjar on 2017/11/9.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import Foundation

enum UserState: Int {
    case signup = 0
    case verify = 1
    case cancel = 2
}

protocol Storable {
    func valid() -> Bool
    func save()
    mutating func save(_ data: [String:Any])
    mutating func load()
}

struct User: Storable {
    
    var id      : Int!          = -1
    var state   : UserState!    = .signup
    var mail    : String!       = ""
    var phone   : String?
    var name    : String?
    var pass    : String!       = ""
    var avatar  : String?
    
    init() {
        load()
    }
    
    func valid() -> Bool {
        return 0 < id
    }
    
    func save() {
        UserDefaults.standard.set(self.id,              forKey: "user.id")
        UserDefaults.standard.set(self.state.rawValue,  forKey: "user.state")
        UserDefaults.standard.set(self.mail,            forKey: "user.mail")
        UserDefaults.standard.set(self.phone,           forKey: "user.phone")
        UserDefaults.standard.set(self.name,            forKey: "user.name")
        UserDefaults.standard.set(self.pass,            forKey: "user.pass")
        UserDefaults.standard.set(self.avatar,          forKey: "user.avatar")
    }
    
    mutating func save(_ data: [String:Any]) {
        self.id     = data["id"]        as? Int
        self.state  = UserState(rawValue: data["state"] as! Int)
        self.mail   = data["mail"]      as? String
        self.phone  = data["phone"]     as? String
        self.name   = data["name"]      as? String
        self.pass   = data["pass"]      as? String
        self.avatar = data["avatar"]    as? String
        
        self.save()
    }
    
    mutating func load() {
        self.id     = UserDefaults.standard.integer(forKey: "user.id")
        self.state  = UserState(rawValue: UserDefaults.standard.integer(forKey: "user.state"))
        self.mail   = UserDefaults.standard.string(forKey: "user.mail")
        self.phone  = UserDefaults.standard.string(forKey: "user.phone")
        self.name   = UserDefaults.standard.string(forKey: "user.name")
        self.pass   = UserDefaults.standard.string(forKey: "user.pass")
        self.avatar = UserDefaults.standard.string(forKey: "user.avatar")
    }
}

class Model {
    static var user     = User()
    class func isUserWriteToday() -> Bool {
        let user = Model.user.id!
        let time = UserDefaults.standard.double(forKey: "user-\(user).write.time")
        return Int(time / 60 / 60 / 24) >= Int(Date().timeIntervalSince1970 / 60 / 60 / 24)
    }
    class func notifyUserWrite() {
        let user = Model.user.id!
        UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "user-\(user).write.time")
    }
}


