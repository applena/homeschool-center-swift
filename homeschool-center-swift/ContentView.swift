//
//  ContentView.swift
//  homeschool-center-swift
//
//  Created by Lena Eivy on 3/6/23.
//

import SwiftUI


struct ContentView: View {
    @State private var showSecondView = false
    @State private var name = ""
    @State private var gradeString = ""
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                Text("Welcome to Homeschool Center")
                    .font(.system(size: 33))
                    .multilineTextAlignment(.center)
                TextField("Student Name", text: $name)
                    .padding()
                TextField("Student Grade", text: $gradeString)
                    .padding()
                
                Button(action: saveStudentInfo) {
                    Text("Save")
                }
                NavigationLink(destination: SecondView(), isActive: $showSecondView) {
                    EmptyView()
                }
               
            }
        }
    }
    
    func saveStudentInfo() {
        if let grade = Int(gradeString) {
            // Save student info to UserDefaults
            var studentInfo = UserDefaults.standard.dictionary(forKey: "studentInfo") as? [String: Int] ?? [String: Int]()
            studentInfo[name] = grade
            UserDefaults.standard.setValue(studentInfo, forKey: "studentInfo")
            self.showSecondView = true
        } else {
            // Display error message
            print("ERROR - something went wrong")
        }
        print("user defaults.standard \(String(describing: UserDefaults.standard.dictionary(forKey: "studentInfo")))")
    }
}

struct SecondView: View {
    var body: some View {
        VStack {
            Text("This is the second view")
                .padding()
            .padding()
        }
        .navigationTitle("Second View")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
