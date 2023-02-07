//
//  MarkerDetailView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/30.
//

import SwiftUI

// MARK: - 마커 클릭 시 모달 뷰
struct MarkerDetailView: View {
    
    var shopData: ShopModel
    @State private var checkBookmark: Bool = true
    @Binding var showMarkerDetailView: Bool
    @Binding var currentShopId: String
//    @Binding var shopModel: ShopModel

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 8) {
                    Text("\(shopData.shopName)")
                        .font(.bottles20)
                        .fontWeight(.bold)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 1)
                            .opacity(0.5)
                            .frame(width: 49, height: 18)
                        Text("영업중")
                            .font(.bottles11)
                            .fontWeight(.medium)
                            .opacity(0.5)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 25) {
                        // 전화 버튼
                        Button(action: {
                            
                        }) {
                            Image("Phone.fill")
                                .resizable()
                                .frame(width: 19.5, height: 19.5)
                        }
                        
                        // 북마크 버튼
                        Button(action: {
                            checkBookmark.toggle()
                        }) {
                            Image(checkBookmark ? "BookMark.fill" : "BookMark")
                                .resizable()
                                .frame(width: 15, height: 19)
                        }
                    }
                }
                
                Text("\(shopData.shopIntroduction)")
                    .font(.bottles13)
                    .fontWeight(.medium)
                    .opacity(0.5)
                Text("\(shopData.shopCurationTitle)")
                    .font(.bottles15)
                    .fontWeight(.medium)
            }
            .padding(.horizontal)
            
            
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(shopData.shopImages, id: \.self) { imageLink in
                        // 바틀샵 이미지
                        AsyncImage(url: URL(string: imageLink)) { image in
                            image.resizable()
                        } placeholder: {
                            // FIXME: - 무한로딩 이슈
                            // ProgressView()
                            Image("oakDrum_Image")
                                .resizable()
                        }
                        .frame(width: 126, height: 126)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .foregroundColor(.black)
    }
}

//struct MarkerDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MarkerDetailView(mappinShop: $)
//    }
//}
