

//マッチのところをどうするか

//お気に入りの表示を修正したい

//チャット

//検索

//各種バリデーション

//ログイン時の時間をFirestoreに保存　→ アイコンの色をそれに応じて変える

//デザイン

//https://www.youtube.com/watch?v=4d-Lx4WtNiM
//loadingアニメーション


//【修正済み】
//プロフィール画像が最初表示されるが、別ページ行って帰ってくるともう二度と表示されない。(遅いけど一応修正)
//居住地, 性別をピッカーに、年齢をスライダーかピッカーに

//新規とうろくしたらあの不具合直る


//
//  MainView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/16.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//
//shino@aaa.com
//　1234shino

//import SwiftUI
//
//struct MainView: View {
//
//    var datas: FirebaseData
//
//    @EnvironmentObject var shareData: ShareData
//
//    @State var selection = 0
//
//    @State var userProfileOn = false
//
//    @State var userInfo:User = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "")
//    var body: some View {
//
//        TabView(selection: $selection) {
//            //            ListView(datas: self.datas)
//            //                NavigationView{
//            Group{
//                if !userProfileOn{
//                    ScrollView{
//                        VStack{
//                            ForEach(self.shareData.allUsers){ user in
//
////                                NavigationLink(destination: UserProfileView(user: user)) {
//                                VStack{
//                                    FirebaseImageView(imageURL: user.photoURL)
//                                    HStack{
//                                        Text("\(user.gender)") //テスト
//                                        Text(user.age)
//                                        Text(user.hometown)
//                                    }
//                                    Text(user.introduction)
//                                    //
//                                }
//                                .onTapGesture {
//                                    self.userInfo = user
//                                    self.userProfileOn = true
//                                }
////                                } //navigationlink
////                                    .buttonStyle(PlainButtonStyle())
//
//                            } //foreach
//                            .buttonStyle(PlainButtonStyle())
//
//                        }//Vstack
//
//
//                            .onAppear{
//                                DispatchQueue.global().sync {
//                                    self.shareData.getCurrentUser() //ログイン中のユーザー情報を取得し、そのあと全表示ユーザー情報取得
//                                    print("リストビュー")
//                                }
//                        }
//                        .onDisappear(){
//                            //                            self.allUsers = [User]()
//                        }
//
//                    }//Scrollview
//                } else {
//                    VStack{
//                        UserProfileView(user: userInfo)
//                        Button("戻る"){
//                            self.userProfileOn = false
//                        }
//                    }
//
//                }
//
//            }//Profile
//
//                .navigationBarTitle("")
//                .navigationBarHidden(false)
//                .tabItem {
//                    VStack {
//                        Image(systemName: "book")
//                    }
//            }.tag(1)
//            SearchView()
//                .tabItem {
//                    VStack {
//                        Image(systemName: "magnifyingglass")
//                    }
//            }.tag(2)
//            FavoriteView()
//
//                .tabItem {
//                    VStack {
//                        Image(systemName: "star")
//                    }
//            }
//            .tag(3)
//
//            MatchView()
//                .tabItem {
//                    VStack {
//                        Image(systemName: "suit.heart")
//                    }
//            }.tag(4)
//            SettingView(datas: self.datas)  //environmentに書き換えたい
//                .tabItem {
//                    VStack {
//                        Image(systemName: "ellipsis")
//                    }
//            }.tag(5)
//        }.onAppear{
//            print("メインビュー")
//        }
//
//        .navigationBarTitle("")
//        .navigationBarHidden(true)
//
//    }
//}


//
//struct FavoriteView: View {
//    @EnvironmentObject var shareData: ShareData
//
//    let db = Firestore.firestore()
//    func getUserInfo(favoriteUserId: String){
//        db.collection("Users").whereField("id", isEqualTo: favoriteUserId).getDocuments { (snap, err) in
//            if let err = err {
//                print(err.localizedDescription)
//                return
//            } else {
//                for user in snap!.documents{
//                    self.shareData.favoriteUsers.append(User(id: user.data()["id"] as! String, email: user.data()["email"] as! String, name: user.data()["name"] as! String, gender: user.data()["gender"] as! String, age: user.data()["age"] as! String, hometown: user.data()["hometown"] as! String, subject: user.data()["subject"] as! String, introduction: user.data()["introduction"] as! String, studystyle: user.data()["studystyle"] as! String, hobby: user.data()["hobby"] as! String, personality: user.data()["personality"] as! String, work: user.data()["work"] as! String, purpose: user.data()["purpose"] as! String, photoURL: user.data()["photoURL"] as! String))
//                }
//            }
//        }
//
//    }
//
//    func getIds(){
//        db.collection("FavoriteTable").document(self.shareData.currentUserData["id"] as! String).collection("FavoriteUser").getDocuments { (snap, err) in
//            for i in snap!.documents{
//                self.shareData.favoriteUserIds.append(i.data()["FavoriteUserId"] as! String)
////                print(self.shareData.favoriteUserIds)
//            }
//        }
//    }
//
//
////        for favoriteUserId in self.shareData.favoriteUserIds{
//////            self.shareData.favoriteUsers = [User]()
////            self.getUserInfo(favoriteUserId: favoriteUserId)
////        }
////
//
//
//
//    var body: some View {
//            VStack{
//                Text("Favorite view")
////                ForEach(self.shareData.favoriteUserIds){ id in
////                    Text(self.shareData.favoriteUserIds[id])
////                }
////                ForEach(self.displayedUser)
//            }
//
//        .navigationBarTitle("")
//        .navigationBarHidden(true)
//        .onAppear{()
//            self.getIds()
//            self.shareData.getFavoriteUsers()
//            print(self.shareData.favoriteUserIds)
////            print(self.shareData.favoriteUsers)
//        }
//        .onDisappear{
//            self.shareData.favoriteUserIds = []
//        }
//    }
//}
//
//
//struct FavoriteView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteView()
//    }
//}


//func getFavoriteUsers(){
//
//       db.collection("FavoriteTable").document(self.currentUserData["id"] as! String).collection("FavoriteUser")
//           //            .whereField("MyUserId", isEqualTo: self.shareData.currentUserData["id"] as! String)
//           .addSnapshotListener { (snap, err) in
//
//               guard let snapshot = snap else {
//                   print("Error fetching snapshots: \(err!)")
//                   return
//               }
//               snapshot.documentChanges.forEach { diff in
//                   if (diff.type == .added) {
//                       //                        print("New favorite:  \(diff.document.data()["FavoriteUserId"] ?? "")")
//                       self.favoriteUserIds.append(diff.document.data()["FavoriteUserId"] as! String)
//                   }
//                   //                    if (diff.type == .modified) {
//                   //                        print("Modified city: \(diff.document.data())")
//                   //                    }
//                   if (diff.type == .removed) {
//                       //                        print("Removed favorite: \(diff.document.data()["FavoriteUserId"] ?? "")")
//                       for userId in self.favoriteUserIds{
//                           if userId == diff.document.data()["FavoriteUserId"] as! String{
//                               if let index = self.favoriteUserIds.firstIndex(of: userId) {
//                                   print("\(self.favoriteUserIds[index])を削除しました")
//                                   self.favoriteUserIds.remove(at: index)
//                               }
//                           }
//                       }
//                   }
//
//               }
//       }
//   }



//                ScrollView{
//                                        VStack{
//                                            ForEach(self.shareData.allUsers){ user in
//
//                //                                NavigationLink(destination: UserProfileView(user: user)) {
//                                                VStack{
//                                                    FirebaseImageView(imageURL: user.photoURL)
//                                                    HStack{
//                                                        Text("\(user.gender)") //テスト
//                                                        Text(user.age)
//                                                        Text(user.hometown)
//                                                    }
//                                                    Text(user.introduction)
//                                                    //
//                                                }
//                                                .onTapGesture {
//                                                    self.userInfo = user
//                                                    self.userProfileOn = true
//                                                }
//                //                                } //navigationlink
//                //                                    .buttonStyle(PlainButtonStyle())
//
//                                            } //foreach
//                                            .buttonStyle(PlainButtonStyle())
//
//                                        }//Vstack
//
//
//                                            .onAppear{
//                                                DispatchQueue.global().sync {
//                                                    self.shareData.getCurrentUser() //ログイン中のユーザー情報を取得し、そのあと全表示ユーザー情報取得
//                                                    print("リストビュー")
//                                                }
//                                        }
//                                        .onDisappear(){
//                                            //                            self.allUsers = [User]()
//                                        }
//
//                                    }//Scrollview



///
////  FavoriteView.swift
////  UserRegistration
////
////  Created by Yuki Shinohara on 2020/04/17.
////  Copyright © 2020 Yuki Shinohara. All rights reserved.
//
//import SwiftUI
//import FirebaseFirestore
//
//struct FavoriteView: View {
//
////    let db = Firestore.firestore()
//    @EnvironmentObject var shareData: ShareData
//
////    @State var favoriteUserIds = [String]()
//
//    @State var favoriteProfileOn = false
//
//
//    var body: some View {
//
//                VStack{
//
//                    ForEach(self.shareData.favoriteUsers, id: \.self){ user in
//                        Text(user.name)
//                    }
//
//            }
//        .navigationBarTitle("")
//        .navigationBarHidden(true)
//        .onAppear{
//            self.shareData.favoriteUserIds = [String]()
////            self.shareData.getFavoriteUsers()
//
//        }
////        .onDisappear{
//////            self.shareData.favoriteUserIds = [String]()
////        }
//    }
//}




//U SERRWINDE ww
////
////  UserWindowView.swift
////  UserRegistration
////
////  Created by Yuki Shinohara on 2020/04/20.
////  Copyright © 2020 Yuki Shinohara. All rights reserved.
////
//
////お気に入りユーザー一覧で使う一つ一つの表示用
//
//import SwiftUI
//import FirebaseFirestore
//
////このページをfavoriteに移植したい
//
//struct UserWindowView: View {
//    @EnvironmentObject var shareData : ShareData
//    var userId:String
//
//    var body: some View {
////        NavigationView{
//
//            VStack{ //このview自体が一つのセクションなのでnavilinkはうまく効かない
//
////                FirebaseImageView(imageURL: self.shareData.displayedUser.photoURL)
////                HStack{
////                    Text(self.shareData.displayedUser.name)
////                    Text(self.shareData.displayedUser.hometown)
//                    //displayedUserが一人だから
//
//                ForEach(self.shareData.favoriteUsers, id: \.self){ user in
//                    Text(user.name)
//                }
//
//            }
//        .buttonStyle(PlainButtonStyle())
////        }
//        .onAppear{
////        self.getUserInfo()
//
////            self.shareData.favoriteUserIds = [String]()
//            self.shareData.getUserInfo(userId: self.userId)
//        }
//
//    } //body
//} //全体
//
////struct UserWindowView_Previews: PreviewProvider {
////    static var previews: some View {
////        UserWindowView()
////    }
////}
//
//func getUserInfo(userId: String){
//    db.collection("Users").whereField("id", isEqualTo: userId).getDocuments { (snap, err) in
//        if let err = err {
//            print(err.localizedDescription)
//            return
//        } else {
//            for user in snap!.documents{
//                self.favoriteUsers.append(User(id: user.data()["id"] as! String, email: user.data()["email"] as! String, name: user.data()["name"] as! String, gender: user.data()["gender"] as! String, age: user.data()["age"] as! String, hometown: user.data()["hometown"] as! String, subject: user.data()["subject"] as! String, introduction: user.data()["introduction"] as! String, studystyle: user.data()["studystyle"] as! String, hobby: user.data()["hobby"] as! String, personality: user.data()["personality"] as! String, work: user.data()["work"] as! String, purpose: user.data()["purpose"] as! String, photoURL: user.data()["photoURL"] as! String))
//            }
//        }
//    }
//
//}


///マッチ一覧で使えそう
//func getAllLikeUsers(){
//      db.collection("LikeTable").whereField("LikeUserId", isEqualTo: self.currentUserData["id"] as? String ?? "").getDocuments { (snap, err) in
//              if let err = err{
//                  print(err.localizedDescription)
//                  return
//              }
//
//              if let snap = snap {
//                  for user1 in snap.documents {
//  //                    print(user.data()["FavoriteUserId"] as? String ?? "")
//                      self.db.collection("Users").whereField("id", isEqualTo: user1.data()["MyUserId"] as? String ?? "").getDocuments { (snap, err) in
//                          if let snap = snap {
//                              for user in snap.documents {
//
//                                  self.likeUsers.append(User(id: user.data()["id"] as! String, email: user.data()["email"] as! String, name: user.data()["name"] as! String, gender: user.data()["gender"] as! String, age: user.data()["age"] as! String, hometown: user.data()["hometown"] as! String, subject: user.data()["subject"] as! String, introduction: user.data()["introduction"] as! String, studystyle: user.data()["studystyle"] as! String, hobby: user.data()["hobby"] as! String, personality: user.data()["personality"] as! String, work: user.data()["work"] as! String, purpose: user.data()["purpose"] as! String, photoURL: user.data()["photoURL"] as? String ?? ""))
//
//                              }
//                              } else {
//                              print(err?.localizedDescription ?? "")
//                              return
//                          }
//                      }
//                  }
//              } else { return }
//              self.likeUsers.remove(at: 0)
//          }
//      }





//                    VStack{
//
//                        Button("戻る"){
//                            self.messageOn = false
//                        }
//                        Text("\(self.matchUserInfo.name)とのメッセージ画面")
//
//                        List(msgVM.messages, id: \.id){ i in
//                            if i.fromUser == self.shareData.currentUserData["id"] as! String && i.toUser == self.matchUserInfo.id {
//                                MessageRow(message: i.msg, isMyMessage: true)
//                            } else if i.fromUser == self.matchUserInfo.id && i.toUser == self.shareData.currentUserData["id"] as! String {
//                                MessageRow(message: i.msg, isMyMessage: false)
//                            }
//                        }
////                        .onAppear { UITableView.appearance().separatorStyle = .none }
////                        .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
//
//
//                        HStack{
//                            TextField("メッセージ", text: $text).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
//                            Button(action: {
//                                print("メッセージ送信 \(self.text)")
//                                self.msgVM.sendMsg(msg: self.text, toUser: self.matchUserInfo.id, fromUser: self.shareData.currentUserData["id"] as! String)
//                                self.text = ""
//                            }) {
//                                Image(systemName: "paperplane")
//                            }.padding(.trailing)
//                        }
//
//                    }



//    @Published var messages = [Message]()
//
//    func messageModel(){
//        db.collection("Messages").document(self.currentUserData["id"] as! String).collection("messageRoom").order(by: "date").addSnapshotListener { (snap, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//            if let snap = snap {
//                for i in snap.documentChanges {
//                    if i.type == .added {
//                        let toUser = i.document.get("toUser") as! String
//                        let fromUser = i.document.get("fromUser") as! String
//                        let message = i.document.get("message") as! String
//                        let id = i.document.documentID
//                        let date = i.document.get("date") as! Timestamp
//
//                        self.messages.append(Message(id: id, msg: message, fromUser: fromUser, toUser: toUser, date: date))
//
//                    }
//                }
//            }
//        }
//    }
//
//    func sendMsg(msg: String, toUser: String, fromUser: String){
//            let data1 = [
//                "message": msg,
//                "toUser": toUser,
//                "fromUser": fromUser,
//                "date": Timestamp()
//                ] as [String : Any]
//
//            let data2  = [
//                       "message": msg,
//                       "toUser": fromUser,
//                       "fromUser": toUser,
//                       "date": Timestamp()
//                       ] as [String : Any]
//
//            db.collection("Messages").addDocument(data: data1){ error in
//                if let err = error {
//                    print(err.localizedDescription)
//                    return
//                }
//                print("メッセージを送信しました")
//            }
//
//          messages 自分ID messageroom 相手ID db.collection("Messages").document(toUser).collection("messageRoom").addDocument(data: data2){ error in
//                if let err = error {
//                    print(err.localizedDescription)
//                    return
//                }
//                print("メッセージを送信しました")
//            }
//        }
        


//func filterUsers(){
/////        マッチを先に送った方の表示Ok, 後から送った方の表示Ok、でもマッチ二人以上だとsucks
//        db.collection("MatchTable").document(self.currentUserData["id"] as? String ?? "").collection("MatchUser").getDocuments { (snap, err) in
//            if err != nil{
//                print(err?.localizedDescription as Any)
//                return
//            }
//            if snap!.count > 0 {
//                for id in snap!.documents{
//                    print("マッチあり") //マッチあるとき
//                    self.allUsers = [User]() //初期値で空配列を入れているが（scrollview用）まずはそれを掃除
//
//
//                    self.db.collection("Users").getDocuments { (querySnapshot, err) in
//                        if let err = err {
//                            print("Error getting documents: \(err)")
//                            return
//                        }
//                        if let snap = querySnapshot {
//                            for user in snap.documents {
//                                //                                print("マチのID: \(id.data()["MatchUserId"] as! String)")
//                                //                                print("全員のID: \(user.data()["id"] as! String)")
//                                if user.data()["gender"] as? String != self.currentUserData["gender"] as? String
//                                {
//                                    if user.data()["id"] as? String != id.data()["MatchUserId"] as? String
////                                        && user.data()["id"] as? String != id.data()["MyUserId"] as? String
//                                    {
//                                        self.allUsers.append(User(
//                                            id: user.data()["id"] as! String,
//                                            email: user.data()["email"] as! String,
//                                            name: user.data()["name"] as! String,
//                                            gender: user.data()["gender"] as! String,
//                                            age: user.data()["age"] as! String,
//                                            hometown: user.data()["hometown"] as! String,
//                                            subject: user.data()["subject"] as! String,
//                                            introduction: user.data()["introduction"] as! String,
//                                            studystyle: user.data()["studystyle"] as! String,
//                                            hobby: user.data()["hobby"] as! String,
//                                            personality: user.data()["personality"] as! String,
//                                            work: user.data()["work"] as! String,
//                                            purpose: user.data()["purpose"] as! String,
//                                            photoURL: user.data()["photoURL"] as! String
//                                        ))
//
//                                    }
//                                    else {
//                                        print("\(String(describing: user.data()["name"]))はマッチずみ")
//                                        print("\(String(describing: user.data()["id"] as? String))はマッチずみ")
//                                        print("\(String(describing: id.data()["MatchUserId"] as? String))はマッチずみ")
//
//                                    }
//                                }
//                                else {
//                                    print("\(String(describing: user.data()["name"]))は同性")
//                                    //                                    print(self.allUsers) //男性全員
//                                }
//
//                            }
//                        }
//                        //            self.allUsers.remove(at: 0)
//                    }
//
//                    
//                }
//
//            } else {
//                print("マッチなし") //マッチないとき
//                self.getAllUsers()
//
//            }
//
//        } //matchtable loop
//
//    }


//マッチあり
//マッチ数: 1
//Optional(ここみ)は同性
//Optional(さとみ)は同性
//Optional(あい)は同性
//Optional(しの)はマッチずみ
//Optional("bBMOxqhM6o5bsHeiuQUm")はマッチずみ
//Optional("bBMOxqhM6o5bsHeiuQUm")はマッチずみ


//            自分用マッチ
//                self.db.collection("Users").whereField("id", isEqualTo:  i.data()["MyUserId"] as? String ?? "").getDocuments { (snap, err) in
//                    if err != nil{
//                        return
//                    }
//                    if let snap = snap {
//                        for user in snap.documents{
//                            user.reference.collection("matchUser").document().setData([
//                                "MatchUserId" : i.data()["LikeUserId"] as? String ?? "",
//                                "MyUserId": i.data()["MyUserId"] as? String ?? ""
//                            ])
//                        }
//                    }
//                }
//                相手用マッチ
//                self.db.collection("Users").whereField("id", isEqualTo:  i.data()["LikeUserId"] as? String ?? "").getDocuments { (snap, err) in
//                    if err != nil{
//                        return
//                    }
//                    if let snap = snap {
//                        for user in snap.documents{
//                            user.reference.collection("matchUser").document().setData([
//                                "MatchUserId" : i.data()["MyUserId"] as? String ?? "",
//                                "MyUserId": i.data()["LikeUserId"] as? String ?? ""
//                            ])
//                        }
//                    }
//                }
                

//case 1:
//             print("マッチあり") //マッチあるとき
//             print("マッチ数: \(snap!.count)")
//             for id in snap!.documents{
//
//                 self.allUsers = [User]() //初期値で空配列を入れているが（scrollview用）まずはそれを掃除
//
//                 self.db.collection("Users").getDocuments { (querySnapshot, err) in
//                     if let err = err {
//                         print("Error getting documents: \(err)")
//                         return
//                     }
//                     if let snap = querySnapshot {
//                         for user in snap.documents {
//                             //                                print("マチのID: \(id.data()["MatchUserId"] as! String)")
//                             //                                print("全員のID: \(user.data()["id"] as! String)")
//                             if user.data()["gender"] as? String != self.currentUserData["gender"] as? String
//                             {
//                                 if user.data()["id"] as? String != id.data()["MatchUserId"] as? String
//
//                                 {
//                                     self.allUsers.append(User(
//                                         id: user.data()["id"] as! String,
//                                         email: user.data()["email"] as! String,
//                                         name: user.data()["name"] as! String,
//                                         gender: user.data()["gender"] as! String,
//                                         age: user.data()["age"] as! String,
//                                         hometown: user.data()["hometown"] as! String,
//                                         subject: user.data()["subject"] as! String,
//                                         introduction: user.data()["introduction"] as! String,
//                                         studystyle: user.data()["studystyle"] as! String,
//                                         hobby: user.data()["hobby"] as! String,
//                                         personality: user.data()["personality"] as! String,
//                                         work: user.data()["work"] as! String,
//                                         purpose: user.data()["purpose"] as! String,
//                                         photoURL: user.data()["photoURL"] as! String
//                                     ))
//
//                                 }
//                                 else {
//                                     print("\(String(describing: user.data()["name"]))はマッチずみ")
//                                     print("\(String(describing: user.data()["id"] as? String))はマッチずみ")
//
//                                 }
//                             }
//                             else {
//                                 print("\(String(describing: user.data()["name"]))は同性")
//
//                             }
//
//                         }
//                     }
//
//
//                 }
//
//             }



//func filterUsers(){
//        ///        マッチを先に送った方の表示Ok, 後から送った方の表示Ok、でもマッチ二人以上だとsucks
//        db.collection("MatchTable").document(self.currentUserData["id"] as? String ?? "").collection("MatchUser").getDocuments { (snap, err) in
//            if err != nil{
//                print(err?.localizedDescription as Any)
//                return
//            }
//
//            switch snap!.count{
//            case 0:
//                print("マッチなし")
//                self.getAllUsers()
//            default:
//                print("マッチあり") //マッチあるとき
//                print("マッチ数: \(snap!.count)")
//                for id in snap!.documents{
//
//                    self.allUsers = [User]() //初期値で空配列を入れているが（scrollview用）まずはそれを掃除
//
//                    self.db.collection("Users").getDocuments { (querySnapshot, err) in
//                        if let err = err {
//                            print("Error getting documents: \(err)")
//                            return
//                        }
//                        if let snap = querySnapshot {
//                            for user in snap.documents {
//                                //                                print("マチのID: \(id.data()["MatchUserId"] as! String)")
//                                //                                print("全員のID: \(user.data()["id"] as! String)")
//                                if user.data()["gender"] as? String != self.currentUserData["gender"] as? String
//                                {
//                                    if user.data()["id"] as? String != id.data()["MatchUserId"] as? String
//
//                                    {
//                                        self.allUsers.append(User(
//                                            id: user.data()["id"] as! String,
//                                            email: user.data()["email"] as! String,
//                                            name: user.data()["name"] as! String,
//                                            gender: user.data()["gender"] as! String,
//                                            age: user.data()["age"] as! String,
//                                            hometown: user.data()["hometown"] as! String,
//                                            subject: user.data()["subject"] as! String,
//                                            introduction: user.data()["introduction"] as! String,
//                                            studystyle: user.data()["studystyle"] as! String,
//                                            hobby: user.data()["hobby"] as! String,
//                                            personality: user.data()["personality"] as! String,
//                                            work: user.data()["work"] as! String,
//                                            purpose: user.data()["purpose"] as! String,
//                                            photoURL: user.data()["photoURL"] as! String
//                                        ))
//
//                                    }
//                                    else {
//                                        print("\(String(describing: user.data()["name"]))はマッチずみ")
//                                        print("\(String(describing: user.data()["id"] as? String))はマッチずみ")
//
//                                    }
//                                }
//                                else {
//                                    print("\(String(describing: user.data()["name"]))は同性")
//
//                                }
//
//                            }
//                        }
//
//
//                    }
//
//                }
//
////            default:
////
////                print("マッチあり") //マッチが二つ以上あるとき
////                print("マッチ数: \(snap!.count)")
////                for id in snap!.documents{
////                    print("相手id: \(String(describing: id.data()["MatchUserId"]))")
////                    print("自分id: \(String(describing: id.data()["MyUserId"]))")
////                    self.allUsers = [User]() //初期値で空配列を入れているが（scrollview用）まずはそれを掃除
////
////                    self.db.collection("Users").getDocuments { (snap, err) in
////                        if let err = err {
////                            print("Error getting documents: \(err)")
////                            return
////                        }
////                        if let snap = snap {
////                            for user in snap.documents {
////                                 print("\(String(describing: user.data()["name"] as? String))はすべてのユーザーの一人です。(ループ前)")
////
////                                if user.data()["gender"] as? String != self.currentUserData["gender"] as? String
////                                {
////                                    print("\(String(describing: user.data()["name"] as? String))はユーザーです。")
////
////                                    if user.data()["id"] as? String == id.data()["MatchUserId"] as? String {
////                                        print("\(String(describing: user.data()["name"] as? String))はIDが\(String(describing: id.data()["MatchUserId"] as? String))でマッチしています。")
////                                        self.MatchUsers.append(User(
////                                        id: user.data()["id"] as! String,
////                                        email: user.data()["email"] as! String,
////                                        name: user.data()["name"] as! String,
////                                        gender: user.data()["gender"] as! String,
////                                        age: user.data()["age"] as! String,
////                                        hometown: user.data()["hometown"] as! String,
////                                        subject: user.data()["subject"] as! String,
////                                        introduction: user.data()["introduction"] as! String,
////                                        studystyle: user.data()["studystyle"] as! String,
////                                        hobby: user.data()["hobby"] as! String,
////                                        personality: user.data()["personality"] as! String,
////                                        work: user.data()["work"] as! String,
////                                        purpose: user.data()["purpose"] as! String,
////                                        photoURL: user.data()["photoURL"] as! String
////                                        ))
////                                        return
////                                    } else {
////
////                                    self.allUsers.append(User(
////                                        id: user.data()["id"] as! String,
////                                        email: user.data()["email"] as! String,
////                                        name: user.data()["name"] as! String,
////                                        gender: user.data()["gender"] as! String,
////                                        age: user.data()["age"] as! String,
////                                        hometown: user.data()["hometown"] as! String,
////                                        subject: user.data()["subject"] as! String,
////                                        introduction: user.data()["introduction"] as! String,
////                                        studystyle: user.data()["studystyle"] as! String,
////                                        hobby: user.data()["hobby"] as! String,
////                                        personality: user.data()["personality"] as! String,
////                                        work: user.data()["work"] as! String,
////                                        purpose: user.data()["purpose"] as! String,
////                                        photoURL: user.data()["photoURL"] as! String
////                                    ))
////                                    }
////
////                                } //閉じ
////                                else {
////                                    print("\(String(describing: user.data()["name"]))は同性")
////
////                                }
////                                self.secondFilter()
////                            }
//////                            print("allUsers2: \(self.allUsers)")
////                        }
//////                        print("allUsers3: \(self.allUsers)")
////                    }
//////                    print("allUsers4: \(self.allUsers)")
////                }
////                print("allUsers5: \(self.allUsers)")
//            }
//
//
//
//        } //matchtable loop
//    }
//
//        func secondFilter(){
//            print("セカンドフィルター: \(self.allUsers)")
//            print("セカンドマッチ: \(self.MatchUsers)")
////            for user in self.MatchUsers{
////                let index = self.allUsers.firstIndex(of: user)
////                let index1 = self.MatchUsers.firstIndex(of: user)
////                print(index as Any)
////                if let index = index {
////                    self.allUsers.remove(at: index)
////                } else {
////                    print("ナンジャこりゃ")
////                }
////
////                self.MatchUsers.remove(at: index1 ?? 0)
////            }
//        }
//



//                                    self.shareData.allUsers = self.shareData.allUsers.filter { v in return !self.shareData.MatchUsers.contains(v) }
//                                    print("オール: \(self.shareData.allUsers)")
//                                    print("マッチ: \(self.shareData.MatchUsers)")


// func filterUsers(){
//        ///        マッチを先に送った方の表示Ok, 後から送った方の表示Ok、でもマッチ二人以上だとsucks
//        db.collection("MatchTable").document(self.currentUserData["id"] as? String ?? "").collection("MatchUser").getDocuments { (snap, err) in
//
//            case 0:
//                print("マッチなし")
//                self.getAllUsers()
//
//            case 1:
//                print("マッチあり") //マッチあるとき
//                print("マッチ数: \(snap!.count)")
//
//                                    else {
//                                        print("\(String(describing: user.data()["name"]))はマッチずみ")
//                                        print("\(String(describing: user.data()["id"] as? String))はマッチずみ")
//
//
//                                    }
//                                }
//                                else {
//                                    print("\(String(describing: user.data()["name"]))は同性")
//
//
//                                }
//
//                            }
//                        }
//
//
//
//                    }
//
//                }
//
//            default:
//
//                print("マッチあり") //マッチが二つ以上あるとき
//@@ -153,64 +153,42 @@ class ShareData:ObservableObject{
//                        }
//                        if let snap = querySnapshot {
//                            for user in snap.documents {
//                                //                                print("マチのID: \(id.data()["MatchUserId"] as! String)")
//                                //                                print("全員のID: \(user.data()["id"] as! String)")
//
//
//                                if user.data()["gender"] as? String != self.currentUserData["gender"] as? String
//                                {
//                                    if user.data()["id"] as? String != id.data()["MatchUserId"] as? String
//
//                                    {
//                                        self.allUsers.append(User(
//                                            id: user.data()["id"] as! String,
//                                            email: user.data()["email"] as! String,
//                                            name: user.data()["name"] as! String,
//                                            gender: user.data()["gender"] as! String,
//                                            age: user.data()["age"] as! String,
//                                            hometown: user.data()["hometown"] as! String,
//                                            subject: user.data()["subject"] as! String,
//                                            introduction: user.data()["introduction"] as! String,
//                                            studystyle: user.data()["studystyle"] as! String,
//                                            hobby: user.data()["hobby"] as! String,
//                                            personality: user.data()["personality"] as! String,
//                                            work: user.data()["work"] as! String,
//                                            purpose: user.data()["purpose"] as! String,
//                                            photoURL: user.data()["photoURL"] as! String
//                                        ))
//
//                                    }
//                                    else {
//                                        print("\(String(describing: user.data()["name"]))はマッチずみ")
//                                        print("\(String(describing: user.data()["id"] as? String))はマッチずみ")
//                                        //                                        print("\(String(describing: id.data()["MatchUserId"] as? String))はマッチずみ")
//
//                                        self.matchUserData = User(id: user.data()["id"] as! String, email: (user.data()["email"] as! String), name: user.data()["name"] as! String, gender: user.data()["gender"] as! String, age: user.data()["age"] as! String, hometown: user.data()["hometown"] as! String, subject: user.data()["subject"] as! String, introduction: user.data()["introduction"] as! String, studystyle: user.data()["studystyle"] as! String, hobby: user.data()["hobby"] as! String, personality: user.data()["personality"] as! String, work: user.data()["work"] as! String, purpose: user.data()["purpose"] as! String, photoURL: user.data()["photoURL"] as! String)
//                                        self.MatchUsers.append(self.matchUserData)
////                                        self.index = self.allUsers.firstIndex(of: self.matchUserData)!
//                                        //                                        let matchUserIndex = self.MatchUsers.firstIndex(of: matchUserData)
//
//
//                                        //                                        self.allUsers.remove(at: matchUserIndex!)
//
//                                    print("\(String(describing: user.data()["name"] as? String))はユーザーです。")
//                                    if user.data()["id"] as? String == id.data()["MatchUserId"] as? String {
//                                        print("\(String(describing: user.data()["name"] as? String))はIDが\(String(describing: id.data()["MatchUserId"] as? String))でマッチしています。")
//                                        return
//                                    }
//                                }
//
//                                    self.allUsers.append(User(
//                                        id: user.data()["id"] as! String,
//                                        email: user.data()["email"] as! String,
//                                        name: user.data()["name"] as! String,
//                                        gender: user.data()["gender"] as! String,
//                                        age: user.data()["age"] as! String,
//                                        hometown: user.data()["hometown"] as! String,
//                                        subject: user.data()["subject"] as! String,
//                                        introduction: user.data()["introduction"] as! String,
//                                        studystyle: user.data()["studystyle"] as! String,
//                                        hobby: user.data()["hobby"] as! String,
//                                        personality: user.data()["personality"] as! String,
//                                        work: user.data()["work"] as! String,
//                                        purpose: user.data()["purpose"] as! String,
//                                        photoURL: user.data()["photoURL"] as! String
//                                    ))
//
//
//                                } //閉じ
//                                else {
//                                    print("\(String(describing: user.data()["name"]))は同性")
//                                    //                                    print(self.allUsers) //男性全員
//
//                                }
//
//                            }
//                        }
////                        let index = self.allUsers.firstIndex(of: self.matchUserData)
////                        self.allUsers.remove(at: self.index)
//
////                        for user in self.MatchUsers {
////                            let index = self.allUsers.firstIndex(of: user)
////                            self.allUsers.remove(at: index!)
////                        }
////                        print("インデックス: \(self.index)")
////                        print("オールユーザーズ配列: \(self.allUsers)")
////                        print("マッチユーザーず配列: \(self.MatchUsers)")
//                        self.secondFilter()
//
//                    }
//
//@@ -222,15 +200,17 @@ class ShareData:ObservableObject{
//        } //matchtable loop
//    }
//
//    func secondFilter(){
//        print("セカンド: \(self.allUsers)")
//        print("セカンドマッチ: \(self.MatchUsers)")
//        for user in self.MatchUsers{
//            let index = self.allUsers.firstIndex(of: user)
////            print(index)
//            self.allUsers.remove(at: index ?? 1)
//        }
//    }
    //    func secondFilter(){
    //        print("セカンド: \(self.allUsers)")
    //        print("セカンドマッチ: \(self.MatchUsers)")
    //        for user in self.MatchUsers{
    //            let index = self.allUsers.firstIndex(of: user)
    //            let index1 = self.MatchUsers.firstIndex(of: user)
    //            print(index)
    //            self.allUsers.remove(at: index ?? 0)
    //            self.MatchUsers.remove(at: index1 ?? 0)
    //        }
    //    }



//    func filterUsers(){
//        self.db.collection("MatchTable")
//            .document(self.currentUserData["id"] as! String)
//            .collection("MatchUser")
//            .getDocuments { (snap, err) in
//                if let snap = snap {
//                    
//                    for id in snap.documents{
//                        switch snap.count{
//                        case 0:
//                            print("マッチなし")
//                            print("マッチ数: \(snap.count)")
//                            self.getAllUsers()
//                            
//                        case 1:
//                            print("マッチあり") //マッチあるとき
//                            print("マッチ数: \(snap.count)")
//                            for id in snap.documents{
//                                
//                                self.allUsers = [User]() //初期値で空配列を入れているが（scrollview用）まずはそれを掃除
//                                
//                                self.db.collection("Users").getDocuments { (snap, err) in
//                                    if let err = err {
//                                        print("Error getting documents: \(err)")
//                                        return
//                                    }
//                                    if let snap = snap {
//                                        for user in snap.documents {
//                                            
//                                            if user.data()["gender"] as? String != self.currentUserData["gender"] as? String
//                                            {
//                                                if user.data()["id"] as? String != id.data()["MatchUserId"] as? String
//                                                    
//                                                {
//                                                    self.allUsers.append(User(
//                                                        id: user.data()["id"] as! String,
//                                                        email: user.data()["email"] as! String,
//                                                        name: user.data()["name"] as! String,
//                                                        gender: user.data()["gender"] as! String,
//                                                        age: user.data()["age"] as! String,
//                                                        hometown: user.data()["hometown"] as! String,
//                                                        subject: user.data()["subject"] as! String,
//                                                        introduction: user.data()["introduction"] as! String,
//                                                        studystyle: user.data()["studystyle"] as! String,
//                                                        hobby: user.data()["hobby"] as! String,
//                                                        personality: user.data()["personality"] as! String,
//                                                        work: user.data()["work"] as! String,
//                                                        purpose: user.data()["purpose"] as! String,
//                                                        photoURL: user.data()["photoURL"] as! String
//                                                    ))
//                                                    
//                                                } else {
//                                                    print("\(String(describing: user.data()["name"]))はマッチずみ")
//                                                    print("\(String(describing: user.data()["id"] as? String))はマッチずみ")
//                                                    
//                                                }
//                                            } else {
//                                                print("\(String(describing: user.data()["name"]))は同性")
//                                                
//                                            }
//                                            
//                                        }
//                                    }
//                                    
//                                    
//                                }
//                                
//                            }
//                            
//                        default:
//                            print("マッチあり")
//                            print("マッチ数: \(snap.count)")
//                            print(id.data()["MatchUserId"] as! String)
//                            self.matchUserId.append(id.data()["MatchUserId"] as! String)
//                            print(self.matchUserId)
//                            self.allUsers = [User]() //初期値で空配列を入れているが（scrollview用）まずはそれを掃除
//                            self.db.collection("Users").getDocuments { (querySnapshot, err) in
//                                if let err = err {
//                                    print("Error getting documents: \(err)")
//                                    return
//                                }
//                                
//                                if let snap = querySnapshot {
//                                    for user in snap.documents{
//                                        for matchId in self.matchUserId {
//                                            
//                                            if user.data()["id"] as? String == matchId {
//                                                self.MatchUsers.append(User(
//                                                    id: user.data()["id"] as! String,
//                                                    email: user.data()["email"] as! String,
//                                                    name: user.data()["name"] as! String,
//                                                    gender: user.data()["gender"] as! String,
//                                                    age: user.data()["age"] as! String,
//                                                    hometown: user.data()["hometown"] as! String,
//                                                    subject: user.data()["subject"] as! String,
//                                                    introduction: user.data()["introduction"] as! String,
//                                                    studystyle: user.data()["studystyle"] as! String,
//                                                    hobby: user.data()["hobby"] as! String,
//                                                    personality: user.data()["personality"] as! String,
//                                                    work: user.data()["work"] as! String,
//                                                    purpose: user.data()["purpose"] as! String,
//                                                    photoURL: user.data()["photoURL"] as! String
//                                                ))
//                                            }
//                                            
//                                        }
//                                        
//                                        
//                                        if user.data()["gender"] as? String != self.currentUserData["gender"] as? String
//                                            //                                                && user.data()["id"] as? String != matchId
//                                            //                                            (id.data()["MatchUserId"] as! String)
//                                            //                                            "SzhAsVFVirchWm63jSsV"
//                                        {
//                                            self.allUsers.append(User(
//                                                id: user.data()["id"] as! String,
//                                                email: user.data()["email"] as! String,
//                                                name: user.data()["name"] as! String,
//                                                gender: user.data()["gender"] as! String,
//                                                age: user.data()["age"] as! String,
//                                                hometown: user.data()["hometown"] as! String,
//                                                subject: user.data()["subject"] as! String,
//                                                introduction: user.data()["introduction"] as! String,
//                                                studystyle: user.data()["studystyle"] as! String,
//                                                hobby: user.data()["hobby"] as! String,
//                                                personality: user.data()["personality"] as! String,
//                                                work: user.data()["work"] as! String,
//                                                purpose: user.data()["purpose"] as! String,
//                                                photoURL: user.data()["photoURL"] as! String
//                                            ))
//                                            //                        }
//                                            //                                            }
//                                        }
//                                        
//                                        //matchtableLoopここまで
//                                        
//                                        //                    print("オールユーザー: \(self.allUsers)")
//                                        //                    self.allUsers = self.allUsers.filter { v in return !self.MatchUsers.contains(v) }
//                                        //                    print()
//                                        self.secondFilter()
//                                        //                                            }
//                                        //
//                                        //                                        }
//                                        
//                                    }
//                                }
//                                //            self.allUsers.remove(at: 0)
//                                
//                            }
//                            
//                            
//                            
//                            
//                            
//                        }
//                        
//                    }
//                }
//        } //getD
//    }
//    
//    func secondFilter(){
//        print("セカンドフィルター: \(self.allUsers)")
//        print("セカンドフィルターマッチ: \(self.MatchUsers)")
////        for user in self.MatchUsers{
////            let index = self.allUsers.firstIndex(of: user)
////            //            print(index)
////            self.allUsers.remove(at: index ?? 1)
////        }
//    }

//
//var ref: DocumentReference? = nil
//ref = db.collection("cities").addDocument(data: [
//    "name": "Tokyo",
//    "country": "Japan"
//]) { err in
//    if let err = err {
//        print("Error adding document: \(err)")
//    } else {
//        print("Document added with ID: \(ref!.documentID)")
//    }
//}


//    func test (){
//        var ref: DocumentReference? = nil
//        ref = self.db.collection("MatchRoom").addDocument(data: [
//            "name": "Tokyo",
//            "country": "Japan"
//        ]) { err in
//            if let err = err {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document added with ID: \(ref!.documentID)")
//            }
//        }
//    }


//import SwiftUI
//import FirebaseFirestore
//
//struct MatchView: View {
//    @EnvironmentObject var shareData: ShareData
//
//    var body: some View {
//        VStack{
//            ForEach(self.shareData.matchUserArray){ user in
//                Text(user.name)
//            }
//        }
//
//        .onAppear{
//            self.shareData.getAllMatchUser()
////            print(self.shareData.matchUserArray)
//        }
//    } //body
//
//} //struct
//
//struct MatchView_Previews: PreviewProvider {
//    static var previews: some View {
//        MatchView()
//    }
//}
//

//import SwiftUI
//import FirebaseFirestore
//
//struct ContentView: View {
//
//    @State var data1 = [Profile]()
//
//    var body: some View {
//
//        return VStack {
//            HStack {
//                Text("Penya").font(.largeTitle)
//            }
//            Divider()
//            List(data1) { i in
//                cellView(name: i.name, phoneNumber: i.phoneNumber)
//            }
//        }.onAppear {
//            self.getData()
//        }
//    }
//
//
//    func getData() {
//
//        var data = [Profile]()
//
//        let db = Firestore.firestore()
//        db.collection("patients").addSnapshotListener { (snap, err) in
//
//            if err != nil {
//                print((err?.localizedDescription)!)
//                return
//            }
//
//            for doc in (snap?.documentChanges)! {
//                let name = doc.document.data()["name"] as! String
//                let phoneNumber = doc.document.data()["phoneNumber"] as! String
//
//                print (name)
//                print (phoneNumber)
//
//                DispatchQueue.main.async {
//                    data.append(Profile(id: 0,
//                                        name: name,
//                                        phoneNumber: phoneNumber))
//                    self.data1 = data
//                }
//            }
//        }
//    }
//
//}



//    func messageManager() {
//        print("ゲットデータ: \(self.shareData.matchId)")
//        let db = Firestore.firestore()
//        db.collection("Messages").whereField("matchId", isEqualTo: self.shareData.matchId).order(by: "date").addSnapshotListener { (snap, err) in
//
//            if err != nil {
//                print((err?.localizedDescription)!)
//                return
//            }
//
//            if let snap = snap {
//                for i in snap.documentChanges {
//
//                    if i.type == .added{
//                        let toUser = i.document.get("toUser") as! String
//                        let fromUser = i.document.get("fromUser") as! String
//                        let message = i.document.get("message") as! String
//                        let id = i.document.documentID
//                        let date = i.document.get("date") as! Timestamp
//                        let matchId = i.document.get("matchId") as! String
//
////                        DispatchQueue.main.async {
//
//                            self.messages.append(Message(id: id, msg: message, fromUser: fromUser, toUser: toUser, date: date, matchId: matchId))
//
//
////                        }
//                    }
//                }
//            }
//            //            }
//        }
//    }
    
    
    
    
    


//struct Message: Identifiable {
//    var id: String
//    var msg: String
//    var fromUser: String
//    var toUser: String
//    var date: Timestamp
//    var matchId : String
//}
//

//    var msgVM: MessageViewModel {
////        (matchId: "Ll73RINefGxEcYQJoWSE"
//        let currentUserId = self.shareData.currentUserData["id"] as? String ?? ""
//        let matchUserId = matchUserInfo.id
//        Firestore.firestore().collection("MatchTable").document(currentUserId).collection("MatchUser").whereField("MatchUserId", isEqualTo: matchUserId).getDocuments { (snap, err) in
//            if let snap = snap {
//                for id in snap.documents{
//                    self.matchId = id.data()["MatchRoomId"] as? String ?? "nilだよ"
//                }
//
//            }
//
//        }
//        print("computed property: \(self.matchId)")
//        return MessageViewModel(matchId: matchId)
//    }
//    @State var msgVM = MessageViewModel(matchId: "")


///コメントアウト削除
//                            .onTapGesture {
////                                self.userInfo =user
//                                Firestore.firestore().collection("MatchTable").document(self.shareData.currentUserData["id"] as! String).collection("MatchUser").whereField("MatchUserId", isEqualTo: user.id).getDocuments { (snap, err) in
//                                    if snap != nil {
//                                        for i in snap!.documents{
//                                            self.matchid = i.data()["MatchRoomId"] as! String
//                                        }sayaka@aaa.com//                                    }
//                                }
//                                print(self.matchid)
//                            }



        // Reference link : https://firebase.google.com/docs/firestore/query-data/listen
//        func readData() {
//            dbCollection.addSnapshotListener { (documentSnapshot, err) in
//                if err != nil {
//                    print((err?.localizedDescription)!)
//                    return
//                }else {
//                    print("read data success")
//                }
//
//                documentSnapshot!.documentChanges.forEach { diff in
//                    if (diff.type == .added) {
//    //                    データ新規追加だったら、ThreadDataType型のデータを生成(idはdbから、msgはtestTextという名前のデータを取得)し、それをdata配列に追加　→                        表示更新
//                        let userData = User(id: diff.document.documentID,
//                                            name: diff.document.get("name") as! String,
//                                            age: diff.document.get("age") as! Int,
//                                            hometown: diff.document.get("hometown") as! String,
//                                            subject: diff.document.get("subject") as! String,
//                                            introduction: diff.document.get("introduction") as! String,
//                                            studystyle: diff.document.get("studystyle") as! String,
//                                            hobby: diff.document.get("hobby") as! String,
//                                            personality: diff.document.get("personality") as! String,
//                                            work: diff.document.get("work") as! String,
//                                            purpose: diff.document.get("purpose") as! String)
//                        self.data.append(userData)
//                    }
//    //                既存データ更新だったら、それぞれのデータをThredDataTypeでリターン
//    //                表示されているデータのidとdb上のデータのidが一緒なら
//    //                表示されているデータのmsgを同じidを持ったデータのtestTextに書き換え
//    //                同じidじゃないやつはそのまま返す
//
//                    if (diff.type == .modified) {
//                        self.data = self.data.map { (eachData) -> User in
//                            var data = eachData
//                            if data.id == diff.document.documentID {
//                                data.name = diff.document.get("name") as! String
//                                return data
//                            }else {
//                                return eachData
//                            }
//                        }
//                    }
//                }
//            }
//        }

//        //Reference link: https://firebase.google.com/docs/firestore/manage-data/delete-data
//        func deleteData(datas: FirebaseData ,index: IndexSet) {
//    //        dbから削除
//            let id = datas.data[index.first!].id
//            dbCollection.document(id).delete { (err) in
//
//                if err != nil {
//                    print((err?.localizedDescription)!)
//                    return
//                }else {
//                    print("delete data success")
//                }
//    //            表示されてる
//    //            datas.data.remove(atOffsets:index)
//                self.data.remove(atOffsets:index)
//            }
//        }
//
//        // Reference link: https://firebase.google.com/docs/firestore/manage-data/add-data
//        func updateData(id: String, txt: String) {
//            dbCollection.document(id).updateData(["testText":txt]) { (err) in
//                if err != nil {
//                    print((err?.localizedDescription)!)
//                    return
//                }else {
//                    print("update data success")
//                }
//            }
//        }


//ScrollView(.horizontal, showsIndicators: true){
//    HStack(spacing: 0) {
//        ForEach(0 ..< self.shareData.pictures.count) { index in
//            cardView(img: self.shareData.pictures[index], msg: self.messages[index], width: geometry.size.width, height: geometry.size.height).environmentObject(self.shareData)
//                .offset(x: self.x)
//                .highPriorityGesture(DragGesture()
//                    .onChanged({ (value) in
//                        
//                        if value.translation.width > 0 {
//                            self.x = value.location.x
//                        } else {
//                            self.x = value.location.x - self.screen
//                        }
//                        
//                    })
//                    .onEnded({ (value) in
//                        if value.translation.width > 0{
//                            if value.translation.width > ((self.screen - 80)/2) && Int(self.count) != self.getMid(){
//                                self.count += 1
//                                self.x = (self.screen) * self.count
//                            } else {
//                                self.x = (self.screen) * self.count
//                            }
//                        }else{
//                            if -value.translation.width > ((self.screen - 80)/2) && -Int(self.count) != self.getMid(){
//                                self.count -= 1
//                                self.x = (self.screen) * self.count
//                            } else {
//                                self.x = (self.screen) * self.count
//                            }
//                        }
//                        
//                    })
//            )
//            
//            //
//        }
//    }
//}


///横スライドメニュー
//
// 最初に画面のオフセットの値をスライドメニュー分マイナスします。
//    .onAppear(perform: {
//        self.xOffset = geometry.size.width * -0.7
//        self.defaultOffset = self.xOffset
//    })
//    .offset(x: self.xOffset)
//    // 画面サイズを明示します
//    .frame(width: geometry.size.width, alignment: .leading)
//    // スライドのアニメーションを設定します
//
//    // ジェスチャーに関するイベントを検知します
//    .gesture(
//        // ドラッグ、すなわちスライドやスワイプに関するイベントに関して検知します
//        DragGesture()
//            // スワイプが検知されたときの動きを実装します
//            .onChanged{ value in
//                // スワイプの移動距離が5以上のときにオフセットの値を動的に変化させます
//                // しきい値(ここでは5)を超えるとリアルタイムな動きを与えます
//                if (self.xOffset != .zero && value.translation.width > 5) {
//                    self.xOffset = self.defaultOffset + value.translation.width
//                }
//        }
//            // スワイプが終了したときの動きを実装します
//            .onEnded { value in
//                // もし、右方向にスワイプした距離が5以上ならオフセットを0にします
//                // すなわち、メニューを表示します
//                // それ以外はオフセットをスライドメニュー分設定します
//                // すなわちスライドメニューを隠します
//                if (value.translation.width > 5) {
//                    self.xOffset = .zero
//                } else {
//                    self.xOffset = self.defaultOffset
//                }
//        }
//)
