//
//  ShareData.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/17.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth
import SwiftUI

class ShareData:ObservableObject{
    
    let db = Firestore.firestore()
    let datas = firebaseData
    let pictures = ["coffeeheart" ,"manwoman" ,"holdpen" ,"couple"]
    
    
    @Published var currentUserData = [String : Any]()
    
    @Published var switchFavAndLike = false
    
    @Published var myProfile = false
    @Published var messageView = false
    
    //ScrollViewには最初に配列に初期値を設定する必要あり
    
    @Published var allUsers = [User]()
    @Published var filteredAllUsers = [User]()
    
    @Published var displayedUser = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "", fee: "", schedule: "", place: "")
    
    @Published var favoriteUsers =  [User]()
    @Published var filteredFavoriteUsers =  [User]()
    @Published var likeUsers = [User]()
    @Published var filteredLikeUsers =  [User]()
    @Published var searchedUsers = [User]()
    @Published var filteredSearchedUsers = [User]()
    
    @Published var likeMeUsers = [User]()
    @Published var filteredLikeMeUsers =  [User]()
    @Published var MatchUsers: [User] = [User]()
    
    @Published var imageURL = ""
    
    var matchUserData: User = User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "", fee: "", schedule: "", place: "")
    //    var index = 0
    var matchUserId = [String]()
    
    var ages:[String]
    init(){
        var array = [String]()
        for i in 18 ... 50{
            array.append("\(i)歳")
        }
        self.ages = array
    }
    let places = ["カフェ", "オンライン", "その他"]
    let studystyles = ["共通の科目を教え合いながら勉強したい", "共通の科目をもくもくと勉強したい", "お相手の科目には特にこだわらず勉強したい", "勉強はせずにお話をしてみたい" ,"その他"]
    
    let hometowns = ["北海道","青森県","岩手県","宮城県","秋田県","山形県","福島県",
                     "茨城県","栃木県","群馬県","埼玉県","千葉県","東京都","神奈川県",
                     "新潟県","富山県","石川県","福井県","山梨県","長野県","岐阜県",
                     "静岡県","愛知県","三重県","滋賀県","京都府","大阪府","兵庫県",
                     "奈良県","和歌山県","鳥取県","島根県","岡山県","広島県","山口県",
                     "徳島県","香川県","愛媛県","高知県","福岡県","佐賀県","長崎県",
                     "熊本県","大分県","宮崎県","鹿児島県","沖縄県"]
    let jobs = ["営業", "経営者","事務", "自営業","美容師","教師", "受付","エンジニア","フリーランス","医者", "看護師","公務員","飲食店勤務", "介護士","サービス業", "フリーター", "パート","学生", "その他"]
    let personalities = ["明るい", "社交的", "優しい", "物静か", "好奇心旺盛", "真面目" ,"謙虚", "前向き" ,"マイペース", "計画的", "世話好き", "責任感が強い"]
    let purposes  = ["勉強", "勉強も恋もしたい", "恋活", "婚活"]
    
    let schedules = ["日中", "夕方", "夜"]
    let fee = ["割り勘", "相手が多めに払う", "自分が多めに払う", "相手が全額払う", "自分が全額払う"]
    
    @Published var editOn = false
    
    @Published var matchUserArray = [User]()
    @Published var filteredMatchUserArray = [User]()
    
    @Published var naviLinkOff = false
    
    
    func loadImageFromFirebase(path: String){
        //        FILE_NAMEがあれば画面表示の際にurlが取得されFirebaseImageViewで画像が表示されている
        let storage = Storage.storage().reference(withPath: path)
        storage.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                print("Error: loadImageFromFirebase")
                return
            }
            //            print("Download success")
            self.imageURL = "\(url!)"
        }
    }
    
    func getCurrentUser() {
        db.collection("Users").whereField("email", isEqualTo: datas.session!.email!).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.currentUserData = document.data()
                    //                    self.countNum()
                    self.getAllUsers()
                    
//                    print(self.allUsers)
//                    print(self.filteredAllUsers)
                }
            }
        }
        
        //        self.getAllUsers()
    }
    
    
    func filtering(){
        for user in self.allUsers{
            for match in self.MatchUsers{
                if user == match {
                    self.allUsers = self.allUsers.filter{ !self.MatchUsers.contains($0)}
                    self.filteredAllUsers = self.allUsers
                }
            }
        }
    }

    
    func getAllUsers(){
        self.allUsers = [User]() //初期値で空配列を入れているが（scrollview用）まずはそれを掃除_
        
        self.db.collection("Users").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                return
            }
            if let snap = querySnapshot {
                for user in snap.documents {
                    
                    if user.data()["gender"] as? String != self.currentUserData["gender"] as? String {
                        self.allUsers.append(User(
                            id: user.data()["id"] as! String,
                            email: user.data()["email"] as! String,
                            name: user.data()["name"] as! String,
                            gender: user.data()["gender"] as! String,
                            age: user.data()["age"] as! String,
                            hometown: user.data()["hometown"] as! String,
                            subject: user.data()["subject"] as! String,
                            introduction: user.data()["introduction"] as! String,
                            studystyle: user.data()["studystyle"] as! String,
                            hobby: user.data()["hobby"] as! String,
                            personality: user.data()["personality"] as! String,
                            work: user.data()["work"] as! String,
                            purpose: user.data()["purpose"] as! String,
                            photoURL: user.data()["photoURL"] as! String,
                            matchRoomId: "",
                            fee: user.data()["fee"] as! String,
                            schedule: user.data()["schedule"] as! String,
                            place: user.data()["place"] as! String
                            
                        ))
                        //                        self.filteredAllUsers = self.allUsers
                    }
                }
            }
           
        
            self.db.collection("MatchTable")
                       .document(self.currentUserData["id"] as! String)
                       .collection("MatchUser").getDocuments { (snap, err) in
                           if err != nil{
                               print(err?.localizedDescription ?? "error")
                               return
                           }
                           
                           if let snap = snap {
                            if snap.isEmpty {//マッチゼロでMatchTableとかfilterを介さず代入
                                   self.filteredAllUsers = self.allUsers
                                   return
                               }
                               for id in snap.documents {
                                   
                                   self.db.collection("Users").whereField("id", isEqualTo: id.data()["MatchUserId"] as! String).getDocuments { (snap, err) in
                                       if let snap = snap {
                                           
                                           for user in snap.documents {
                                               self.MatchUsers.append(User(
                                                   id: user.data()["id"] as! String,
                                                   email: user.data()["email"] as! String,
                                                   name: user.data()["name"] as! String,
                                                   gender: user.data()["gender"] as! String,
                                                   age: user.data()["age"] as! String,
                                                   hometown: user.data()["hometown"] as! String,
                                                   subject: user.data()["subject"] as! String,
                                                   introduction: user.data()["introduction"] as! String,
                                                   studystyle: user.data()["studystyle"] as! String,
                                                   hobby: user.data()["hobby"] as! String,
                                                   personality: user.data()["personality"] as! String,
                                                   work: user.data()["work"] as! String,
                                                   purpose: user.data()["purpose"] as! String,
                                                   photoURL: user.data()["photoURL"] as! String, matchRoomId: "",
                                                   fee: user.data()["fee"] as! String,
                                                   schedule: user.data()["schedule"] as! String,
                                                   place: user.data()["place"] as! String
                                               ))
                                               
                                               self.filtering()
                                               
                                           }
                                           //                                self.filtering()
                                       }
                                       //                            self.filtering()
                                   }
                                   //                        self.filtering()
                               }
                               //                    self.filtering()
                           }
                           //                self.filtering()
                   }
                   //        self.filtering()
               } //getAllUsers()
             } //allUsers
        
        
        
        
       
    
    func getAllFavoriteUsers(){
        self.favoriteUsers = [User]()
        db.collection("FavoriteTable")
            .document(self.currentUserData["id"] as? String ?? "")
            .collection("FavoriteUser")
            .getDocuments { (snap, err) in
                if let err = err{
                    print(err.localizedDescription)
                    return
                }
                
                if let snap = snap {
                    
                    if snap.count == 0
                    {//お気に入りが誰もいなかったら空配列入れる：表示のため
                        self.filteredFavoriteUsers = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "", fee: "", schedule: "", place: "")]
                        return
                    }
                    for user1 in snap.documents {
                        //                    print(user.data()["FavoriteUserId"] as? String ?? "")
                        self.db.collection("Users")
                            .whereField("id", isEqualTo: user1.data()["FavoriteUserId"] as? String ?? "")
                            .getDocuments { (snap, err) in
                                if let snap = snap {
                                    for user in snap.documents {
                                        
                                        self.favoriteUsers.append(User(id: user.data()["id"] as! String, email: user.data()["email"] as! String, name: user.data()["name"] as! String, gender: user.data()["gender"] as! String, age: user.data()["age"] as! String, hometown: user.data()["hometown"] as! String, subject: user.data()["subject"] as! String, introduction: user.data()["introduction"] as! String, studystyle: user.data()["studystyle"] as! String, hobby: user.data()["hobby"] as! String, personality: user.data()["personality"] as! String, work: user.data()["work"] as! String, purpose: user.data()["purpose"] as! String, photoURL: user.data()["photoURL"] as? String ?? "", matchRoomId: "none", fee: user.data()["fee"] as! String, schedule: user.data()["schedule"] as! String, place: user.data()["place"] as! String))
                                        
                                    }
                                    self.filteredFavoriteUsers = self.favoriteUsers
                                } //snap = snap
                                
                        } // getDocuments
                    }
                }
                //                self.favoriteUsers.remove(at: 0) //最初のから配列を消してる？
        }
    }
    
    func getAllLikeUsers(){
        self.likeUsers = [User]()
        db.collection("LikeTable")
            .whereField("MyUserId", isEqualTo: self.currentUserData["id"] as? String ?? "")
            .getDocuments { (snap, err) in
                if let err = err{
                    print(err.localizedDescription)
                    return
                }
                
                if let snap = snap {
                    if snap.count == 0
                    {//いいねしたのが誰もいなかったら空配列入れる：表示のため
                        self.filteredLikeUsers = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "", fee: "", schedule:"", place:"")]
                        return
                    }
                    for user1 in snap.documents {
                        self.db.collection("Users")
                            .whereField("id", isEqualTo: user1.data()["LikeUserId"] as? String ?? "")
                            .getDocuments { (snap, err) in
                                if let snap = snap {
                                    for user in snap.documents {
                                        
                                        self.likeUsers.append(User(id: user.data()["id"] as! String, email: user.data()["email"] as! String, name: user.data()["name"] as! String, gender: user.data()["gender"] as! String, age: user.data()["age"] as! String, hometown: user.data()["hometown"] as! String, subject: user.data()["subject"] as! String, introduction: user.data()["introduction"] as! String, studystyle: user.data()["studystyle"] as! String, hobby: user.data()["hobby"] as! String, personality: user.data()["personality"] as! String, work: user.data()["work"] as! String, purpose: user.data()["purpose"] as! String, photoURL: user.data()["photoURL"] as? String ?? "", matchRoomId: "N/A", fee: user.data()["fee"] as! String, schedule: user.data()["schedule"] as! String, place: user.data()["place"] as! String))
                                        
                                    }
                                } else {
                                    print(err?.localizedDescription ?? "")
                                    return
                                }
                                self.filteredLikeUsers = self.likeUsers
                        }
                    }
                } else { return }
        }
    }
    
    func getAllLikeMeUser(){
        self.likeMeUsers = [User]()
        db.collection("LikeTable").whereField("LikeUserId", isEqualTo: self.currentUserData["id"] as? String ?? "").getDocuments { (snap, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            if let snap = snap {
                if snap.count == 0 {//いいねしてくれたのが誰もいなかったら空配列入れる
                    self.filteredLikeMeUsers = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "", fee: "", schedule:"", place:"")]
                    return
                }
                
                for id in snap.documents{
                    let likeMeId = id.data()["MyUserId"] as! String
                    self.db.collection("Users").whereField("id", isEqualTo: likeMeId).getDocuments { (snap, err) in
                        if let err = err {
                            print(err.localizedDescription)
                            return
                        }
                        if let snap = snap {
                            for user in snap.documents{
                                self.likeMeUsers.append(User(id: user.data()["id"] as! String, email: user.data()["email"] as! String, name: user.data()["name"] as! String, gender: user.data()["gender"] as! String, age: user.data()["age"] as! String, hometown: user.data()["hometown"] as! String, subject: user.data()["subject"] as! String, introduction: user.data()["introduction"] as! String, studystyle: user.data()["studystyle"] as! String, hobby: user.data()["hobby"] as! String, personality: user.data()["personality"] as! String, work: user.data()["work"] as! String, purpose: user.data()["purpose"] as! String, photoURL: user.data()["photoURL"] as? String ?? "", matchRoomId: "N/A", fee: user.data()["fee"] as! String, schedule: user.data()["schedule"] as! String, place: user.data()["place"] as! String))
                            }
                            self.filteredLikeMeUsers = self.likeMeUsers
                        }
                    }
                    
                }
            }
            
        }
    }
    
    
    func getAllMatchUser(){
        db.collection("MatchUsers")
            .document(self.currentUserData["id"] as? String ?? "")
            .collection("MatchUserData")
            .getDocuments { (snap, err) in
                if let err = err{
                    print(err.localizedDescription)
                    return
                }
                if let snap = snap{
                    if snap.count == 0 {
                        self.matchUserArray = [User(id: "", email: "", name: "", gender: "", age: "", hometown: "", subject: "", introduction: "", studystyle: "", hobby: "", personality: "", work: "", purpose: "", photoURL: "", matchRoomId: "", fee: "", schedule:"", place:"")]
                        self.naviLinkOff = true
                        return
                    }
                    self.naviLinkOff = false
                    for user in snap.documents{
                        
                        self.matchUserArray.append(User(id: user.data()["id"] as! String, email: user.data()["email"] as! String, name: user.data()["name"] as! String, gender: user.data()["gender"] as! String, age: user.data()["age"] as! String, hometown: user.data()["hometown"] as! String, subject: user.data()["subject"] as! String, introduction: user.data()["introduction"] as! String, studystyle: user.data()["studystyle"] as! String, hobby: user.data()["hobby"] as! String, personality: user.data()["personality"] as! String, work: user.data()["work"] as! String, purpose: user.data()["purpose"] as! String, photoURL: user.data()["photoURL"] as! String, matchRoomId: user.data()["MatchRoomId"] as! String, fee: user.data()["fee"] as! String, schedule: user.data()["schedule"] as! String, place: user.data()["place"] as! String))
                        
                        
                    }
                    
                    self.filteredMatchUserArray = self.matchUserArray
                }
                
        }
    }
    
    //  Auth
    func deleteAccount(){
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if let error = error {
                // An error happened.
                print("退会エラー")
                print(error)
                return
            } else {
                // Account deleted.
                print("Auth削除！")
                self.deleteUserData()
                self.deleteUserPicture()
                
            }
        }
    }
    
    
    //    func countNum(){
    
    
    
    //    }
    
    // Firestore
// 
    
    func deleteUserData(){
        ///Tableごとにすべて削除
        
        //likeの数
        db.collection("LikeTable").whereField("MyUserId", isEqualTo: self.currentUserData["id"] as! String).getDocuments { (snap, err) in
            if let snap = snap {
                //                        print(self.currentUserData["id"] as? String ?? "nil")
                if snap.count == 0 {
                    //                                    print("いいねを送った数: \(snap.count)")
                    print("LikeTable削除なし")
                    return
                }
                
                //                                print("いいねを送った数: \(snap.count)")
                for like in snap.documents{
                    like.reference.delete()
                    print("LikeTable削除！")
                }
            }
        }
        
        
        db.collection("FavoriteTable").document(self.currentUserData["id"] as! String).collection("FavoriteUser").getDocuments { (snap, err) in
            if let snap = snap {
                if snap.count == 0 {
                    print("FavoriteTable削除なし")
                    return
                }
                //                print("お気に入りに追加した数: \(snap.count)")
//                print("お気に入りの数: \(snap.count)")
                for fav in snap.documents{
                    fav.reference.delete()
                    print("FavoriteTable削除！")
                }
            }
        }
        
        
        
        db.collection("MatchRoom").whereField("matchUser1", isEqualTo: self.currentUserData["id"] as! String).getDocuments { (snap, err) in
            if let snap = snap {
                if snap.count == 0 {
                    print("MatchRoom1削除なし")
                    return
                }
//                print("マッチルーム1の数: \(snap.count)")
                for room in snap.documents{
                    room.reference.delete()
                    print("MatchRoom1削除！")
                }
            }
        }
        db.collection("MatchRoom").whereField("matchUser2", isEqualTo: self.currentUserData["id"] as! String).getDocuments { (snap, err) in
            if let snap = snap {
                if snap.count == 0 {
                    print("MatchRoom2削除なし")
                    return
                }
//                print("マッチルーム2の数: \(snap.count)")
                for room in snap.documents{
                    room.reference.delete()
                    print("MatchRoom2削除！")
                }
            }
        }
        
        
//        var array = [String]()
        db.collection("MatchTable").document(self.currentUserData["id"] as! String).collection("MatchUser").getDocuments { (snap, err) in
            if let snap = snap {
                if snap.isEmpty{
                    print("マッチテーブルはないのでMatchUsersもありません。")
                    return
                }
                for id in snap.documents{
                    
                    let matchUserId = id.data()["MatchUserId"] as! String
                    let matchRoomId = id.data()["MatchRoomId"] as! String
//                    array.append(matchUserId)
                    self.db.collection("MatchUsers").document(matchUserId).collection("MatchUserData").whereField("MatchRoomId", isEqualTo: matchRoomId).getDocuments { (snap, err) in
                                       if let snap = snap{
                                        if snap.isEmpty {
                                               print("MatchUsers(他ユーザーテーブル)削除なし")
                                               return
                                           }
                                           //                        print("MatchUsersにある他人の中の自分のデータの数: \(snap.count)")
                                           for data in snap.documents{
                                               data.reference.delete()
                                               print("MatchUsersにある他人の中の自分のデータ削除！")
                                           }
                                       }
                                   }
                    
                        self.db.collection("Messages").whereField("matchId", isEqualTo: matchRoomId).getDocuments { (snap, err) in
                            if let snap = snap {
                                if snap.count == 0 {
                                    print("メッセージ削除なし")
                                    return
                                }
                            
                                for msg in snap.documents{
                                    msg.reference.delete()
                                    print("メッセージ削除！")
                                }
                            }
                        }
                    
                    
                    }
                }
            }
//            for id in array{
               
//        }
        
        db.collection("MatchUsers").document(self.currentUserData["id"] as! String).collection("MatchUserData").getDocuments { (snap, err) in
            if let snap = snap{
                if snap.count == 0 {
                    print("MatchUsers(自分テーブル)削除なし")
                    return
                }
                //                    print("自分のMatchUsersの相手の数: \(snap.count)")
                for data in snap.documents{
                    data.reference.delete()
                    print("自分のMatchUsers削除！")
                }
            }
        }
        
//        メッセ削除
        db.collection("MatchTable").document(self.currentUserData["id"] as! String).collection("MatchUser").getDocuments { (snap, err) in
            if let snap = snap {
                for id in snap.documents{
                    let matchId = id.data()["MatchRoomId"] as! String
                    self.db.collection("Messages").whereField("matchId", isEqualTo: matchId).getDocuments { (snap, err) in
                               if let snap = snap {
                                   if snap.count == 0 {
                                       print("メッセージ削除なし")
                                       return
                                   }
                               
                                   for msg in snap.documents{
                                       msg.reference.delete()
                                       print("メッセージ削除！")
                                   }
                               }
                           }
                }
            }
        }
        
        db.collection("MatchTable").document(self.currentUserData["id"] as! String).collection("MatchUser").getDocuments { (snap, err) in
                    if let snap = snap {
                        if snap.count == 0 {
                            print("MatchTable削除なし")
                            return
                        }
        //                print("マッチテーブルの数: \(snap.count)")
                        for table in snap.documents{
                            table.reference.delete()
                            print("自分側のMatchTable削除！")
                        }
                    }
                }

        
        //Users削除
        db.collection("Users")
            .whereField("id", isEqualTo: self.currentUserData["id"] ?? "")
            .getDocuments { (snap, err) in
                if err != nil {
                    return
                }
                if let snap = snap {
                    for user in snap.documents {
                        user.reference.delete()
                        print("Usesコレクション削除！")
                    }
                }
        }
        
    }
    //storage
    
    
    func deleteUserPicture(){
        let storageRef = Storage.storage().reference()
        
        // Delete the file
        storageRef
            .child("images/pictureOf_\(self.currentUserData["email"] ?? "")")
            .delete { error in
                if error != nil {
                    // Uh-oh, an error occurred!
                    print(error?.localizedDescription ?? "エラーがdeleteUserPictuireで発生")
                    return
                } else {
                    // File deleted successfully
                    print("storage削除！")
                }
        }
    }
    
    
    
    func saveEditInfo(name: String, age: String, subject: String, hometown: String, hobby: String, introduction: String, personality: String, studystyle:String, work:String, purpose:String, fee: String, place: String, schedule: String){
        db.collection("Users")
            .whereField("id", isEqualTo: self.currentUserData["id"] ?? "")
            .getDocuments { (snap, err) in
                if let err = err {
                    // Some error occured
                    print(err.localizedDescription)
                    return
                } else if snap!.documents.count != 1 {
                    // Perhaps this is an error for you?
                    print(err?.localizedDescription ?? "")
                    return
                } else {
                    let document = snap!.documents.first
                    document?.reference.updateData([
                        "name": name,
                        "age": age,
                        "subject": subject,
                        "hometown": hometown,
                        "hobby" : hobby,
                        "introduction" : introduction,
                        "personality" : personality,
                        "studystyle" : studystyle,
                        "work" : work,
                        "purpose" : purpose,
                        "fee": fee,
                        "schedule": schedule,
                        "place": place
                        
                    ])
                    self.getCurrentUser()
                    print("編集しました。")
                }
        }
        
    }
    
    func searchUser(key: String, value: String){
        
        self.searchedUsers = [User]()
        db.collection("Users").whereField(key, isEqualTo: value).getDocuments { (snap, err) in
            if let err = err{
                print(err.localizedDescription)
                return
            }
            
            if let snap = snap {
                for user in snap.documents{
                    let ref = user.data()
                    if ref["gender"] as? String != self.currentUserData["gender"] as? String{
                        self.searchedUsers.append(User(id: ref["id"] as! String, email: ref["email"] as! String, name: ref["name"] as! String, gender: ref["gender"] as! String, age: ref["age"] as! String, hometown: ref["hometown"] as! String, subject: ref["subject"] as! String, introduction: ref["introduction"] as! String, studystyle: ref["studystyle"] as! String, hobby: ref["hobby"] as! String, personality: ref["personality"] as! String, work: ref["work"] as! String, purpose: ref["purpose"] as! String, photoURL: ref["photoURL"] as! String, matchRoomId: "",fee: user.data()["fee"] as! String, schedule: user.data()["schedule"] as! String, place: user.data()["place"] as! String))
                        
                        for user in self.searchedUsers {
                            for matchUser in self.MatchUsers {
                                if user == matchUser{
                                    self.searchedUsers = self.searchedUsers.filter{ !self.MatchUsers.contains($0)}
                                }
                            }
                        } //マッチしてるユーザをフィルターにかける
                        self.filteredSearchedUsers = self.searchedUsers
                    } //同性を外す条件分岐とじ
                    
                }
            }
        }
        
    }
    @Published var matchNotification = false
    @Published var searchBoxOn = false
    
    func goodUser(user: User)->Bool{
           return user.schedule == "日中" && user.place == "カフェ" && user.schedule == "日中" && user.studystyle != "勉強はせずにお話をしてみたい" && user.studystyle != "その他"
       }
    func emptyUser(user: User)->Bool{
        return user.id == ""
    }
    
}//func



