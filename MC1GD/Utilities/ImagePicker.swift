//
//  ImagePicker.swift
//  MC1
//
//  Created by Leonard Theodorus on 18/04/23.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable{
    
    
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
     @Binding var selectedImage: UIImage
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
            var parent: ImagePicker
            
            init(_ parent: ImagePicker) {
                self.parent = parent
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                if let image = info[.editedImage] as? UIImage {
                    parent.selectedImage = image
                } else if let image = info[.originalImage] as? UIImage {
                    parent.selectedImage = image
                }
                
                parent.presentationMode.wrappedValue.dismiss()
            }
            
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                parent.presentationMode.wrappedValue.dismiss()
            }
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            picker.sourceType = sourceType
            picker.allowsEditing = true
            return picker
        }
        
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
            
        }
}
