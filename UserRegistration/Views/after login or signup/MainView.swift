//
//  MainView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/16.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//
//shino@aaa.com
//　1234shino

import SwiftUI
import FirebaseFirestore

struct MainView: View {
    
    var datas: FirebaseData
    
    @EnvironmentObject var shareData: ShareData
    
    //@State var selection = 0 //必要?
    
    @State var userInfo:User = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")
    
    @State var messageOn = false
    @State var userProfileOn = false
    @State var text = ""
    
    @State var matchid = ""
    
    var body: some View {
        
        TabView {
            ////ユーザー一覧のページ

            Group{
                if !userProfileOn{
                    ScrollView{
                        VStack{
                            ForEach(self.shareData.allUsers){ user in

                                VStack{
                                    FirebaseImageView(imageURL: user.photoURL)
                                    HStack{
                                        Text("\(user.gender)") //テスト
                                        Text(user.age)
                                        Text(user.hometown)
                                    }
                                    Text(user.introduction)
                                    //
                                }
                                .onTapGesture {
                                    self.userInfo = user
                                    self.userProfileOn = true
//                                    self.shareData.test1()
                                    }
                                    
//                                } //追加
                                

                            } //foreach
                                .buttonStyle(PlainButtonStyle())
                            
                        }//Vstack
                            
                            
                            .onAppear{
                                DispatchQueue.global().async {
                                    self.shareData.getCurrentUser()

                                }

                                
                        }
//                        .onDisappear(){
//                            self.shareData.matchUserId = [String]()
//                        }
                        
                    }//Scrollview
                } else {
                    VStack{
                        UserProfileView(user: userInfo)
                        Button("戻る"){
                            self.userProfileOn = false
                        }
                    }
                    
                }
                
            }//Profile
               
                .navigationBarTitle("")
                .navigationBarHidden(false)
                .tabItem {
                    VStack {
                        Image(systemName: "book")
                    }
            }.tag(1)
            
            ////                    検索ページ
            SearchView()
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                    }
            }.tag(2)
            
            ///お気に入りいいね一覧ページ
            
            FavoriteAndLikeUserView(userProfileOn: $userProfileOn)
                
                .tabItem {
                    VStack {
                        Image(systemName: "star")
                    }
            }
            .tag(3)
            
            
            
            ////                   マッチングページ
            Group{
                
                VStack{
                    Text("マッチ一覧")
                    List(self.shareData.matchUserArray){ user in
                        //写真タップでプロフィール表示
                        NavigationLink(destination: MessageView(user, self.matchid)){
                            HStack{
                                Text(user.name)
                                Text(user.age)
                            }.onTapGesture {
//                                self.userInfo =user
                                Firestore.firestore().collection("MatchTable").document(self.shareData.currentUserData["id"] as! String).collection("MatchUser").whereField("MatchUserId", isEqualTo: user.id).getDocuments { (snap, err) in
                                    if snap != nil {
                                        for i in snap!.documents{
                                            self.matchid = i.data()["MatchRoomId"] as! String
                                        }
                                    }
                                }
                                print(self.matchid)
                            }

                        }

                    }
                }
                
            }.onAppear{
                self.shareData.getAllMatchUser()
               
            }.onDisappear{
                self.shareData.matchUserArray = [User]()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .tabItem {
                VStack {
                    Image(systemName: "suit.heart")
                }
            }.tag(4)
            
            ////                    自分のプロフィールページ
            SettingView(datas: self.datas)
                .tabItem {
                    VStack {
                        Image(systemName: "ellipsis")
                    }
            }.tag(5)
            
        } //tabView
            .onAppear{
                print("メインビュー")
        }
            
        .navigationBarTitle("")
        .navigationBarHidden(true)
        
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}

