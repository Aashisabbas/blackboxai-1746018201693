import Foundation

class Networking {
    static let shared = Networking()
    private let baseURL = "http://localhost:3000/api"
    private var token: String?

    func setToken(_ token: String) {
        self.token = token
    }

    func login(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = ["username": username, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1)))
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let accessToken = json["accessToken"] as? String {
                    self.token = accessToken
                    completion(.success(accessToken))
                } else {
                    completion(.failure(NSError(domain: "Invalid response", code: -1)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchLearningPath(completion: @escaping (Result<[[String: Any]], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/learning-path"),
              let token = token else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1)))
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
                    completion(.success(json))
                } else {
                    completion(.failure(NSError(domain: "Invalid response", code: -1)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func updateProgress(moduleId: Int, completed: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/progress"),
              let token = token else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = ["moduleId": moduleId, "completed": completed] as [String : Any]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }.resume()
    }

    func fetchRecommendations(completion: @escaping (Result<[[String: Any]], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/recommendations"),
              let token = token else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1)))
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
                    completion(.success(json))
                } else {
                    completion(.failure(NSError(domain: "Invalid response", code: -1)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
