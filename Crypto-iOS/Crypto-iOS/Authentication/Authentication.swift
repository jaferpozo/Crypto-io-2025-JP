import Dependencies
import Foundation
import FirebaseAuth

struct AuthClient {
    var signIn: (_ email: String,_ password: String) async throws -> User
    var signOut: () throws-> Void
    var getCurrentUser: () throws-> User
}

enum AuthError: Error, LocalizedError {
    case signInFailed(String)
    case userNotFound
    case signOutFailed

    var localizedDescription: String {
        switch self {
        case let .signInFailed(errorMessage):
            return errorMessage
        case .userNotFound:
            return "User not found"
        case .signOutFailed:
            return "Sign out failed"
        }
    }
}

extension AuthClient: DependencyKey {
    static var liveValue: AuthClient {
        let auth = Auth.auth()
        return .init(
            signIn: { email, password in
                do {
                    let result: AuthDataResult = try await auth.signIn(withEmail: email, password: password)
                    return User(id: result.user.uid, email: result.user.email ?? "")

                } catch {
                    throw AuthError.signInFailed(error.localizedDescription)
                }

            }, signOut: {
                do {
                    try auth.signOut()
                } catch {
                    throw AuthError.signOutFailed
                }
            }, getCurrentUser: {
                guard let currentUser = auth.currentUser else {
                    throw AuthError.userNotFound
                }
                return User(id: currentUser.uid, email: currentUser.email ?? "")
            }
        )
    }

    static var previewValue: AuthClient {
        return .init(
            signIn: { email, _ in
               return User(id: "abc123", email: email)
            }, signOut: { },
            getCurrentUser: {
                return User(id: "abc123", email: "demo@test.com")
            }
        )
    }

    static var testValue: AuthClient {
        return .init(
            signIn: { email, _ in
                reportIssue("AuthClient.signIn not implemented")
                return User(id: "abc123", email: email)
            }, signOut: {
                reportIssue("AuthClient.signOut not implemented")
            },
            getCurrentUser: {
                reportIssue("AuthClient.getCurrentUser not implemented")
                return User(id: "abc123", email: "demo@test.com")
            }
        )
    }
}

extension DependencyValues {
    var authClient: AuthClient {
        get { self[AuthClient.self] }
        set { self[AuthClient.self] = newValue }
    }
}

