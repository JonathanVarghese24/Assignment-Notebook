//
//  ContentView.swift
//  Assignment Notebook
//
//  Created by Jonathan Varghese on 1/30/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var Assignments = AssignmentList()
    @State private var showingAddAssignmentView = false
    var body: some View {
        NavigationView {
            List {
                ForEach(Assignments.items) { Assignment in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(Assignment.course)
                                .font(.headline)
                            Text(Assignment.description)
                        }
                        Spacer()
                        Text(Assignment.dueDate, style: .date)
                    }
                }
                .onMove { indices, newOffset in
                    Assignments.items.move(fromOffsets: indices, toOffset: newOffset)}
                
                .onDelete { indexSet in
                    Assignments.items.remove(atOffsets: indexSet)}
            }
            .sheet(isPresented: $showingAddAssignmentView, content: {
                AddAssignmentView(assignmentList: Assignments)
            })
            .navigationBarTitle("Assignments", displayMode: .inline)
            .navigationBarItems(leading: EditButton(),
                                trailing: Button(action: {
                showingAddAssignmentView = true}) {
                    Image(systemName: "plus")
                })
        }
    }
}

#Preview {
    ContentView()
}

struct Assignment : Identifiable, Codable {
    var id = UUID()
    var course = String()
    var description = String()
    var dueDate = Date()
}
