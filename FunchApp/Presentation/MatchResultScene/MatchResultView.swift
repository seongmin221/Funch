//
//  MatchResultView.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/20/24.
//

import SwiftUI

struct MatchResultView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.black)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // action
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
            .navigationBarBackButtonHidden()
    }
}

#Preview {
    MatchResultView()
}
