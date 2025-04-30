import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var errorMessage: String?

    var body: some View {
        if isLoggedIn {
            DashboardView()
        } else {
            VStack(spacing: 20) {
                Text("PERSO.AI Login")
                    .font(.largeTitle)
                    .bold()

                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }

                Button(action: login) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }

    func login() {
        // Placeholder login logic
        if username.isEmpty || password.isEmpty {
            errorMessage = "Please enter username and password."
            return
        }
        // For demo, accept any non-empty credentials
        isLoggedIn = true
        errorMessage = nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
