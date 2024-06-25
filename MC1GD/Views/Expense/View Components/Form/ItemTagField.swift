//
//  itemTagField.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 06/05/23.
//

import SwiftUI

struct ItemTagField: View {
    @Binding var isNeeds : Bool
    @Binding var isWants : Bool
    @Binding var showQuestions : Bool
    @Binding var newItemTag : String
    var body: some View {
        VStack (alignment: .leading){
            HStack{
                Image(systemName: "tag")
                    .imageScale(.large)
                    .foregroundColor(Color.primary_gray)
                    .padding(.horizontal,15)
                Button{
                    if isNeeds != true {
                        if isWants != true {
                            isWants.toggle()
                            newItemTag = "Keinginan"
                        }else{
                            isWants.toggle()
                            newItemTag = ""
                        }
                    }else{
                        isNeeds.toggle()
                        isWants.toggle()
                        newItemTag = "Keinginan"
                    }
                } label: {
                    Text("Keinginan")
                        .font(.caption)
                        .bold()
                        .padding(2)
                        .textCase(.uppercase)
                    
                }
                .buttonStyle(.bordered)
                .foregroundColor(.white)
                .background(
                    Color.tag_pink
                        .opacity(self.isWants ? 1: 0.4)
                )
                .cornerRadius(25)
                .hoverEffect(.lift)
                Button{
                    if isWants != true{
                        if isNeeds != true {
                            self.isNeeds.toggle()
                            self.newItemTag = "Kebutuhan"
                        }else{
                            self.isNeeds.toggle()
                            self.newItemTag = ""
                        }
                    }else{
                        self.isWants.toggle()
                        self.isNeeds.toggle()
                        self.newItemTag = "Kebutuhan"
                    }
                } label: {
                    Text("Kebutuhan")
                        .font(.caption)
                        .bold()
                        .padding(2)
                        .textCase(.uppercase)
                    
                }
                .buttonStyle(.bordered)
                .foregroundColor(.white)
                .background(
                    Color.tag_purple
                        .opacity(self.isNeeds ? 1: 0.4)
                )
                .cornerRadius(25)
                .hoverEffect(.lift)
                
                Button{
                    showQuestions.toggle()
                } label: {
                    Image(systemName: "questionmark.circle.fill")
                        .foregroundColor(Color("secondary-gray"))
                }
                .buttonStyle(.borderless)
                .sheet(isPresented: $showQuestions) {
                    QuestionsView(showQuestions: $showQuestions)
                }
                
                
            }
            Text("Pilih Salah Satu")
                .font(.caption2)
                .padding(.leading,75)
                .italic()
                .foregroundColor(Color.secondary_gray)
        }
        .padding(.top,5)
        Divider()
    }
}

struct itemTagField_Previews: PreviewProvider {
    static var previews: some View {
        ItemTagField(isNeeds: .constant(false), isWants: .constant(false), showQuestions: .constant(false), newItemTag: .constant(""))
    }
}
