//
//  ActivityView.swift
//  LiftLog
//
//  Created by Kenneth Oliver Rathbun on 4/8/24.
//

import SwiftUI

struct DetailView: View {
    var activity: Activity
    @Bindable var sharedActivities: SharedActivities
    @Binding var path: NavigationPath
    
    var index: Int {
        guard let index = sharedActivities.activities.firstIndex(where: { $0.id == activity.id }) else {
            fatalError("Missing Index")
        }
        return index
    }
    
    var body: some View {
        Form {
            Section("Frequency") {
                Stepper("\(sharedActivities.activities[index].completionCount)", value: $sharedActivities.activities[index].completionCount)
            }
            
            Section("Notes"){
                TextField("Notes", text: $sharedActivities.activities[index].notes)
            }
            
            Button("Print Activity") {
                print("\(sharedActivities.activities[index])")
            }
        }
        .navigationTitle($sharedActivities.activities[index].name)
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    let activities = SharedActivities()
    return DetailView(activity: activities.activities[0], sharedActivities: activities, path: .constant(PathStore().path))
}
