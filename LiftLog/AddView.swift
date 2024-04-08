//
//  AddView.swift
//  LiftLog
//
//  Created by Kenneth Oliver Rathbun on 4/7/24.
//

import SwiftUI

struct AddView: View {
    @State private var name: String = ""
    @State private var notes: String = ""
    
    let sharedActivities: SharedActivities
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("New Activity") {
                    TextField("Name", text: $name)
                }
                
                
                Section("Optional"){
                    TextField("Notes", text: $notes)
                }
            }
            .navigationTitle("Add New Activity")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let activity = Activity(name: name, notes: notes)
                        sharedActivities.activities.append(activity)
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .tint(.red)
                }
            }
        }
    }
}

#Preview {
    AddView(sharedActivities: SharedActivities())
}
