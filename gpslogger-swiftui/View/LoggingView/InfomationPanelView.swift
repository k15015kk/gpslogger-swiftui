//
//  InfomationPanelView.swift
//  gpslogger-swiftui
//
//  Created by 井上晴稀 on 2023/10/30.
//

import SwiftUI

struct InfomationPanelView: View {
    
    @State var title: String = ""
    @Binding var value: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.gray)
            Text(String(value))
                .font(.system(size: 20))
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    InfomationPanelView(title: "緯度", value: .constant(135.000))
}
