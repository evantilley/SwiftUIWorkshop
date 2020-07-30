//
//  MessagingView.swift
//  ForceNexusChat
//
//  Created by Evan Tilley on 7/23/20.
//

import SwiftUI

let message1 = MessageItem(id: UUID(), messageContent: "Hey! You still working tomorrow?", messageSender: "John", messageReceiver: "Eric", date: Date())
let message2 = MessageItem(id: UUID(), messageContent: "Just wondering because if you are I'll have Sarah set up the VM for you.", messageSender: "John", messageReceiver: "Eric", date: Date())
let message3 = MessageItem(id: UUID(), messageContent: "Hey John, yeah I should be good to come in tomorrow.", messageSender: "Eric", messageReceiver: "John", date: Date())
let message4 = MessageItem(id: UUID(), messageContent: "Cool, sounds good.", messageSender: "John", messageReceiver: "Eric", date: Date())

struct MessagingView: View {
    
    @State var messages: [MessageItem] = [message1, message2, message3, message4]
    @State var userMessaging: String = "User messaging"
    @State var message: String = ""
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [gapGray, gapLightBlue]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack{
                Text("\(userMessaging)")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .bold()
                    .padding()
                ScrollView{
                    ForEach(self.messages, id: \.self){message in
                        VStack{
                            if message.messageSender == currentUser.username{
                                VStack{
                                    MessageItemView(message: message)
                                }
                                .padding([.leading, .trailing, .bottom])
                                .frame(width: screenWidth * 0.6)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                
                            } else{
                                VStack{
                                    MessageItemView(message: message)
                                }
                                .padding([.leading, .trailing, .bottom])
                                .frame(width: screenWidth * 0.6)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                }
                .frame(height: screenHeight * 0.6)
                HStack{
                    TextField("Message:", text: self.$message)
                        .foregroundColor(Color.white)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.white, lineWidth: 1))
                        .padding([.leading])
                    Button(action: {
                        
                    }){
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: screenWidth * 0.1)
                            .padding()
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.bottom, screenHeight * 0.1)
            }
        }
    }
}

struct MessagingView_Previews: PreviewProvider {
    static var previews: some View {
        MessagingView()
    }
}
