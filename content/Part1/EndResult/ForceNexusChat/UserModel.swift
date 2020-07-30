//
//  UserModel.swift
//  ForceNexusChat
//
//  Created by Evan Tilley on 7/29/20.
//  Copyright © 2020 Evan Tilley. All rights reserved.
//

import Foundation

struct UserModel: Identifiable{
    var id = UUID()
    var username: String = "Eric"
}

var currentUser = UserModel()
