//
//  KeychainUtility.swift
//  Inter-App Keychain
//
//  Created by Herman Liang on 2015/8/29.
//  Copyright (c) 2015 8085 Studio. All rights reserved.
//

import UIKit

class KeychainUtility: NSObject {
    
    private var service = ""
    private var group = ""
   
    init(service: String, group: String) {
        super.init()
        self.service = service
        self.group = group
    }
    
    private func prepareDic(key: String) -> [String: AnyObject] {
        var dic = [String: AnyObject]()
        dic[kSecClass as String] = kSecClassGenericPassword
        dic[kSecAttrService as String] = self.service
        dic[kSecAttrAccessGroup as String] = self.group
        dic[kSecAttrAccount as String] = key
        return dic
    }
    
    func insert(data: NSData, key: String) -> Bool {
        var dic = prepareDic(key)
        dic[kSecValueData as String] = data
        let status = SecItemAdd(dic, nil)
        if status == errSecSuccess {
            return true
        } else {
            return false
        }
    }
    
    func query(key: String) -> NSData? {
        var dic  = prepareDic(key)
        dic[kSecReturnData as String] = kCFBooleanTrue
        var data: AnyObject?
        let status = withUnsafeMutablePointer(&data) {
            SecItemCopyMatching(dic, UnsafeMutablePointer($0))
        }
        if status == errSecSuccess {
            return data as? NSData
        } else {
            return nil
        }
    }
    
    func update(data: NSData, key: String) -> Bool {
        var query  = prepareDic(key)
        var dic  = [String: AnyObject]()
        dic[kSecValueData as String] = data
        let status = SecItemUpdate(query, dic)
        if status == errSecSuccess {
            return true
        } else {
            return false
        }
    }
    
    func deleteData(key: String) -> Bool {
        var dic = prepareDic(key)
        let status = SecItemDelete(dic)
        if status == errSecSuccess {
            return true
        } else {
            return false
        }
    }
   
}
