//
//  ContentView.swift
//  LiftLog
//
//  Created by Kenneth Oliver Rathbun on 4/6/24.
//

import SwiftUI
import Observation

struct ContentView: View {
    @State private var sharedActivities = SharedActivities()
    @State private var showingAddActivity = false
    
    let examples = [
        Activity(name: "Pull Ups"),
        Activity(name: "Squats"),
        Activity(name: "Bench Press")
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sharedActivities.activities) { activity in
                    NavigationLink(value: activity){
                        Text(activity.name)
                    }
                    .navigationDestination(for: Activity.self) { activity in
                        Text("Detal View")
                    }
                }
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

struct Activity: Identifiable, Hashable {
    let id = UUID()
    let name: String
    var notes: String = ""
}

@Observable
class SharedActivities {
    var activities = [Activity(name: "Pull Ups")]
}
