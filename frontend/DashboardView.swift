import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to PERSO.AI")
                    .font(.title)
                    .padding()

                List {
                    NavigationLink(destination: LearningModuleDetailView(moduleTitle: "Introduction to AI")) {
                        Text("Introduction to AI")
                    }
                    NavigationLink(destination: LearningModuleDetailView(moduleTitle: "Machine Learning Basics")) {
                        Text("Machine Learning Basics")
                    }
                    NavigationLink(destination: LearningModuleDetailView(moduleTitle: "Deep Learning Fundamentals")) {
                        Text("Deep Learning Fundamentals")
                    }
                }
            }
            .navigationTitle("Dashboard")
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
