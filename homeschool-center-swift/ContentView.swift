//
//  ContentView.swift
//  homeschool-center-swift
//
//  Created by Lena Eivy on 3/6/23.
//

import SwiftUI

struct ContentView: View {
    @State var name: String = ""
    @State var gradeString: String = ""
    @State var noStudentInfo: Bool = true

    var body: some View {
        VStack {
            if noStudentInfo {
                CollectStudentInfoView()
            } else {
                DashboardView()
            }
        }
        .onAppear {
            if let dictionary = UserDefaults.standard.dictionary(forKey: "studentInfo"), !dictionary.isEmpty {
                noStudentInfo = false
            }
        }
    }

    func CollectStudentInfoView() -> some View  {
        VStack {
            TextField("Student Name", text: $name).padding()
            TextField("Student Grade", text: $gradeString).padding()

            Button(action: saveStudentInfo) {
                Text("Save")
            }
        }
    }

    func DashboardView() -> some View {
        Text("The dictionary is not empty.")
    }

    func saveStudentInfo() {
        print("user defaults.standard \(String(describing: UserDefaults.standard.dictionary(forKey: "studentInfo")))")
        if let grade = Int(gradeString) {
            // Save student info to UserDefaults
            var studentInfo = UserDefaults.standard.dictionary(forKey: "studentInfo") as? [String: Int] ?? [String: Int]()
            studentInfo[name] = grade
            UserDefaults.standard.setValue(studentInfo, forKey: "studentInfo")
            self.noStudentInfo = false
        } else {
            // Display error message
            print("ERROR - something went wrong")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
