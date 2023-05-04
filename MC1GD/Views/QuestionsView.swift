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
            VStack(alignment:.leading){
                VStack(alignment:.center){
                    HStack{
                        Text("Sesuaikan Label Dengan Pengeluaran Anak Anda")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .frame(width:280)
                        Spacer()
                    }
                    .padding(.top, 5)
                    VStack(alignment: .center){
                        Image("tips")
                            .resizable()
                            .cornerRadius(20)
                            .scaledToFill()
                            .frame(maxWidth: 200, maxHeight: 200, alignment: .center)
                        
                    }
                    .background()
                    .padding(5)
                    VStack(alignment:.leading){
                        Text("Kamu dapat menyesuaikan apakah tipe pengeluaran tersebut masuk kedalam keinginan atau kebutuhan dengan panduan berikut:")
                            .font(.callout)
                            .multilineTextAlignment(.leading)
                            .padding(.vertical,5)
                        
                        HStack(alignment: .center){
                            Circle().fill(Color.white).frame(width: 10, height: 10)
                            Text("Mengapa anak membeli barang itu?")
                                .font(.callout)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .frame(width:351)
                        
                        HStack(alignment: .center){
                            Circle().fill(Color.white)
                                .frame(width: 10, height: 10)
                                .padding(.top,-10)
                            Text("Apa yang terjadi jika anak tidak membeli barang itu?")
                                .font(.callout)
                                .multilineTextAlignment(.leading)
                        }
                        .padding(.bottom, 5)
                        
                        
                        Text("Kamu dapat menilai pengetahuan anak anda mengenai kebutuhan dan keinginan dengan menanyakan apakah barang yang dibeli merupakan sesuatu yang dia butuhkan atau hanya sebuah keinginan, dan minta dia menjelaskan jawaban yang dia pilih !")
                            .font(.callout)
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding(22)
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
