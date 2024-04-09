//
//  ActivityView.swift
//  LiftLog
//
//  Created by Kenneth Oliver Rathbun on 4/8/24.
//

import SwiftUI

struct DetailView: View {
    @State var activity: Activity
    var sharedActivities: SharedActivities
    var index: Int {
        sharedActivities.activities.firstIndex(of: activity) ?? 0
    }
    
    var increment: () -> Void {
        return {
            var copy = activity
            copy.frequency += 1
            
            sharedActivities.activities[index] = copy
            
            activity.frequency += 1
        }
    }
    
    var decrement: () -> Void {
        return {
            var copy = activity
            copy.frequency -= 1
            
            sharedActivities.activities[index] = copy
            
            activity.frequency -= 1
        }
    }
    
    var body: some View {
        Form {
            Section("Frequency") {
                Stepper("\(activity.frequency)", onIncrement: increment, onDecrement: decrement)
                
                if activity.notes != "" {
                    Section("Notes"){
                        Text(activity.notes)
                    }
                }
            }
        }
        .navigationTitle(activity.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let activity = Activity(name: "Pull Ups", notes: "Did 10")
    let activities = SharedActivities(activities: [activity])
    
    return DetailView(activity: activity, sharedActivities: activities)
}
