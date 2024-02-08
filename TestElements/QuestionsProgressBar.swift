//
//  QuestionsProgressBar.swift
//  TestElements
//
//  Created by Emiliano De Simone on 6.2.2024.
//

import SwiftUI

struct QuestionsProgressBar: View {
    var totalNumberOfQuestions: Int
    var currentQuestion: Int
    var back: (() -> Void)?
    
    
    var body: some View {
        ZStack(alignment: .center){
            GeometryReader{ proxy in
                HStack(alignment: .center) {
                    if let back {
                        Button(action: back)
                        {
                            Image("icon-chevron-left")
                                .foregroundColor(.blue)
                                .padding()
                                .contentShape(Rectangle())
                        }
                        .position(x: 0 , y: proxy.size.height / 2)
                        .padding(.leading)
                    }
                }
                ZStack(alignment: .leading){
                    Capsule()
                        .frame(width: 260, height: 4)
                        .foregroundColor(.gray)
                    Capsule()
                        .frame(width: (260.0 * Double(currentQuestion))/(Double(totalNumberOfQuestions)), height: 4)
                        .foregroundColor(.blue)
                        
                }.position(x: proxy.size.width / 2, y: proxy.size.height / 2)
            }
            HStack(alignment: .center){
                Spacer()
                Text( "\(currentQuestion)/\(totalNumberOfQuestions)")
            }
        }.frame(height: 40)
        .padding()
        
    }
}

#Preview {
    QuestionsProgressBar(totalNumberOfQuestions: 10, currentQuestion: 7)
}
