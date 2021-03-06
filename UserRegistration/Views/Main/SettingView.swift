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
                            NavigationView{
                                ZStack{
                                    Color.myWhite.edgesIgnoringSafeArea(.all)
                                    ScrollView(showsIndicators: false){
                                        VStack{
                                            FirebaseImageView(imageURL: self.shareData.imageURL).frame(width: geo.size.width * 1, height: geo.size.height * 0.4).border(Color.myBrown, width: 5).cornerRadius(10).shadow(radius: 2, x: 2, y: 5).padding(.vertical, 10)
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
                                                purpose: String(describing: self.shareData.currentUserData["purpose"] ?? ""),
                                                fee: String(describing: self.shareData.currentUserData["fee"] ?? ""),
                                                schedule: String(describing: self.shareData.currentUserData["schedule"] ?? ""),
                                                place: String(describing: self.shareData.currentUserData["place"] ?? "")
                                            ).frame(width: geo.size.width * 1)
                                            
                                            Button(action: {
                                                self.isModal = true
                                            }) {
                                                Text("編集する")
                                                    .textStyle(fcolor: Color.myWhite, bgcolor: Color.myPink, geometry: geo)
                                                    .padding(.vertical)
                                            }
                                            
                                            .sheet(isPresented: self.$isModal) {
                                                ProfileEditView(datas: self.datas).environmentObject(self.shareData)
                                            }
                                            
                                            Button("ログアウト"){
                                                
                                                self.datas.logOut()
                                                self.shareData.myProfile = false
                                                self.shareData.currentUserData = [String : Any]()
                                                self.shareData.filteredMatchUserArray = [User]()
                                                self.shareData.filteredAllUsers = [User]()
                                                self.shareData.filteredFavoriteUsers = [User]()
                                                self.shareData.filteredLikeUsers = [User]()
                                                self.shareData.filteredLikeMeUsers = [User]()
                                                print("ログアウトしました")
                                            } //ProfileUserDetailView
                                                .foregroundColor(Color.gray)
                                                .padding(.bottom)
                                            
                                            
                                        }
                                    }
                                }//zs
                                    .navigationBarTitle(Text("あなたのプロフィール"), displayMode: .inline)
                                    .navigationBarItems(trailing:
                                        Button(action: {
                                            self.shareData.myProfile = false
                                        }, label: {
                                            Image(systemName: "return").foregroundColor(Color.myWhite)
                                        })
                                        
                                )
                            }//navi
                            
                        }//Group
                            
                        
                        
                    }
                }//geo
               
                    
                    .onAppear{
                        self.shareData.loadImageFromFirebase(path: "images/pictureOf_\(String(describing: self.shareData.currentUserData["email"] ?? ""))")
                }
                
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
