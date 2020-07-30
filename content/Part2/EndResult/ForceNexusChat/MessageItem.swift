//
//  MessageItem.swift
//  ForceNexusChat
//
//  Created by Evan Tilley on 7/29/20.
//  Copyright © 2020 Evan Tilley. All rights reserved.
//

import Foundation
import Firebase

struct MessageItem: Identifiable, Hashable{
    var id: UUID = UUID()
    var messageContent: String
    var messageSender: String
    var messageReceiver: String
    var date: Timestamp?
}
