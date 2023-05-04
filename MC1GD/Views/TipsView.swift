//
//  TipsView.swift
//
//  Created by Jeremy Christopher on 04/05/23.
//

import SwiftUI
import WebKit
import SwiftUICharts

struct TipsView: View {
//    @Binding var showTips: Bool
    @Environment(\.presentationMode) var presentationMode
    @Binding var todayDateComponent : Date
    @Binding var data : DoughnutChartData
    var body: some View {
        NavigationView {
            VStack(spacing: 20){
                ScrollView{
                    ZStack{
                        YTView(ID: "62FZ-992ARU")
                        VStack(alignment: .leading, spacing: 5){
                            Text("5 Tips Menabung Untuk Anak")
                                .padding(.trailing, 60)
                            Text("12.34")
                            //                            .padding(.trailing, 40)
                        }
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 350)
                        .padding([.top, .bottom], 10)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(red: 103/255, green: 64/255, blue: 154/255), Color(red: 139/255, green: 96/255, blue: 186/255)]), startPoint: .leading, endPoint: .trailing)
                            
                        )
                        .padding(.top, 200)
                        .cornerRadius(/*@START_MENU_TOKEN@*/14.0/*@END_MENU_TOKEN@*/)
                    }
                    
                    ZStack{
                        YTView(ID: "45p4dPnHSJU")
                        VStack(alignment: .leading, spacing: 5){
                            Text("5 Tips Menabung Untuk Anak")
                                .padding(.trailing, 60)
                            Text("12.34")
                            //                            .padding(.trailing, 40)
                        }
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 350)
                        .padding([.top, .bottom], 10)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(red: 103/255, green: 64/255, blue: 154/255), Color(red: 139/255, green: 96/255, blue: 186/255)]), startPoint: .leading, endPoint: .trailing)
                            
                        )
                        .padding(.top, 200)
                        .cornerRadius(/*@START_MENU_TOKEN@*/14.0/*@END_MENU_TOKEN@*/)
                    }
                    
                    ZStack{
                        YTView(ID: "EJCAsHcS34g")
                        VStack(alignment: .leading, spacing: 5){
                            Text("5 Tips Menabung Untuk Anak")
                                .padding(.trailing, 60)
                            Text("12.34")
                            //                            .padding(.trailing, 40)
                        }
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 350)
                        .padding([.top, .bottom], 10)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(red: 103/255, green: 64/255, blue: 154/255), Color(red: 139/255, green: 96/255, blue: 186/255)]), startPoint: .leading, endPoint: .trailing)
                            
                        )
                        .padding(.top, 200)
                        .cornerRadius(/*@START_MENU_TOKEN@*/14.0/*@END_MENU_TOKEN@*/)
                    }
                    
                }
                
            }
            .navigationTitle("TIPS")
            .navigationBarItems(leading: backButton)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var backButton: some View {
            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                HStack {
                    Image(systemName: "chevron.backward")
                    Text("Ringkasan")
                        .font(.title3)
                }
                .foregroundColor(.primary_purple)
            }
        }
}

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        TipsView(
            todayDateComponent: .constant(Date()), data: .constant(DoughnutChartData(
                dataSets: PieDataSet(dataPoints: Array<PieChartDataPoint>(), legendTitle: ""), metadata: ChartMetadata(title: "", subtitle: ""), noDataText: Text("")))

        )
    }
}
