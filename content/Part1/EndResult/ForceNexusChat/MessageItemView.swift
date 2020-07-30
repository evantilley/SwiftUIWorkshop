//
//  MessageItemView.swift
//  ForceNexusChat
//
//  Created by Evan Tilley on 7/23/20.
//

import SwiftUI

let gapGreen = Color(red: 155/255, green: 193/255, blue: 106/255)

struct MessageItemView: View {
    @State var message: MessageItem = MessageItem(id: UUID(), messageContent: "Hello, how are you on this fine day, good sir? Wanted to reach out about the upcoming project.", messageSender: "Hamilton", messageReceiver: "Bugsy", date: Date())
    var body: some View {
        VStack{
            Text(message.messageContent)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.black)

        }
        .padding()
        .background(Color.gray)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(gapGreen))
    }
}

struct MessageItemView_Previews: PreviewProvider {
    static var previews: some View {
        MessageItemView()
    }
}
