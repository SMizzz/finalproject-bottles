//
//  ShopNoticeDataStore.swift
//  Bottles_V2
//
//  Created by Jero on 2023/02/09.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class ShopNoticeDataStore : ObservableObject {
    // 전체 샵 데이터 저장 변수
    @Published var shopNoticeData : [ShopNotice] = []
    
    // 로그인 시 전체 패치 실행
    @MainActor
    func getAllShopNoticeData() async {
        do {
            let documents = try await Firestore.firestore().collection("shopNotice").getDocuments()
            for document in documents.documents {
                let docData = document.data()
                // 있는지를 따져서 있으면 데이터 넣어주고, 없으면 옵셔널 처리
                
                let id : String = document.documentID
                let category : String = docData["category"] as? String ?? ""
                let shopName : String = docData["shopName"] as? String ?? ""
                let createdAtTimeStamp: Timestamp = docData["date"] as? Timestamp ?? Timestamp()
                let title : String = docData["title"] as? String ?? ""
                let body : String = docData["body"] as? String ?? ""
                
                let date: Date = createdAtTimeStamp.dateValue()
               
                let shopNotice: ShopNotice = ShopNotice(
                    id: id,
                    category: category,
                    shopName: shopName,
                    date: date,
                    title: title,
                    body: body)
                
                self.shopNoticeData.append(shopNotice)
//                                        print("우하하하 \(self.shopData)")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
