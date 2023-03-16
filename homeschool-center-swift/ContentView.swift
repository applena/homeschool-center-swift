//
//  ContentView.swift
//  homeschool-center-swift
//
//  Created by Lena Eivy on 3/6/23.
//

import SwiftUI


struct ContentView: View {
    @State private var name = ""
    @State private var gradeString = ""
    
    var body: some View {
        VStack {
            TextField("Student Name", text: $name)
                .padding()
            TextField("Student Grade", text: $gradeString)
                .padding()
            
            Button(action: saveStudentInfo) {
                Text("Save")
            }
            .padding()
        }
    }
    
    func saveStudentInfo() {
        if let grade = Int(gradeString) {
            // Save student info to UserDefaults
            var studentInfo = UserDefaults.standard.dictionary(forKey: "studentInfo") as? [String: Int] ?? [String: Int]()
            studentInfo[name] = grade
            UserDefaults.standard.setValue(studentInfo, forKey: "studentInfo")
        } else {
            // Display error message
            print("ERROR - something went wrong")
        }
        print(UserDefaults.standard)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
