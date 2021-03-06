//
//  MainView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/16.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

struct MainView: View {
    
    var datas: FirebaseData
    
    @EnvironmentObject var shareData: ShareData
    
    @State var selection = 0 //ないと表示が崩れる?
    
    @State var userInfo:User = EmptyUser.forLayout
    
    init(_ datas: FirebaseData) {
        self.datas = datas
        UITabBar.appearance().barTintColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
    }
    
    
    var body: some View {
        
        GeometryReader{ geometry in
            ZStack{
                TabView(selection: self.$selection) {
                    ////ユーザー一覧のページ
//                    NavigationView{
                    UserListView().frame(width: geometry.size.width)
//                    }
                        .tabItem {
                            VStack {
                                SFSymbol.forList
                            }
                    }.tag(1)
                    
                    ////                    検索ページ
                    SearchView()
                        .tabItem {
                            VStack {
                                SFSymbol.forSearch
                            }
                    }.tag(2)
                    
                    ///お気に入り/いいね一覧ページ
                    Group{
                        if self.shareData.switchFavAndLike{
                            LikeUserView()
                        } else {
                            FavoriteUserView()
                        }
                    }
                    .tabItem {
                        VStack {
                            SFSymbol.forFaveriteLike
                        }
                    }
                    .tag(3)
                    
                    
                    
                    LikeMeUserView()
                        
                        .tabItem {
                            VStack {
                                SFSymbol.forGivenLike
                            }
                    }.tag(4)
                    
                    
                    
                    ////                   マッチングページ
                    MatchingListView()
                        .tabItem {
                            VStack {
                                SFSymbol.forMatch
                            }
                    }.tag(5)
                    
                    
                    
                } //tabView
                    .environmentObject(self.shareData)
                    .accentColor(Color.myPink)
                    .animation(nil)
                
                if self.shareData.myProfile{
                    SettingView(datas: self.datas).environmentObject(self.shareData)
                    
                }
                
                if self.shareData.searchBoxOn{
                    Color.black.edgesIgnoringSafeArea(.all).opacity(0.3)
                    SearchBoxView()
                        .background(Color.myWhite)
                        .frame(width : geometry.size.width * 0.9, height: geometry.size.height * 0.7)
                        .cornerRadius(10)
               
                }
                
            }//ZStack
            
        }
        .navigationBarTitle("")
            .navigationBarHidden(true) //自分のプロフィール用
            .onAppear{
                self.shareData.myProfile = false
                //self.shareData.filteredMatchUserArray = [User]()//追記0507
        }
    }
}

