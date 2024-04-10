//
//  ActivityView.swift
//  LiftLog
//
//  Created by Kenneth Oliver Rathbun on 4/8/24.
//

import SwiftUI

struct DetailView: View {
    private var activity: Activity
    @Bindable var sharedActivities: SharedActivities
    
    private var index: Int
    
    init(activity: Activity, sharedActivities: SharedActivities) {
        self.activity = activity
        self.sharedActivities = sharedActivities
        
        if let index = sharedActivities.activities.firstIndex(where: { $0.id == activity.id }) {
            self.index = index
        } else {
            // Handle the case where activity is not found
            fatalError("Missing Index")
        }
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
//    let activity = Activity(name: "Pull Ups", notes: "Did 10")
    let activities = SharedActivities()
    
    return DetailView(activity: activities.activities[0], sharedActivities: activities)
}
