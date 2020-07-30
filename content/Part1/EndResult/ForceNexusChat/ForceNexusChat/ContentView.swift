//
//  ContentView.swift
//  ForceNexusChat
//
//  Created by Evan Tilley on 7/14/20.
//

import SwiftUI
import Firebase

//global variables
let screenHeight = UIScreen.main.bounds.height
let screenWidth = UIScreen.main.bounds.width
let gapGray = Color(red: 43/255, green: 43/255, blue: 43/255)
let gapLightBlue = Color(red: 127/255, green: 195/255, blue: 217/255)

let gapBlue = Color(red: 90/255, green: 183/255, blue: 208/255)

struct ContentView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var tag: Int? = 0
    
    var body: some View {
        NavigationView{

            ZStack{
                NavigationLink(destination: SignUpView(), tag: 1, selection: $tag) {
                    EmptyView()
                }
                LinearGradient(gradient: Gradient(colors: [gapGray, gapLightBlue]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                VStack{
                    VStack{
                        Text("Force Nexus Chat")
                            .font(.largeTitle)
                            .bold()
                            .padding()
                            .foregroundColor(Color.white)
                        Image("gap")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: screenWidth * 0.3 )
                            .padding(.bottom)
                    }
                    Spacer()
                    Text("Login")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color.white)
                    VStack{
                        Text("Email")
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        TextField("Email:", text: self.$email)
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
                    Button(action: {
                        
                    }){
                        Text("Log in")
                            
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
                    VStack{
                        Text("Don't have an account?")
                            .foregroundColor(Color.white)
                        Button(action: {
                            self.tag = 1
                        }){
                            Text("Sign up")
                                
                                .fontWeight(.bold)
                                
                                .fixedSize(horizontal: true, vertical: true)
                                
                                .foregroundColor(Color.black)
                                
                                .multilineTextAlignment(.center)
                                
                                .padding(.leading, screenWidth * 0.1)
                                .padding(.trailing, screenWidth * 0.1)
                                .background(Color.white)
                                .cornerRadius(5)
                                .foregroundColor(.white)
                                .padding(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.white, lineWidth:
                                                    5)
                                )
                                .padding(.top)
                                .padding(.bottom)
                        }
                    }
                    .padding(.bottom, screenHeight * 0.05)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            .navigationBarItems(leading: EmptyView())
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



