//
//  MainView.swift
//  ForceNexusChat
//
//  Created by Evan Tilley on 7/16/20.
//

import SwiftUI
import Firebase

struct MainView: View {
    @State var users: [String] = ["Christian Hugginson", "Emeralda O'Lily", "Jonathan Destiny", "Sarah Wentworth", "Edmund Fitzgerald", "Carlyle Fitsimmons"]
    let db = Firestore.firestore()
    @State var tag: Int? = 0
    @State var userToMessage: String = ""
    
    var body: some View {
        ZStack{
            NavigationLink(destination: MessagingView(userMessaging: self.userToMessage), tag: 1, selection: $tag) {
                EmptyView()
            }
            LinearGradient(gradient: Gradient(colors: [Color(red: 43/255, green: 43/255, blue: 43/255), Color(red: 127/255, green: 195/255, blue: 217/255)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Image("forcenexus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: screenWidth * 0.7)
                    .padding(.bottom)
                Spacer()
                Text("Select a user to chat with:")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .bold()
                    .padding(.bottom)
                    .fixedSize(horizontal: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                
                ScrollView{
                    ForEach(self.users, id: \.self){user in
                        Button(action: {
                            self.userToMessage = user
                            self.tag = 1
                        }){
                        Text(user)
                            .fixedSize(horizontal: true, vertical: true)
                            .frame(width: screenWidth * 0.6)
                            
                            .padding()
                            .background(
                                LinearGradient(gradient: Gradient(colors: [gapGreen, gapBlue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.blue, lineWidth:
                                                5)
                            )
                            .padding(.bottom, screenHeight * 0.02)
                        }
                        .buttonStyle(PlainButtonStyle())
                    
                        
                    }
                }
                .frame(height: screenHeight * 0.4)
                Spacer()
                VStack{
                    Image("gap")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: screenWidth * 0.3 )
                        .padding(.bottom)
                }
            }
        }
        .onAppear{
            let usersRef = self.db.collection("Users")
            usersRef.getDocuments { (snapshot, err) in
                if err != nil {
                    print(err?.localizedDescription ?? "error")
                } else{
                    users.removeAll()
                    for document in snapshot!.documents{
                        if document.documentID != currentUser.username{
                            self.users.append(document.documentID)
                        }
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


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
