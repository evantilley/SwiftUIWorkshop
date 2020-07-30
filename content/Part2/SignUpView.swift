//
//  SignUpView.swift
//  ForceNexusChat
//
//  Created by Evan Tilley on 7/15/20.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @State var email: String = ""
    @State var username: String = ""
    @State var password: String = ""
    @State var tag: Int? = 0
    let db = Firestore.firestore()
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color(red: 43/255, green: 43/255, blue: 43/255), Color(red: 127/255, green: 195/255, blue: 217/255)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            NavigationLink(destination: ContentView(), tag: 1, selection: $tag) {
                EmptyView()
            }
            NavigationLink(destination: MainView(), tag: 2, selection: $tag) {
                EmptyView()
            }
            VStack{
                Spacer()
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
                
                Text("Sign up")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .bold()
                Spacer()
                VStack{
                    Text("E-mail")
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    TextField("E-mail:", text: self.$email)
                        .foregroundColor(Color.white)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.white, lineWidth: 1))
                        .padding([.leading, .trailing])
                }
                VStack{
                    Text("Username")
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    TextField("Username:", text: self.$username)
                        .foregroundColor(Color.white)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.white, lineWidth: 1))
                        .padding([.leading, .trailing])
                }
                VStack{
                    Text("Password")
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    TextField("Password:", text: self.$password)
                        .foregroundColor(Color.white)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.white, lineWidth: 1))
                        .padding([.leading, .trailing])
                }
                .padding(.bottom, 50)
                Button(action: {
                    
                    Auth.auth().createUser(withEmail: self.email, password: self.password) { (result, err) in
                        if err != nil{
                            print(err?.localizedDescription ?? "error")
                        } else{
                            
                            let userRef = self.db.collection("Users").document(self.username)
                            let newUser = ["username": self.username, "email": self.email]
                            userRef.setData(newUser, merge: true) { (err) in
                                if err != nil{
                                    print(err?.localizedDescription ?? "error")
                                } else{
                                    currentUser.username = self.username
                                    self.tag = 2
                                }
                            }

                        }
                    }
                }){
                    Text("Sign Up")
                        
                        .fontWeight(.bold)
                        .fixedSize(horizontal: true, vertical: true)
                        .foregroundColor(Color.black)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding([.leading, .trailing, .top, .bottom])
                        
                        .padding(.leading, screenWidth * 0.1)
                        .padding(.trailing, screenWidth * 0.1)
                        .background(Color.white)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white, lineWidth:
                                            5)
                        )
                        .padding(.top)
                        .padding(.bottom, screenHeight * 0.1)
                }
                Spacer()
                Image("forcenexus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: screenWidth * 0.7)
                    .padding(.bottom)
                
                
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            .navigationBarItems(leading: EmptyView())
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
