//
//  MatchResultConversationView.swift
//  FunchApp
//
//  Created by 이성민 on 1/23/24.
//

import SwiftUI

struct MatchResultConversationView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("user님과의 궁합")
                .font(.system(size: 14))
                .padding(.vertical, 8)
                .padding(.horizontal, 20)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
            
            Spacer()
                .frame(height: 8)
            
            Text("우리는 00% 닮았어요")
                .font(.system(size: 22))
            
            DynamicCenterHGrid(itemSpacing: 8, lineSpacing: 8) {
                ChipView(title: "개발자", imageName: "plus")
                ChipView(title: "넥스터즈", imageName: "plus")
                ChipView(title: "SOPT", imageName: "")
                ChipView(title: "Depromeet", imageName: "")
                ChipView(title: "ENTJ")
                ChipView(title: "쌍둥이자리")
                ChipView(title: "동대문역사문화공원")
            }
            .frame(maxWidth: .infinity)
            .background(.gray)
            .padding(20)
            .background(.black)
            
            Spacer()
        }
        .padding(.top, 24)
    }
    
    
    
}

#Preview {
    NavigationStack {
        MatchResultConversationView()
    }
}
