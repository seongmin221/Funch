//
//  MatchResultOverviewView.swift
//  FunchApp
//
//  Created by 이성민 on 1/23/24.
//

import SwiftUI

struct MatchResultOverviewView: View {
    
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
            
            Spacer()
                .frame(height: 16)
            
            Rectangle()
                .frame(width: 120, height: 120)
            
            Spacer()
                .frame(height: 16)
            
            VStack(alignment: .leading, spacing: 20) {
                SynergyView(title: "우리는 천생연분 궁합", description: "(userName)님의 MBTI는 ENTJ예요")
                SynergyView(title: "서로가 서로를 내조하는 운명", description: "(userName)님은 쌍둥이자리예요")
                SynergyView(title: "n호선에서 만나요!", description: "(userName)님도 n호선에 살고 있어요")
            }
            
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        MatchResultOverviewView()
    }
}

struct SynergyView: View {
    
    var title: String
    var description: String
    var imageName: String?
    
    init(title: String, description: String, imageName: String? = nil) {
        self.title = title
        self.description = description
        self.imageName = imageName
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 24, height: 24)
            
            Spacer()
                .frame(width: 12)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .font(.system(size: 18))
                    
                Spacer()
                    .frame(height: 2)
                
                Text(description)
                    .font(.system(size: 14))
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}
