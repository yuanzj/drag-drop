//
//  DashboardTopBarView.swift
//  DragDrop
//
//  Created by 袁志健 on 2022/4/16.
//

import SwiftUI

struct DashboardTopBarView: View {
    var body: some View {
        HStack(spacing: 0) {
            HStack {
                Text("个人空间")
                    .fontWeight(.bold)
                Image("arrow-down")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14, height: 14)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .background(RoundedRectangle(cornerRadius: 32, style: .continuous)
                .fill(Color.white)
            )
            
            Spacer()
            
            HStack {
                Image("search-normal")
                TextField("搜索", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .frame(width: 200)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .background(RoundedRectangle(cornerRadius: 32, style: .continuous)
                .fill(Color.white)
            )
            
            HStack {
                Image("HeadPortrait1")
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                Image("HeadPortrait2")
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .offset(x: -16)
                Image("HeadPortrait3")
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .offset(x: -32)
                
                Circle()
                    .fill(Color.accentColor)
                    .frame(width: 48, height: 48)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .overlay(Text("+1").foregroundColor(Color.white))
                    .offset(x: -48)
            }
            .padding(.leading, 16)
            
        }
    }
}

struct DashboardTopBarView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardTopBarView()
    }
}
