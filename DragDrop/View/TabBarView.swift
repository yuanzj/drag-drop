//
//  TabBarView.swift
//  DragDrop
//
//  Created by 袁志健 on 2022/4/16.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        VStack {
            Image("ic_logo")
            
            Group {
                Image("category")
                    .renderingMode(.template)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Circle().fill(Color.accentColor))
                   
                Image("chart")
                    .renderingMode(.template)
                    .foregroundColor(Color.secondary)
                    .padding()
                    
                Image("sms")
                    .renderingMode(.template)
                    .foregroundColor(Color.secondary)
                    .padding()
                    
                Image("calendar")
                    .renderingMode(.template)
                    .foregroundColor(Color.secondary)
                    .padding()
                   
                Image("setting")
                    .renderingMode(.template)
                    .foregroundColor(Color.secondary)
                    .padding()
            }
            .padding(.top, 32)
            
            Spacer()
            
            Image("HeadPortrait")
            
            Image("logout")
                .renderingMode(.template)
                .foregroundColor(Color.secondary)
                .frame(width: 48, height: 48)
                .padding(.top, 16)
        }
        .frame(maxHeight: .infinity)
        .frame(width: 100)
        .padding(.vertical, 24)
        .background(RoundedRectangle(cornerRadius: 32, style: .continuous).fill(Color.white))
        .padding(32)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
