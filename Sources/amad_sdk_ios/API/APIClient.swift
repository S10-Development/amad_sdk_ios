import Foundation
import Combine

// Custom error enum to handle API-related errors
public enum APIError: Error {
    case invalidResponse
    case networkError(Error)
    case httpError(Int)
    case serverError(Int, Data?)
    case decodingError(Error)
}
public enum APIMetthod:String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"

}

// APIClient class that supports accessing REST API using Combine and generics
public class APIClient {
    
    // Base URL of the API
    private var baseURL = URL(string: "https://s10plus.com:8443/wsqa/")!
    
    // URLSession used for sending HTTP requests
    private let urlSession: URLSession
    
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    public init(baseURL:String){
        self.baseURL = URL(string: baseURL) ?? self.baseURL
        self.urlSession = .shared

    }
    
    public func fetchData<T: Decodable>(
        from endpoint: String, method: APIMetthod = APIMetthod.get, headers: [String: String]? = nil) -> AnyPublisher<T, APIError> {
        return fetchData(from: endpoint, method: method, headers: headers, body: Optional<Data>.none)
    }
    public func fetchData<T: Decodable>(
        baseUrlParams:Optional<String> = .none,
        from endpoint: String, method: APIMetthod = APIMetthod.get, headers: [String: String]? = nil) -> AnyPublisher<T, APIError> {
            return fetchData(baseUrlParams: baseUrlParams,from: endpoint, method: method, headers: headers, body: Optional<Data>.none)
    }
    // Method to fetch data from a specific endpoint of the API
    public func fetchData<T: Decodable, Body: Encodable>(
        baseUrlParams:Optional<String> = .none,
        from endpoint: String, method: APIMetthod = APIMetthod.get, headers: [String: String]? = nil, body: Body? = nil) -> AnyPublisher<T, APIError> {
        // Construct URL for the specific endpoint
        if let baseUrlParams = baseUrlParams{
            self.baseURL = URL(string: baseUrlParams)!
        }
        let url = baseURL.appendingPathComponent(endpoint)
        
        // Create URLRequest with URL and method
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // Add headers if provided
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = CacheManager.shared.getData(forKey: CacheManager.shared.APPLICATION_SESION, as: String.self)
       
        if(session != nil){
            request.setValue(session, forHTTPHeaderField:"token" )

        }
        // Add body if provided
        if let body = body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                return Fail(error: APIError.networkError(error)).eraseToAnyPublisher()
            }
        }
        
        request.printDebugger()

        
        // Create a publisher to send the HTTP request and handle the response
        return urlSession.dataTaskPublisher(for: request)
            .tryMap { data, response in
               
                if let result = String(data: data, encoding: .utf8) {
                    print("========RESPONSE========")
                    print(" \(result)")
                    print("========================")
                }
                // Handle response and check HTTP status code
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                
                if (200..<300).contains(httpResponse.statusCode) {
                    // HTTP status code 2xx: Successful response
                    return data
                } else if (400..<500).contains(httpResponse.statusCode) {
                    // HTTP status code 4xx: Client error
                    throw APIError.httpError(httpResponse.statusCode)
                } else if (500..<600).contains(httpResponse.statusCode) {
                    // HTTP status code 5xx: Server error
                    throw APIError.serverError(httpResponse.statusCode, data)
                } else {
                    throw APIError.httpError(httpResponse.statusCode)
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                // Handle errors during JSON decoding
                if let decodingError = error as? DecodingError {
                    return APIError.decodingError(decodingError)
                } else {
                
                    return error as! APIError
                }
            }
            .eraseToAnyPublisher()
    }
}




import Foundation

extension URLRequest {
    
    func printDebugger() {
        print("============REQUEST================")
        print("URL: \(self.url?.absoluteString ?? "")")
        print("HTTP Method: \(self.httpMethod ?? "")")
        print("Headers: \(self.allHTTPHeaderFields?.description ?? "")")

        if let bodyData = httpBody {
            if let jsonObject = try? JSONSerialization.jsonObject(with: bodyData, options: []),
               let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Body Data (JSON):\n\(jsonString)")
            } else if let bodyString = String(data: bodyData, encoding: .utf8) {
                print("Body Data (Raw): \(bodyString)")
            } else {
                print("Body Data: (Unable to decode)")
            }
        } else {
            print("Body Data: nil")
        }
        print("===================================")
    }
}
