//
//  AddView.swift
//  VocksSwiftUI
//
//  Created by Evan Tilley on 6/12/20.
//  Copyright © 2020 Evan Tilley. All rights reserved.
//

import SwiftUI
import Firebase

struct AddView: View {
    @State var friendUsername: String = ""
    //to prevent auto state update; maybe rework later
    //if you want the search to be more like instagram
    //where it suggests things as you search =
    @State var searchedFriendUsername: String = ""
    @State var results: Bool = false; //false
    @State var foundUsername: String = ""
    @State var addUser:Bool = false; //false
    @State var noUsers:Bool = false; //false
    @State var followPressed:Bool = false;
    @State var alreadyFollowing:Bool = false;
    @State var privateProfile: Bool = false;
    @State var tag: Int? = nil
    @State var search:String = ""
    @State var searchList: [String] = ["bobbbiiieee"]
    @State var person: String = ""
    @ObservedObject var notificationValue: Notification = Notification.sharedInstance
    @State var userToMessage: String = ""
    @State var userToFollow: String = ""
    @State var userAcceptedFollowRequest: String = ""
    @State var userBitYou: String = ""
    @State var userDeletedMessage: String = ""
    let db = Firestore.firestore()
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: PublicProfileView(user: self.person, privateProfile: self.privateProfile), tag: 1, selection: $tag) {
                    EmptyView()
                }
                NavigationLink(destination: MessageView(userMessaging: self.userToMessage), tag: 4, selection: $tag) {
                    EmptyView()
                }
                NavigationLink(destination: PublicProfileView(user: self.userToFollow), tag: 5, selection: $tag) {
                    EmptyView()
                }
                NavigationLink(destination: PublicProfileView(user: self.userAcceptedFollowRequest), tag: 6, selection: $tag) {
                    EmptyView()
                }
                NavigationLink(destination: PublicProfileView(user: self.userBitYou), tag: 7, selection: $tag) {
                    EmptyView()
                }
                NavigationLink(destination: MessageView(userMessaging: self.userDeletedMessage), tag: 8, selection: $tag) {
                    EmptyView()
                }
                NavigationLink(destination: ProfileView(), tag: 21, selection: $tag) {
                    EmptyView()
                }
                .onAppear{
                    let usersRef = db.collection("Users").document("Users").collection("Users")
                    usersRef.getDocuments { (snapshot, err) in
                        if err != nil {
                            print(err?.localizedDescription)
                        } else{
                            for document in snapshot!.documents{
                                let username = document["username"] as! String
                                self.searchList.append(username)
                            }
                        }
                    }
                }
                Group{
                    if self.notificationValue.message != ""{
                        Text("")
                            .onAppear{
                                self.tag = 4
                                self.userToMessage = self.notificationValue.message
                                self.notificationValue.message = ""
                            }
                    }
                    if self.notificationValue.follow != ""{
                        Text("")
                            .font(.largeTitle)
                            .onAppear{
                                self.tag = 5
                                self.userToFollow = self.notificationValue.follow
                                self.notificationValue.follow = ""
                            }
                    }
                    if self.notificationValue.followRequestAccepted != ""{
                        Text("")
                            .font(.largeTitle)
                            .onAppear{
                                self.tag = 6
                                self.userAcceptedFollowRequest = self.notificationValue.followRequestAccepted
                                self.notificationValue.followRequestAccepted = ""
                            }
                    }
                    if self.notificationValue.newByter != ""{
                        Text("")
                            .font(.largeTitle)
                            .onAppear{
                                self.tag = 7
                                self.userBitYou = self.notificationValue.newByter
                                self.notificationValue.newByter = ""
                            }
                    }
                }
                Group{
                    Button(action: {
                        self.tag = 21
                    }){
                        Image("back_arrow")
                            .resizable()
                            .padding(.leading)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .buttonStyle(PlainButtonStyle())
                Text("Byte Friends")
                    .foregroundColor(pinkColor)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                //            TextField("Enter username:", text: $friendUsername)
                //            .padding()
                //                .autocapitalization(.none)
                //
                SearchBar(text: self.$search)
                ScrollView{
                    ForEach(self.searchList.filter {
                        self.search.isEmpty ? true : $0.contains(self.search.lowercased())
                    }, id: \.self) { person in
                        Button(action: {
                            self.person = person
                            let userInfo =  self.db.collection("Users").document("Users").collection("Users").document(person)
                            userInfo.getDocument { (snapshot, err) in
                                if err != nil {
                                    print(err?.localizedDescription)
                                } else{
                                    let privateProfile = snapshot!["private"] as! Bool
                                    self.privateProfile = privateProfile
                                    
                                }
                            }
                            self.tag = 1
                        })
                        {
                            Text(person)
                                .bold()
                                .font(.system(size: 14))
                                .padding(12)
                                .padding(.leading)
                                .padding(.trailing)
                                .background(Color(red: 251/255, green: 23/255, blue: 252/255))
                                .cornerRadius(20)
                                .foregroundColor(.white)
                                .padding(3)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white, lineWidth: 4)
                                )
                                .frame(width: screenWidth * 0.5)
                                .padding(3)
                            
                        }
                    }
                }
                Image("vocksLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: screenHeight * 0.1)
                }
                
                //            Button(action: {
                //                self.results = false
                //                self.addUser = false
                //                self.noUsers = false
                //                self.followPressed = false
                //                self.alreadyFollowing = false
                //                self.searchedFriendUsername = self.friendUsername
                //                let messageRef =  self.db.collection("Users").document("Users").collection("Users")
                //                let query = messageRef.whereField("username", isEqualTo: self.friendUsername)
                //
                //                query.getDocuments { (snapshot, error) in
                //                    if error != nil {
                //                        print("error")
                //                    }
                //                    if snapshot?.isEmpty == true {
                //                        print("no users found")
                //                        self.noUsers = true
                //                    }
                //                    else{
                //                        for document in snapshot!.documents{
                //                            let username = document["username"] as! String
                //                            print("user \(username)")
                //
                //                                self.searchList.append(username)
                ////                                print("user found: \(username as! String)")
                ////                                self.foundUsername = username as! String
                ////                                self.results = true
                //
                //                        }
                //                    }
                //                }
                //
                //
                //            }){
                //            Text("Search")
                //
                //            .bold()
                //               // .lineLimit(nil)
                //            .fixedSize(horizontal: true, vertical: true)
                //
                //                .foregroundColor(Color.white)
                //
                //            .font(.title)
                //                .multilineTextAlignment(.center)
                //                .padding([.leading, .trailing, .top, .bottom])
                //
                //                .padding(.leading, screenWidth * 0.3)
                //                .padding(.trailing, screenWidth * 0.3)
                //                .background( Color(red: 82 / 255, green: 232 / 255, blue: 255 / 255))
                //
                //            .cornerRadius(20)
                //
                //
                //            .foregroundColor(.white)
                //
                //            .padding(8)
                //            .overlay(
                //                RoundedRectangle(cornerRadius: 20)
                //                    .stroke(Color(red: 82 / 255, green: 232 / 255, blue: 255 / 255), lineWidth:
                //                        5)
                //                    )
                //            .padding(.top)
                //            }
                //            if (self.noUsers == true){
                //                VStack{
                //                    Text("Results")
                //                        .font(.title)
                //                        .bold()
                //                    Text("No users named \(self.searchedFriendUsername) exist.")
                //                } .padding([.top, .leading, .trailing])
                //            }
                //            if (self.results == true){
                //                VStack{
                //                    Text("Results")
                //                        .font(.title)
                //                        .bold()
                //                } .padding([.top, .leading, .trailing])
                //
                //                Text("User: ").font(.system(size: 22)) + Text("\(self.foundUsername)").font(.system(size: 22)).bold() + Text(" detected!").font(.system(size: 22))
                //////                Text("User:") + Text("\(self.foundUsername)") + Text("detected!")
                //                    //.font(.system(size: 22))
                //                    //.padding([.leading, .trailing])
                //
                //                    Text("Check out \(self.foundUsername)'s profile:")
                //                        .padding()
                //                        .font(.system(size: 20))
                //
                //
                //                Button(action: {
                //                    self.tag = 1
                //                }){
                //                    Text("View Profile")
                //                        .padding([.leading, .trailing])
                //                        .padding(.top, screenHeight * 0.01)
                //                        .padding(.bottom, screenHeight * 0.01)
                //                    .overlay(
                //                        RoundedRectangle(cornerRadius: 20)
                //                            .stroke(Color(red: 82 / 255, green: 232 / 255, blue: 255 / 255), lineWidth:
                //                                5)
                //                            )
                //                }
                //                if self.followPressed == false{
                //                Text("Or press the button below to instantly byte them!")
                //                    .font(.system(size: 20))
                //                    .padding()
                //
                //                //press the button below to "byte" them and receive their content updates on your bytestream
                //                Button(action: {
                //                    let userInfo =  self.db.collection("Users").document("Users").collection("Users").document(currentUser.username)
                //                    userInfo.getDocument { (snapshot, err) in
                //                        print("---")
                //                        print(snapshot!["following"])
                //                        let following = snapshot!["following"] as! [String]
                //                        self.alreadyFollowing = false
                //                        if following.contains(self.foundUsername) && self.foundUsername != currentUser.username{
                //                            self.alreadyFollowing = true
                //                        } else{
                //                            self.addUser = true
                //                        }
                ////                        if following.keys.contains(self.foundUsername){
                ////                            self.alreadyFollowing = true
                ////                        }
                //                    }
                //                    //self.addUser = true
                //
                //                }){
                //                    Text("Byte!")
                //                        .padding([.leading, .trailing])
                //                        .padding(.top, screenHeight * 0.01)
                //                        .padding(.bottom, screenHeight * 0.01)
                //                    .overlay(
                //                        RoundedRectangle(cornerRadius: 20)
                //                            .stroke(Color(red: 82 / 255, green: 232 / 255, blue: 255 / 255), lineWidth:
                //                                5)
                //                            )
                //                }
                //                Text("Byting a user will allow you to see all of their soundbytes on your bytestream!")
                //                    .font(.system(size: 15))
                //                    .padding([.leading, .trailing, .top])
                //                }
                //
                //                if self.alreadyFollowing == true{
                //                    VStack{
                //                            Text("You're already following \(self.foundUsername)")
                //                            .padding()
                //                                //maybe change this color?
                //                                .foregroundColor(Color.red)
                //                        }
                //                    }
                //
                //
                //                if self.addUser == true{
                //                    //print("asdf")
                //                   // print("afs")
                //                    //print("\(self.foundUsername)")
                //                    if self.foundUsername == currentUser.username{
                //                        VStack{
                //                            Text("You can't byte yourself ;)")
                //                            .padding()
                //                                //maybe change this color?
                //                                .foregroundColor(Color.red)
                //                        }
                //                    }
                //                    else if self.alreadyFollowing == true{
                //                        VStack{
                //                            Text("You're already following \(self.foundUsername)")
                //                            .padding()
                //                                //maybe change this color?
                //                                .foregroundColor(Color.red)
                //                        }
                //                    }
                //
                //                    //also need to check if already following them
                //                    else{
                //                        VStack{
                //                            Text("You successfully bit \(self.foundUsername)")
                //                                .font(.system(size: 24))
                //                                .bold()
                //                                .padding()
                //
                //                            Text("Check out their profile:")
                //                            .padding()
                //                            //have link to profile page below
                //                        }.padding()
                //                            .onAppear(){
                //                                self.followPressed = true
                //                                let userInfo =  self.db.collection("Users").document("Users").collection("Users").document(currentUser.username)
                //                                let currentFollowingArray = userInfo.getDocument { (snapshot, error) in
                //                                    if error != nil {
                //                                        print(error)
                //                                    } else{
                //                                        var followingArray = snapshot!["following"] as! [String]
                //                                        followingArray.append(self.foundUsername)
                //                                        let followingDictionary = ["following":followingArray]
                //                                        userInfo.setData(followingDictionary, merge: true) { (err) in
                //                                            if let err = err{
                //                                                print("error")
                //                                            } else{
                //
                //                                         }
                //                                        }
                //                                    }
                //                                }
                //
                //                                let followedInfo = self.db.collection("Users").document("Users").collection("Users").document(self.foundUsername)
                //                                let currentFollowerArray = followedInfo.getDocument { (snapshot, error) in
                //                                    if error != nil {
                //                                        print (error)
                //                                    } else{
                //                                        var followerArray = snapshot!["followers"] as! [String]
                //                                        followerArray.append(currentUser.username)
                //                                        let updatedFollowerArray = ["followers":followerArray]
                //                                         followedInfo.setData(updatedFollowerArray, merge: true) { (err) in
                //                                             if let err = err{
                //                                                 print("error")
                //                                             }
                //                                         }
                //                                    }
                //                                }
                
                //print(self.foundUsername)
                // }
                //}
                // }
                // }
                //  Spacer()
                
            }
            //        VStack{
            //            if ($username != ""){
            //
            //            }
            //        }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(false)
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}

