//
//  datePickerField.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 06/05/23.
//

import SwiftUI

struct datePickerField: View {
    @Binding var showDatePicker : Bool
    @Binding var todayDateComponent : Date
    var body: some View {
        HStack{
            Image(systemName: "calendar")
                .imageScale(.large)
                .foregroundColor(Color("secondary-gray"))
                .padding(.horizontal,15)
            
            Button{
                showDatePicker.toggle()
            }label:{
                Text(Date().formatDateFull(for: todayDateComponent))
                    .font(.body)
                    .padding(.vertical,8)
                    .padding(.horizontal,10)
                    .foregroundColor(.black)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.tertiary_gray)
                    )
            }
            
        }.padding(.top,10)
        if showDatePicker == true{
            HStack{
                DatePicker("" ,selection: $todayDateComponent, in: ...Date(), displayedComponents: .date).datePickerStyle(.wheel)
                    .accentColor(Color.primary_purple)
            }
        }
    }
}

struct datePickerField_Previews: PreviewProvider {
    static var previews: some View {
        datePickerField(showDatePicker: .constant(false), todayDateComponent: .constant(Date()))
    }
}
