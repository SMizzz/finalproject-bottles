//
//  BottleShopView_Search.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/01/18.
//

import SwiftUI

// 정렬 기본순, 낮은 가격순, 높은 가격순, 신상품순
enum Sort: String, CaseIterable, Identifiable {
    case automatic, priceDown, priceUp, popularity
    var id: Self { self }
}

// 바틀샵뷰 내 "상품 검색" 뷰
struct BottleShopView_Search: View {
    
    @State private var isEditing: Bool = false
    @State private var selectedSort = Sort.automatic
    @State private var showingActionSheet: Bool = false
    @State private var selection = "이름순"
    
    @Binding var search: Bool
    @FocusState var focus: Bool
    @Binding var isNavigationBarHidden: Bool
    
    @StateObject var bottleShopStore: BottleShopTestStore = BottleShopTestStore()
    
    var sortedBottleData: [BottleItem22] {
        let bottleItems: [BottleItem22] = bottleShopStore.bottleItems
        return bottleItems.sorted(by: {$0.name < $1.name})
    }
    
    func sortBottleData() -> [BottleItem22] {
        let bottleItems: [BottleItem22] = bottleShopStore.bottleItems
        switch selection {
//        case "거리순":
//            return bottleItems.sorted(by: {$0.name < $1.name}).sorted(by: {$0.distance < $1.distance})
        case "낮은 가격순":
            return bottleItems.sorted(by: {$0.name < $1.name}).sorted(by: {$0.price < $1.price})
        case "높은 가격순":
            return bottleItems.sorted(by: {$0.name < $1.name}).sorted(by: {$0.price > $1.price})
        default:
            return bottleItems.sorted(by: {$0.name < $1.name})
        }
    }
    
    
    var body: some View {
        VStack(alignment: .leading){
            // 검색창 버튼
                Button {
                    search = true
                    focus = true
                    isNavigationBarHidden = true
                } label: {
                    ZStack{
                        
                        Rectangle()
                            .frame(width: 358)
                            .foregroundColor(Color.gray_f7)
                            .cornerRadius(12)
                        
                        HStack {
                            
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                                .font(.system(size: 18))
                                .padding(.leading, 8)
                            
                            Text("이 바틀샵의 상품 검색")
                                .font(.bottles16)
                                .foregroundColor(.gray)
                                .padding(7)
                                .padding(.trailing, 25)

                            Spacer()
                        }
                    }
                .padding(.bottom, 10)
            }
            
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
                .padding(.leading, 22)
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
            
            // 검색 결과에 따라 정렬함(검색하지 않는 경우 모든 바틀 보여주고, 검색 텍스트 입력시 텍스트가 포함되어있는 해당 바틀만 보여줌)
            // 데이터 연동 시 "해당 샵의 바틀 리스트" 연동
            // 바틀 셀 반복문
            ForEach(sortBottleData(), id: \.self) { item in
                
                // 바틀셀 누를 시 바틀뷰로 이동
                NavigationLink(destination: BottleView(), label:{
                    BottleShopView_BottleList(selectedItem: BottleItem22(name: item.name, price: item.price, category: item.category, tag: item.tag, use: item.use))
                })
            }
            
        }
        .padding()
    }
}

//struct BottleShopView_Search_Previews: PreviewProvider {
//    static var previews: some View {
//        BottleShopView_Search(text: <#Binding<String>#>, search: <#Binding<Bool>#>, isNavigationBarHidden: <#Binding<Bool>#>)
//    }
//}
