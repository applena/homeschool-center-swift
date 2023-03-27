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
    @State var displayAddPortfolioItem = false
    @State var subject: String = ""
    @State var assignmentDate: Date = Date()
    @State var assignmentName: String = ""
    @State var assignmentLink: String = ""
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?

    var body: some View {
        VStack {
            if noStudentInfo {
                CollectStudentInfoView()
            } else {
                DashboardView()
            }
        }
        .onAppear {
            print("user defaults.standard \(String(describing: UserDefaults.standard.dictionary(forKey: "studentInfo")))")
            if let dictionary = UserDefaults.standard.dictionary(forKey: "studentInfo"), !dictionary.isEmpty {
                noStudentInfo = false
            }
            if let studentGrade = UserDefaults.standard.dictionary(forKey: "studentInfo")?[name]{
                gradeString = studentGrade as! String
                name = name
                
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
        VStack{
            Text("Welcome to Homeschool Center")
            Text(name)
            Text(gradeString).padding()
            Text("Portfolio")
            Button("Add Item") {
                displayAddPortfolioItem = !displayAddPortfolioItem
            }
            if displayAddPortfolioItem {
                AddPortfolioItem()
            }
        }
    }
    
    func AddPortfolioItem() -> some View {
        VStack{
            Form {
                Section(header: Text("Subject")) {
                    Picker("Choose a Subject", selection: $subject) {
                        Text("English")
                        Text("Math")
                        Text("Other")
                    }
                }
                
                Section(header: Text("Date of Assignment")) {
                  DatePicker(
                      "Assignment Date",
                      selection: $assignmentDate,
                      displayedComponents: [.date]
                  )
                }
                
                Section(header: Text("Name of Assignment")) {
                    TextField("Assignment Name", text: $assignmentName).padding()
                }
                
                Section(header: Text("Link to Assignment")) {
                    TextField("Assignment Link", text: $assignmentLink).padding()
                }
                
                Section(header: Text("Photo of Assignment")) {
                    
                }
                
                Button("Add New Item") {}
            }
        }
    }
    
    class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        // Your UIViewController code here
        func saveImage(image: UIImage) {
            guard let data = image.jpegData(compressionQuality: 1) else {
                return
            }
            let filename = getDocumentsDirectory().appendingPathComponent("image.jpg")
            do {
                try data.write(to: filename)
            } catch {
                print("Unable to save image.")
            }
        }
        
        func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }
    }
    
    struct ImagePicker: UIViewControllerRepresentable {
        @Binding var selectedImage: UIImage?
        @Environment(\.presentationMode) var presentationMode
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = context.coordinator
                imagePicker.sourceType = .photoLibrary
                return imagePicker
            }
        
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

            }
        
        func makeCoordinator() -> Coordinator {
                Coordinator(self)
            }
        
        class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
            let parent: ImagePicker


            init(_ parent: ImagePicker) {
                self.parent = parent
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                        if let selectedImage = info[.originalImage] as? UIImage {
                            parent.selectedImage = selectedImage
                            saveImage(image: selectedImage)
                        }
                        parent.presentationMode.wrappedValue.dismiss()
                }
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                    parent.presentationMode.wrappedValue.dismiss()
                }
            
            func saveImage(image: UIImage) {
                guard let data = image.jpegData(compressionQuality: 1) else {
                    return
                }
                let filename = getDocumentsDirectory().appendingPathComponent("image.jpg")
                do {
                    try data.write(to: filename)
                } catch {
                    print("Unable to save image.")
                }
            }
            
            func getDocumentsDirectory() -> URL {
                let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                return paths[0]
            }
        }
    }
    
    func saveStudentInfo() {
        if let grade = Int(gradeString) {
            // Save student info to UserDefaults
            var studentInfo = UserDefaults.standard.dictionary(forKey: "studentInfo") as? [String: Int] ?? [String: Int]()
            studentInfo[name] = grade
            UserDefaults.standard.setValue(studentInfo, forKey: "studentInfo")
            self.noStudentInfo = false
            name = name
            gradeString = gradeString
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
