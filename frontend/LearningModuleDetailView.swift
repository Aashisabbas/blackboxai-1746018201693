import SwiftUI

struct LearningModuleDetailView: View {
    var moduleTitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(moduleTitle)
                .font(.largeTitle)
                .bold()

            Text("This is the detail view for the \(moduleTitle) module. Here you can see the content, progress, and AI recommendations related to this module.")
                .font(.body)

            Spacer()
        }
        .padding()
        .navigationTitle(moduleTitle)
    }
}

struct LearningModuleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LearningModuleDetailView(moduleTitle: "Introduction to AI")
    }
}
