//
//  SwiftUIView.swift
//  Habito
//
//  Created by Kenneth Yang on 2/12/25.
//

import SwiftUI

struct SwiftUIView: View {
    @StateObject private var viewModel = TestViewModel()  // Initialize ViewModel
    
    @State private var newItemTitle = ""  // State to bind to the TextField for adding a new item
    
    var body: some View {
        VStack {
            // Display list of items from testList
            List(viewModel.testList) { item in
                Text(item.title)  // Display the title of each TestModel
            }
            
            // Input field for adding a new item
            TextField("Enter new item title", text: $newItemTitle)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            // Button to add new item
            Button(action: addItem) {
                Text("Add Item")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top)
        }
        .onAppear {
            // Fetch data when the view appears
            viewModel.fetchData()
        }
    }

    // Function to add a new item using the ViewModel
    func addItem() {
        // Only add if the title is not empty
        if !newItemTitle.isEmpty {
            viewModel.addTest(title: newItemTitle)  // Use ViewModel to add the new item
            newItemTitle = ""  // Clear the TextField after adding the item
        }
    }
}

#Preview {
    SwiftUIView()
}
