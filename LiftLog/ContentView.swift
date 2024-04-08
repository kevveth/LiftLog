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
    
    var body: some View {
        VStack {
            Image(systemName: "scalemass.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("LiftLog")
            Text("Workout: \(sharedActivities.sharedActivities[0].activity)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct Activity: Identifiable {
    let id = UUID()
    let activity: String
}

@Observable
class SharedActivities {
    var sharedActivities = [Activity(activity: "Pull Ups")]
}
