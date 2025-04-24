import SwiftUI

struct SettingsView: View {
    @State var viewModel: SettingsViewModel = SettingsViewModel()
    
    var body: some View {
        if let user = viewModel.user {
            userView(user: user)
        } else {
            loginForm()
                .alert(
                    viewModel.errorMessage,
                    isPresented: $viewModel.showError) {
                        Button("OK") { }
                    }
        }
    }
    @ViewBuilder
    func userView(user: User) -> some View {
        VStack {
            Text(user.id)
                .font(.headline)
            Text(user.email)
                .font(.subheadline)
            Button {
                viewModel.logout()
            } label: {
                Text("Logout")
            }
        }
    }

    @ViewBuilder
    func loginForm() -> some View {
        VStack {
            Spacer()
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
            Button(action: {
                Task{
                    await viewModel.login()
                }
            }) {
                Text("Login")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            
            Spacer()
        }
        .padding()
    }
}
#Preview {
    SettingsView()
}
