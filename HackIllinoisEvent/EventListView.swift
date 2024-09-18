//
//  EventListView.swift
//  HackIllinoisEvent
//
//  Created by Yash Jagtap on 9/17/24.
//

import SwiftUI

struct EventListView: View {
    @State private var events: [Event] = []

    var groupedEvents: [String: [Event]] {
        Dictionary(grouping: events, by: { $0.eventType })
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(groupedEvents.keys.sorted(), id: \.self) { category in
                    Section(header: Text(category)
                                .font(.headline)
                                .foregroundColor(Color("UIUCOrange"))
                                .padding()) {
                        ForEach(groupedEvents[category]!) { event in
                            HStack {
                                NavigationLink(destination: EventDetailView(event: event)) {
                                    VStack(alignment: .leading) {
                                        Text(event.name)  // Show event name
                                            .font(.headline)
                                            .foregroundColor(Color("UIUCOrange"))
                                        HStack {
                                            Text("Start: \(event.formattedStartTime)")
                                            Spacer()
                                            Text("End: \(event.formattedEndTime)")
                                        }
                                        .font(.footnote)
                                        .foregroundColor(Color("UIUCBlue"))
                                    }
                                    .padding()
                                }
                                
                                Spacer()
                                
                                // Favorite button
                                Button(action: {
                                    var updatedEvent = event
                                    updatedEvent.isFavorite.toggle()
                                    if let index = events.firstIndex(where: { $0.id == event.id }) {
                                        events[index] = updatedEvent
                                    }
                                }) {
                                    Image(systemName: event.isFavorite ? "heart.fill" : "heart")
                                        .foregroundColor(event.isFavorite ? .red : .gray)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                        }
                    }
                }
            }
            .navigationTitle("HackIllinois Events")
            .onAppear {
                loadEvents()
            }
        }
        .accentColor(Color(.gray))  // Set accent color for the navigation
    }

    private func loadEvents() {
        guard let url = URL(string: "https://adonix.hackillinois.org/event/") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching events: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decoder = JSONDecoder()
                let eventsResponse = try decoder.decode([String: [Event]].self, from: data)
                DispatchQueue.main.async {
                    self.events = eventsResponse["events"] ?? []
                }
            } catch {
                print("Error decoding events: \(error)")
            }
        }
        task.resume()
    }
}

