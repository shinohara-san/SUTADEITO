//
//  LoginView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/16.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.


import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @ObservedObject private var datas = firebaseData
    @EnvironmentObject var shareData: ShareData
    
    let messages = ["このアプリでは、\n「日中」に「カフェ」で\n「一緒に勉強する」\nという最初のデートを推奨しています。", "時間のかかるやり取りはなるべく短くし、会って、相手の空気感を感じてみてください。" , "お互いに勉強していれば会話が苦手でも大丈夫。「勉強」ですべての出会いが有意義なものになる。", "そんな真面目で安心な出会いを応援します。"]
    @State var index = 0
    
    @State var x: CGFloat = 0
    @State var count: CGFloat = 0
    @State var screen = UIScreen.main.bounds.width
    
    @Environment(\.presentationMode) var presentation
    

    
    func getMid()->Int{
        return shareData.pictures.count/2
    }
    
    func getUser() {
        datas.listen()
    }
    
    @State var visible = false
    
    var body: some View {
        
        Group {
            if datas.session != nil {
                
                MainView(self.datas)
                    .navigationBarBackButtonHidden(true)
                    .onAppear(perform: getUser)
                
            } else {
                
                NavigationView {
                    GeometryReader{ geometry in
                    ZStack{
                        
                        ScrollView {
                                   // Add the ImageCarouselView Here.
                                   GeometryReader { geometry in
                                   ImageCarouselView(numberOfImages: 4) {
                                      Image("coffeeheart")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: geometry.size.width)
                                        .clipped()
                                       Image("manwoman")
                                       .resizable()
                                        .scaledToFill()
                                       .frame(width: geometry.size.width)
                                       .clipped()
                                      Image("holdpen")
                                       .resizable()
                                       .scaledToFill()
                                       .frame(width: geometry.size.width)
                                       .clipped()
                                    Image("couple")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width)
                                    .clipped()
                                      }
                                   .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                                   }
                               }.edgesIgnoringSafeArea(.all)
                        Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                        
                        VStack{
                            Spacer()
                            TextField("email", text: self.$email)
                                .disableAutocorrection(true)
                                .textFieldStyle(CustomTextFieldStyle(geometry: geometry))
                                
                                .keyboardType(.emailAddress)
                                .padding(.bottom)
                            VStack{
                                if self.visible{
                                    TextField("password", text: self.$password)
                                }else{
                                   SecureField("password", text: self.$password)
                                }
                                
                                
                            }
                            .textFieldStyle(CustomTextFieldStyle(geometry: geometry))
                            .keyboardType(.emailAddress)
                            
                            
                            Button(action: {
                                self.visible.toggle()
                            }) {
                                Text(self.visible ? "非表示にする" : "表示する").foregroundColor(Color.myWhite).font(.subheadline)
                            }.padding(.bottom)
                            
                            Button(action: {
                                if self.email == "" || self.password == ""{
                                    return
                                }
                                self.datas.logIn(email: self.email.trimmingCharacters(in: .whitespacesAndNewlines), password: self.password.trimmingCharacters(in: .whitespacesAndNewlines)) { (res, err) in
                                    if err != nil {
                                        print("Error: ログイン")
                                        
                                    } else {
                                        self.email = ""
                                        self.password = ""
//                                        self.datas.listen()
                                    }
                                }
                            }) {
                                Text("ログイン")
                                    .textStyle(fcolor: Color.myWhite, bgcolor: Color.myPink, geometry: geometry)
                            }.padding(.bottom, 50)
                            
                            Button(action: {
                                self.presentation.wrappedValue.dismiss()
                            }, label: {
                                Text("戻る").foregroundColor(Color.myWhite).underline(color: Color.myWhite)
                            }).padding(.bottom, 50)
                            
                            Spacer()
                            
                        }.onAppear(perform: self.getUser)
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                            .padding(.top, 80)
                        
                        }
                    }
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                
            }
            
        }
        
        }
    
    }
    
    
    

    
//
//    struct LoginView_Previews: PreviewProvider {
//        static var previews: some View {
//            LoginView()
//        }
//}
