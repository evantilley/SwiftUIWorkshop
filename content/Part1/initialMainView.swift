//
//  MainView.swift
//  ForceNexusChat
//
//  Created by Evan Tilley on 7/16/20.
//

import SwiftUI

struct MainView: View {
    @State var users: [String] = ["Christian Hugginson", "Emeralda O'Lily", "Jonathan Destiny", "Sarah Wentworth"]
    var body: some View {
        VStack {
            Text("Select a user to chat with:")
            ScrollView{
                ForEach(self.users, id: \.self){user in
                    Text(user)
                        .fixedSize(horizontal: true, vertical: true)
                        .frame(width: screenWidth * 0.6)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.blue, lineWidth:
                                            5)
                        )
                        .padding()
                }
            }
            .frame(height: screenHeight * 0.4)
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
