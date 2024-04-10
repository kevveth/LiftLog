//
//  ContentView.swift
//  LiftLog
//
//  Created by Kenneth Oliver Rathbun on 4/6/24.
//

import SwiftUI
import Observation

struct ContentView: View {
    @State private var sharedActivities = SharedActivities(activities: [
        Activity(name: "Pull Ups", notes: "Did 10"),
        Activity(name: "Squats", completionCount: 7),
        Activity(name: "Bench Press")
      ])
    
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationStack() {
            List {
                ForEach(sharedActivities.activities) { activity in
                    NavigationLink(value: activity){
                        Text(activity.name)
                    }
                }
            }
            .navigationDestination(for: Activity.self) { activity in
                DetailView(activity: activity, sharedActivities: sharedActivities)
            }
            .navigationTitle("LiftLog 🪵")
            .toolbar {
                Button("Add Activity") {
                    showingAddActivity.toggle()
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                AddView(sharedActivities: sharedActivities)
            }
        }
    }
    
    
}

#Preview {
    ContentView()
}

struct Activity: Equatable, Hashable, Identifiable {
    let id = UUID()
    var name: String
    var completionCount: Int = 1
    var notes: String = ""
}

@Observable
class SharedActivities: Identifiable {
    var activities = [Activity]()
    
    init(activities: [Activity] = [Activity]()) {
        self.activities = activities
    }
}
