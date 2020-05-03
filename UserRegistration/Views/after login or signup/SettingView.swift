//
//  SettingView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/17.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    
    var datas: FirebaseData
    @EnvironmentObject var shareData: ShareData
    @State var isModal = false
    
    
    var body: some View {
        
        Group {
            if datas.session != nil {
                GeometryReader{ geo in
                    VStack {
                        Group{
//                            if !self.shareData.editOn{
                                NavigationView{
                                ZStack{
                                    self.shareData.white.edgesIgnoringSafeArea(.all)
                                    ScrollView(showsIndicators: false){
                                    VStack{
                                        FirebaseImageView(imageURL: self.shareData.imageURL).frame(width: geo.size.width * 0.8, height: geo.size.height * 0.4).cornerRadius(10).shadow(radius: 2, x: 2, y: 2).padding(.vertical, 10)
                                        ProfileUserDetailView(
                                            name: String(describing: self.shareData.currentUserData["name"] ?? ""),
                                            age: String(describing: self.shareData.currentUserData["age"] ?? ""),
                                            gender: String(describing: self.shareData.currentUserData["gender"] ?? ""),
                                            hometown: String(describing: self.shareData.currentUserData["hometown"] ?? ""),
                                            subject: String(describing: self.shareData.currentUserData["subject"] ?? ""),
                                            introduction: String(describing: self.shareData.currentUserData["introduction"] ?? ""),
                                            studystyle: String(describing: self.shareData.currentUserData["studystyle"] ?? ""),
                                            hobby: String(describing: self.shareData.currentUserData["hobby"] ?? ""),
                                            personality: String(describing: self.shareData.currentUserData["personality"] ?? ""),
                                            work: String(describing: self.shareData.currentUserData["work"] ?? ""),
                                            purpose: String(describing: self.shareData.currentUserData["purpose"] ?? "")).frame(width: geo.size.width * 0.9)
                                        
                                        Button(action: {
                                            self.isModal = true
                                        }) {
                                            Text("編集する")
                                        }
                                        .padding()
                                            .frame(width: geo.size.width * 0.7, height: geo.size.height * 0.05)
                                            .foregroundColor(self.shareData.white)
                                        .background(self.shareData.pink).cornerRadius(10)
                                        .shadow(radius: 2, y: 2)
                                        .frame(width: geo.size.width * 1, height: geo.size.height * 0.05)
                                        .padding(.vertical)
                                        
                                        Button("ログアウト"){
                                            
                                            self.datas.logOut()
                                            self.shareData.currentUserData = [String : Any]()
                                            print("ログアウトしました")
                                        } //ProfileUserDetailView
                                            .foregroundColor(Color.gray)
                                            .padding(.bottom)
                                    }
                                    }
                                }//zs
                                    .navigationBarTitle(Text("あなたのプロフィール"), displayMode: .inline)
                            }//navi
//                            }
//                            else {
//                                //                    ProfileEditView(datas: self.datas)
//                            }
                        }//Group
                            .sheet(isPresented: self.$isModal) {
                                ProfileEditView(datas: self.datas).environmentObject(self.shareData)
                                
                        }
                        
                        
                    }
                }//geo
                    
                    .onAppear{
                        self.shareData.loadImageFromFirebase(path: "images/pictureOf_\(String(describing: self.shareData.currentUserData["email"] ?? ""))")
                }
                //            .navigationBarTitle("あなたのプロフィール", displayMode: .inline)
                //        .navigationBarHidden(true)
            } else {
                TopPageView().environmentObject(self.shareData)
            }
            
        }
        
    }
}

//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView()
//    }
//}
