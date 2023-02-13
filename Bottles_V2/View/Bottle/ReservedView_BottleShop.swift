//
//  ReservedView_BottleShop.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/18.
//

import SwiftUI

// MARK: - 픽업 바틀샵 저장
struct ReservedView_BottleShop: View {
    @State private var checkBookmark: Bool = false
    
    var body: some View {
        ZStack {
            Color("AccentColor").opacity(0.1).edgesIgnoringSafeArea([.top, .bottom])
            VStack(spacing: 3) {                
                Text("픽업 바틀샵 저장하기")
                    .font(.bottles14)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                // MARK: - 픽업한 바틀샵
                ReservedView_ShopCell()
            }
            .padding(.top, 10)
        }
    }
}

struct ReservedView_BottleShop_Previews: PreviewProvider {
    static var previews: some View {
        ReservedView_BottleShop()
    }
}
