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
    @State private var pathStore = PathStore()
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationStack(path: $pathStore.path) {
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
                Button {
                    showingAddActivity.toggle()
                } label: {
                    Image(systemName: "plus")
                        .bold()
                }
            }
        }
        .sheet(isPresented: $showingAddActivity) {
            AddView(sharedActivities: sharedActivities)
        }
    }
    
    
}

#Preview {
    ContentView()
}

struct Activity: Codable, Equatable, Hashable, Identifiable {
    var id = UUID()
    var name: String
    var completionCount: Int = 1
    var notes: String = ""
}

@Observable
class SharedActivities: Identifiable {
    var activities = [Activity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "SharedActivities")
            }
        }
    }
    
    init() {
        if let savedActivities = UserDefaults.standard.data(forKey: "SharedActivities") {
            if let decodedActivities = try? JSONDecoder().decode([Activity].self, from: savedActivities) {
                activities = decodedActivities
                return
            }
        } 
    }
    
    init(activities: [Activity] = [Activity]()) {
        self.activities = activities
    }
}
