//
//  EventDetailView.swift
//  HackIllinoisEvent
//
//  Created by Yash Jagtap on 9/17/24.
//

import SwiftUI

struct EventDetailView: View {
    @State var event: Event

    // Function to determine font size based on device type
    func timeFont() -> Font {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .footnote // Smaller font for iPhone
        } else {
            return .title2 // Normal font for iPad
        }
    }

    var body: some View {
        ScrollView { // Make it scrollable for long descriptions or multiple locations
            VStack(alignment: .leading, spacing: 15) {
                
                // Event Name
                Text(event.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("UIUCOrange"))
                    .padding(.vertical, 20)
                    .padding(.horizontal, 15)
                
                // Event Times with Icons
                HStack {
                    Image(systemName: "clock.fill") // Clock icon for start time
                        .foregroundColor(.gray)
                    Text("Start: \(event.formattedStartTime)")
                        .font(timeFont()) // Adjusted font for start time
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 5)
                .padding(.horizontal, 15)
                
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.gray)
                    Text("End: \(event.formattedEndTime)")
                        .font(timeFont()) // Adjusted font for end time
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 20)
                .padding(.horizontal, 15)
                
                // Event Description
                Text("Description")
                    .font(.headline)
                    .padding(.bottom, 5)
                    .padding(.horizontal, 15)
                
                Text(event.description)
                    .font(.body)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 10)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                
                // Location Information
                if !event.locations.isEmpty {
                    Text("Location")
                        .font(.headline)
                        .padding(.bottom, 5)
                        .padding(.horizontal, 15)
                    
                    ForEach(event.locations, id: \.id) { location in
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.blue)
                            Link(destination: URL(string: "https://www.google.com/maps/search/?api=1&query=\(location.latitude),\(location.longitude)")!) {
                                Text(location.description)
                                    .font(.title2)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.bottom, 5)
                        .padding(.horizontal, 15)
                    }
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Event Details")
        }
    }
}

