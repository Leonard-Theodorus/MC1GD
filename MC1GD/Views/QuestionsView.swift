//
//  QuestionsView.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 01/05/23.
//

import SwiftUI

struct QuestionsView: View {
    @Binding var showQuestions: Bool
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Sesuaikan Label Dengan Pengeluaran Anak Anda ")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(colors: [Color.secondary_purple,Color.primary_purple], startPoint: .topLeading, endPoint: .bottomTrailing))
            .foregroundColor(.white)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Pertanyaan Panduan").font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        showQuestions = false
                    } label:{
                        ZStack{
                            Circle()
                                .fill(.white)
                                .opacity(0.5)
                                .frame(width: 35)
                            HStack(alignment: .center){
                                Text("X")
                                    .bold()
                                    .foregroundColor(.primary_gray)
                                    .padding()
                            }
                                
                        }
                    }
                        
                        
                }
        }
        }
    }
}

struct QuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionsView(showQuestions: .constant(false))
    }
}
