//
//  UsingFMDB.swift
//  UsinfFMDB
//
//  Created by Sose Yeritsyan on 6/15/20.
//  Copyright © 2020 Sose Yeritsyan. All rights reserved.
//


/*
 first implement FMDB with pod file
 after I add FMDB files into project and check "create bridging header file"
 in file add #import "FMDB.h"
 then delete all fmdb files into project
 
 question: how can I add bridging header file in different way?

*/


import Foundation
import FMDB

let sharedInstance = FMDBDatabaseModel()
class FMDBDatabaseModel: NSObject {

    var database: FMDatabase?

    class func getInstance() -> FMDBDatabaseModel
    {
        if (sharedInstance.database == nil)
        {
        sharedInstance.database = FMDatabase(path: Util.getPath(fileName: "UsingFMDB.sqlite"))
        }
        return sharedInstance
    }
    

    func createDB() {
        guard database!.open() else {
            print("Unable to open database")
            return
        }
        do {
            try database!.executeUpdate("create table if not exists usersTBL(firstname text, lastname text, birthday text, ismale integer, height integer, weight integer, phone text, email text primary key, password text)", values: nil)
        } catch {
            print("DB is not created")
        }
        
    }

    func InsertData(user: User) -> Bool {
        sharedInstance.database!.open()
        
        let isSave = sharedInstance.database?.executeUpdate("INSERT INTO usersTBL(firstname , lastname , birthday , ismale , height , weight , phone, email, password) VALUES (?,?,?,?,?,?,?,?,?)", withArgumentsIn: [user.firstname,user.lastname,user.birthday,user.ismale,user.height,user.weight,user.phone,user.email,user.password])
        sharedInstance.database?.close()
        return isSave!

    }
    
    func getAllData() -> [User] {
        sharedInstance.database!.open()
        var returnedUsers = [User]()
        let resultSet:FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM usersTBL", withArgumentsIn: [0])

        if (resultSet != nil) {
            while resultSet.next() {

                var item = User()
                item.firstname = String(resultSet.string(forColumn: "firstname")!)
                item.lastname = String(resultSet.string(forColumn: "lastname")!)
                item.birthday = String(resultSet.string(forColumn: "birthday")!)
                item.ismale = Int(resultSet.int(forColumn: "ismale"))
                
                item.height = Int(resultSet.int(forColumn: "height"))
                item.weight = Int(resultSet.int(forColumn: "weight"))
                item.phone = String(resultSet.string(forColumn: "phone")!)
                item.email = String(resultSet.string(forColumn: "email")!)
                item.password = String(resultSet.string(forColumn: "password")!)

                returnedUsers.append(item)
            }
        }

        sharedInstance.database!.close()
        return returnedUsers
    }

    func updateRecode(user: User) {
        sharedInstance.database!.open()

        let resultSet:FMResultSet! = sharedInstance.database!.executeQuery("UPDATE usersTBL SET firstname = ?,lastname = ?,birthday = ?, ismale = ?,height = ?,weight = ?, phone = ?, password = ? WHERE email = ?", withArgumentsIn: [user.firstname, user.lastname, user.birthday, user.ismale, user.height, user.weight, user.phone, user.password, user.email])

        if (resultSet != nil) {
            while resultSet.next() {
                var item = User()
                item.firstname = String(resultSet.string(forColumn: "firstname")!)
                item.lastname = String(resultSet.string(forColumn: "lastname")!)
                item.birthday = String(resultSet.string(forColumn: "birthday")!)
                item.ismale = Int(resultSet.int(forColumn: "ismale"))
                
                item.height = Int(resultSet.int(forColumn: "height"))
                item.weight = Int(resultSet.int(forColumn: "weight"))
                item.phone = String(resultSet.string(forColumn: "phone")!)
                item.email = String(resultSet.string(forColumn: "email")!)
                item.password = String(resultSet.string(forColumn: "password")!)
            }
        }

        sharedInstance.database!.close()

    }
    func deleteRecode(email: String) {
        sharedInstance.database!.open()

        let resultSet:FMResultSet! = sharedInstance.database!.executeQuery("DELETE FROM usersTBL WHERE email = ?", withArgumentsIn: [email])

        if (resultSet != nil) {
            while resultSet.next() {
                
                var item = User()
                item.firstname = String(resultSet.string(forColumn: "firstname")!)
                item.lastname = String(resultSet.string(forColumn: "lastname")!)
                item.birthday = String(resultSet.string(forColumn: "birthday")!)
                item.ismale = Int(resultSet.int(forColumn: "ismale"))
                
                item.height = Int(resultSet.int(forColumn: "height"))
                item.weight = Int(resultSet.int(forColumn: "weight"))
                item.phone = String(resultSet.string(forColumn: "phone")!)
                item.email = String(resultSet.string(forColumn: "email")!)
                item.password = String(resultSet.string(forColumn: "password")!)
            }
        }

        sharedInstance.database!.close()
    }

  
    
    func tryLogIn(email: String?, password: String?)->String {
        sharedInstance.database!.open()
        var outputstr = "your email \(email!) and password \(password!) is incorrect"
        let resultSet:FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM usersTBL WHERE email = ?",  withArgumentsIn: [email!])
        if (resultSet != nil) {
            while resultSet.next() {
                if String(resultSet.string(forColumn: "password")!) == password {
                    outputstr = "your email \(email!) and password \(password!) is correct"
                }
            }
        }
        return outputstr
    }
    

    
    func findUserByEmail(email: String?) -> User? {
        sharedInstance.database!.open()

        let resultSet:FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM usersTBL WHERE email = ?", withArgumentsIn: [email!])

        if (resultSet != nil) {
            
            var item = User()
            while resultSet.next() {
                item.firstname = String(resultSet.string(forColumn: "firstname")!)
                item.lastname = String(resultSet.string(forColumn: "lastname")!)
                item.birthday = String(resultSet.string(forColumn: "birthday")!)
                item.ismale = Int(resultSet.int(forColumn: "ismale"))
                item.height = Int(resultSet.int(forColumn: "height"))
                item.weight = Int(resultSet.int(forColumn: "weight"))
                item.phone = String(resultSet.string(forColumn: "phone")!)
                item.email = String(resultSet.string(forColumn: "email")!)
                item.password = String(resultSet.string(forColumn: "password")!)
                print(item)
                return item
        }
        }
            return nil
        
    }
    
}
