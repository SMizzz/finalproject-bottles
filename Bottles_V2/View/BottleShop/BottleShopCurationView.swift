//
//  BottleShopCurationView.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/01/18.
//

import SwiftUI

// 바틀샵뷰 내 "큐레이션" 뷰
struct BottleShopCurationView: View {
    @State private var selectedSort = Sort.automatic
    @State private var showingActionSheet: Bool = false
    @State private var selection = "이름순"
//    @StateObject var bottleShopStore: BottleShopTestStore = BottleShopTestStore()
    
    @EnvironmentObject var bottleDataStore: BottleDataStore
    
    var bottleShop: ShopModel
    
    var sortedBottleData: [BottleModel] {
        let bottleItems: [BottleModel] = bottleDataStore.bottleData
        return bottleItems.sorted(by: {$0.itemName < $1.itemName})
    }
    
    func sortBottleData() -> [BottleModel] {
        let bottleItems: [BottleModel] = bottleDataStore.bottleData
        let test = bottleItems.filter{ $0.shopID == bottleShop.id }
        
        switch selection {
        case "낮은 가격순":
            return test.sorted(by: {$0.shopName < $1.shopName}).sorted(by: {$0.itemPrice < $1.itemPrice})
        case "높은 가격순":
            return test.sorted(by: {$0.shopName < $1.shopName}).sorted(by: {$0.itemPrice > $1.itemPrice})
        default:
            return test.sorted(by: {$0.shopName < $1.shopName})
        }
    }

    var body: some View {
        ScrollView{
            VStack{
                ZStack{
                    // 데이터 연동 시 "shopCurationImage" 연동
                    AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1591243315780-978fd00ff9db?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2340&q=80")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 370)
                    } placeholder: {
                        Rectangle()
                            .frame(width: 370, height: 370)
                    }
                    .cornerRadius(12, corners: [.topLeft, .topRight])
                    .foregroundColor(.white)
                }
                    
                    
                    VStack{
                        
                        Spacer()
                        
                        VStack(alignment: .leading){
                            
                            // 데이터 연동 시 "shopCurationTitle" 연동
                            HStack{
                                Text(bottleShop.shopCurationTitle)
                                    .font(.bottles18)
                                    .fontWeight(.bold)
                                    .foregroundColor(.accentColor)
                                    .padding(.bottom, -1)
                                    .padding(.top)
                                
                                Spacer()
                                    .frame(width: 1)
                            }
                            
                            // 데이터 연동 시 "shopCurationBody" 연동
                            let shopCurationBody = bottleShop.shopCurationBody
                            let seperatedshopCurationBody = shopCurationBody.components(separatedBy: ["|"])
                            ForEach(seperatedshopCurationBody, id: \.self){ curationBody in
                                
                                Text(curationBody)
                                    .padding(.top, 1)
                                    .font(.bottles14)
                                    .foregroundColor(.black)
                                    .padding(.bottom, -7)
                            }
                            }
                            .padding(.horizontal, 1)
                            .padding(.bottom, 25)
                            //                        .padding(.leading, -24)
                            .shadow(radius: 20)
                            .background{
                                Rectangle()
                                    .frame(width: 370)
                                    .foregroundColor(.purple_3)
                                    .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
                            }
                            .frame(alignment: .leading)
                    }.padding(.top, -16)

                
                VStack(alignment: .leading){
                    
                    // 바틀 정렬 버튼
                    HStack {
                        Spacer()
                        
                        Button {
                            showingActionSheet = true
                        } label: {
                            HStack {
                                Text("\(selection)")
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 12))
                            }
                            .font(.bottles14)
                            .foregroundColor(.black)
                        }
                        .padding(.leading, 20)
                        .padding(.bottom, -10)
                    }
                    
                    // MARK: - 정렬 ActionSheet
                    .confirmationDialog("select a sort", isPresented: $showingActionSheet) {
                        Button {
                            selection = "이름순"
                        } label: {
                            Text("이름순")
                        }
                        
                        Button("낮은 가격순") {
                            selection = "낮은 가격순"
                        }
                        
                        Button("높은 가격순") {
                            selection = "높은 가격순"
                        }
                    }
                    
                    // 데이터 연동 시 "큐레이션 추천 바틀" 연동
                    // 바틀 셀(정렬 후) 반복문
                    ForEach(sortBottleData(), id: \.self) { item in
                        
                        // 바틀셀 누를 시 바틀뷰로 이동
                        NavigationLink(destination: BottleView(), label:{
                            BottleShopView_BottleList(selectedItem: item)
                        })
                        
                    }
                }
            }
            .padding()
            .navigationBarTitle("바틀샵 이름")
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

//struct BottleShopCurationView_Previews: PreviewProvider {
//    static var previews: some View {
//        BottleShopCurationView()
//    }
//}
