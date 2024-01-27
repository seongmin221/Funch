//
//  OnboardingView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

struct OnboardingView: View {
    @State private var showsProfileEdiorView: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Text("친구와 프로필 매칭하기")
                .font(.system(size: 14, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
            
            Text("우리 사이의 공통점을 찾아요")
                .font(.system(size: 22, weight: .bold))
                .multilineTextAlignment(.center)
            
            Spacer()
                .frame(height: 46)
            
            Image(.onboardingCard)
                .resizable()
                .scaledToFit()
            
            Spacer()
                .frame(height: 46)
            
            Text("1분만에 프로필 만들고 매칭해보기")
                .font(.system(size: 14, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
            
            Spacer()
                .frame(height: 8)

            
            Button {
                showsProfileEdiorView.toggle()
            } label: {
                Text("프로필 생성 시작🚀")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
            }
            .buttonStyle(.funch)
            
        }
        .padding(.horizontal, 57)
        .navigationDestination(isPresented: $showsProfileEdiorView) {
            ProfileEditorView()
        }
        .navigationTitle("e")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    OnboardingView()
}
