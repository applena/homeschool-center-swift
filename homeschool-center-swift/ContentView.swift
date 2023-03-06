//
//  ContentView.swift
//  homeschool-center-swift
//
//  Created by Lena Eivy on 3/6/23.
//

import SwiftUI

struct ContentView: View {
    @State var studentName: String = ""
    @State var studentGrade: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    
    
    var body: some View {
        VStack {
            Text("Welcome to Homeschool Cental").font(.largeTitle)
            TextField(
                    "Student Name",
                    text: $studentName
            )
            .padding()
            .onSubmit {
                    print(studentName)
                }
            TextField(
                    "Student Grade",
                    text: $studentGrade
            ).padding()
            TextField(
                    "Password",
                    text: $password
            ).padding()
            TextField(
                    "Confirm Password",
                    text: $confirmPassword
            ).padding()
            Spacer()
            Button(
                action:{
                    print("button was pressed")
                },
                label: {
                    Text("Sign Up")
                }
            )
        }
        .multilineTextAlignment(.center)
        .padding([.top], 50)
  
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
