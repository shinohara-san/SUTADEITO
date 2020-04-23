//
//  MatchView.swift
//  UserRegistration
//
//  Created by Yuki Shinohara on 2020/04/17.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

struct MatchView: View {
    @EnvironmentObject var shareData: ShareData
    
    let db = Firestore.firestore().collection("LikeTable")
    
    func getAllLikeGivenUser(){
        print("いいいい")
        db.document("nqIuqrFw8ww1F4FiQUrL").collection("LikeUser").whereField("LikeUserId", isEqualTo: self.shareData.currentUserData["id"] as? String ?? "").getDocuments { (snap, err) in
            if let err = err{
                print(err.localizedDescription)
                print("ええええ")
                return
            }
            if let snap = snap{
                for i in snap.documents{
                    print(i.data()["MyUserId"] ?? "")
                    print("うううう")
                }
            }
        }
    }
    
    var body: some View {
        Button("ライクくれた人一覧"){
            self.getAllLikeGivenUser()
        }
        .onAppear{
//            DispatchQueue.global().sync {
                self.getAllLikeGivenUser()
//            }
        print("ああああ")
        }
    } //body
    
} //struct

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        MatchView()
    }
}
