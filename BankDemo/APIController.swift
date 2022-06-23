//
//  APIController.swift
//  BankDemo
//
//  Created by Rza Ismayilov on 23.06.22.
//

import UIKit
import Alamofire

class APIController {
    
    public static var instance = APIController()

    private var token = ""
    private var baseURL = "http://0.0.0.0:4000/api/"

    private lazy var session: Session = {
        let authAdapter = AuthAdapter {[weak self] in
            return "Bearer \(self?.token ?? "")"
        }
        
        let interceptor = Interceptor(adapters: [authAdapter], retriers: [], interceptors: [])
        
        return Session(interceptor: interceptor)
    }()
    
    private init() {}
    
    public func register(registerParams: RegisterParams) async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            self.session.request(baseURL + "register/", method: .post, parameters: registerParams)
                .validate()
                .response { response in
                    if let error = response.error {
                        continuation.resume(with: .failure(error))
                    } else {
                        continuation.resume()
                    }
                }
        }
    }
    
    public func verifyOTP(otpParams: OTPParams) async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            self.session.request(baseURL + "otp_verify/", method: .post, parameters: otpParams)
                .validate()
                .responseDecodable(of: OTPResponse.self) { response in
                    if let error = response.error {
                        continuation.resume(with: .failure(error))
                    } else if let value = response.value {
                        self.token = value.token
                        continuation.resume()
                    } else {
                        continuation.resume(with: .failure(DecodeError(message: "Decoding Error")))
                    }
                }
        }
    }
    
    public func getUser() async throws -> UserResponse {
        return try await withUnsafeThrowingContinuation { continuation in
            self.session.request(baseURL + "user/", method: .get)
                .validate()
                .responseDecodable(of: UserResponse.self) { response in
                    if let error = response.error {
                        continuation.resume(with: .failure(error))
                    } else if let value = response.value {
                        continuation.resume(with: .success(value))
                    } else {
                        continuation.resume(with: .failure(DecodeError(message: "Decoding Error")))
                    }
                }
        }
    }
    
    public func getCards() async throws -> [CardResponse] {
        return try await withUnsafeThrowingContinuation { continuation in
            self.session.request(baseURL + "card/", method: .get)
                .validate()
                .responseDecodable(of: [CardResponse].self) { response in
                    if let error = response.error {
                        continuation.resume(with: .failure(error))
                    } else if let value = response.value {
                        continuation.resume(with: .success(value))
                    } else {
                        continuation.resume(with: .failure(DecodeError(message: "Decoding Error")))
                    }
                }
        }
    }
    
    public func getTransaction() async throws -> [TransactionResponse] {
        return try await withUnsafeThrowingContinuation { continuation in
            self.session.request(baseURL + "transaction/", method: .get)
                .validate()
                .responseDecodable(of: [TransactionResponse].self) { response in
                    if let error = response.error {
                        continuation.resume(with: .failure(error))
                    } else if let value = response.value {
                        continuation.resume(with: .success(value))
                    } else {
                        continuation.resume(with: .failure(DecodeError(message: "Decoding Error")))
                    }
                }
        }
    }
    
    public func getNotificationCount() async throws -> NotificationCountResponse {
        return try await withUnsafeThrowingContinuation { continuation in
            self.session.request(baseURL + "notification_count/", method: .get)
                .validate()
                .responseDecodable(of: NotificationCountResponse.self) { response in
                    if let error = response.error {
                        continuation.resume(with: .failure(error))
                    } else if let value = response.value {
                        continuation.resume(with: .success(value))
                    } else {
                        continuation.resume(with: .failure(DecodeError(message: "Decoding Error")))
                    }
                }
        }
    }
    
}

class AuthAdapter: RequestAdapter {
    
    var getToken : () -> String

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        request.setValue(getToken(), forHTTPHeaderField: "Authorization")
        completion(.success(request))
    }
    
    init(getToken: @escaping () -> String) {
        self.getToken = getToken
    }
}

struct DecodeError: Error {
    var message: String
}
