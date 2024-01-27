//
//  MatchResultView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

struct MatchResultView: View {
    
    var body: some View {
        ZStack {
            TabView {
                MatchResultCardView {
                    MatchResultOverviewView()
                }
                
                MatchResultCardView {
                    MatchResultConversationView()
                }
                
                MatchResultCardView {
                    Text("")
                }
            }
            .tabViewStyle(.page)
            .padding(.top, 8)
            
            VStack {
                Spacer()
                
                Button {
                    /* action */
                } label: {
                    Text("인스타그램 공유하기")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: 182, height: 52, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .buttonStyle(.funch)
                .shadow(color: .yellow.opacity(0.7), radius: 6, x: 0.0, y: 5)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    /* action */
                } label: {
                    Text("피드백 보내기")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 12.0))
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MatchResultView()
    }
}


struct MatchResultCardView<Content: View>: View {
    
    var content: () -> Content
    var gradient: Gradient = .init(colors: [.yellow, .black])
    
    var body: some View {
        VStack(spacing: 0) {
            content()
        }
        .padding(.top, 24)
        .padding(.horizontal, 28)
        .frame(maxHeight: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(LinearGradient(gradient: gradient,
                                       startPoint: .leading,
                                       endPoint: .trailing))
        }
        .padding(.horizontal, 20)
    }
}
