//
//  MessagingView.swift
//  ForceNexusChat
//
//  Created by Evan Tilley on 7/23/20.
//

import SwiftUI
import Firebase

let message1 = MessageItem(id: UUID(), messageContent: "Hey! You still working tomorrow?", messageSender: "John", messageReceiver: "Eric")
let message2 = MessageItem(id: UUID(), messageContent: "Just wondering because if you are I'll have Sarah set up the VM for you.", messageSender: "John", messageReceiver: "Eric")
let message3 = MessageItem(id: UUID(), messageContent: "Hey John, yeah I should be good to come in tomorrow.", messageSender: "Eric", messageReceiver: "John")
let message4 = MessageItem(id: UUID(), messageContent: "Cool, sounds good.", messageSender: "John", messageReceiver: "Eric")

struct MessagingView: View {
    
    @State var messages: [MessageItem] = [message1]
    @State var userMessaging: String = "User messaging"
    @State var message: String = ""
    @State var tag: Int? = 0
    let db = Firestore.firestore()
    
    var body: some View {
        ZStack{
            NavigationLink(destination: MainView(), tag: 1, selection: $tag) {
                EmptyView()
            }
            LinearGradient(gradient: Gradient(colors: [gapGray, gapLightBlue]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack{
                VStack{
                    Button(action: {
                        self.tag = 1
                    }){
                        Image(systemName: "gobackward")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: screenWidth * 0.1)
                            .foregroundColor(Color.white)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
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
                        //update your part of the database
                        let yourMessageRef = self.db.collection("Users").document(currentUser.username).collection("Messages").document("Messages").collection(self.userMessaging)
                        let message = ["messageContent": self.message, "messageSender": currentUser.username, "messageReceiver": self.userMessaging, "date": Timestamp.init(date: Date())] as [String : Any]
                        yourMessageRef.addDocument(data: message) { (err) in
                            if err != nil {
                                print(err?.localizedDescription ?? "error")
                            } else{
                                //update their part of the database
                                let userMessagingRef = self.db.collection("Users").document(self.userMessaging).collection("Messages").document("Messages").collection(currentUser.username)
                                userMessagingRef.addDocument(data: message) { (err) in
                                    if err != nil {
                                        print(err?.localizedDescription ?? "error")
                                    } else{
                                        //clear message text field
                                        self.message = ""
                                    }
                                }
                            }
                        }
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
        .onAppear{
            let yourMessagingRef = self.db.collection("Users").document(currentUser.username).collection("Messages").document("Messages").collection(self.userMessaging)
            //get all messages from person you're messaging
            yourMessagingRef.addSnapshotListener { (snapshot, err) in
                if err != nil {
                    print(err?.localizedDescription ?? "error" )
                } else{
                    messages.removeAll()
                    for document in snapshot!.documents{
                        let message = MessageItem(messageContent: document["messageContent"] as! String, messageSender: document["messageSender"] as! String, messageReceiver: document["messageReceiver"] as! String, date: document["date"] as? Timestamp)
                        self.messages.append(message)
                        self.messages = self.messages.sorted(by: {
                            $0.date!.compare($1.date!) == .orderedAscending
                        })
                    }
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarItems(leading: EmptyView())
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MessagingView_Previews: PreviewProvider {
    static var previews: some View {
        MessagingView()
    }
}
