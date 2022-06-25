//
//  Models.swift
//  BankDemo
//
//  Created by Rza Ismayilov on 23.06.22.
//

// MARK: Register

struct RegisterParams: Encodable {
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var email: String
    var password: String
    var country: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name",
             lastName = "last_name",
             phoneNumber = "phone_number",
             email, password, country
    }
}

// MARK: OTP Verification

struct OTPResponse: Decodable {
    var token: String
}

struct OTPParams: Encodable {
    var OTP: Int
}

// MARK: User

struct UserResponse: Decodable {
    var id: Int
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var email: String
    var country: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name",
             lastName = "last_name",
             phoneNumber = "phone_number",
             id, email, country
    }
}

// MARK: Card

struct CardResponse: Decodable {
    var id: Int
    var balance: Double
    var currency: String
    var code: String
}

// MARK: Transaction

struct TransactionDate: Decodable {
    var day: Int
    var month: String
    var year: Int
}

struct TransactionResponse: Decodable {
    var amount: Double
    var description: String
    var incoming: Bool
    var currency: String
    var date: TransactionDate
}

// MARK: Notification Count

struct NotificationCountResponse: Decodable {
    var count: Int
}

// MARK: Input Field Data Structures

struct InputFieldInfo {
    var fieldType: FieldType
    var placeholder: String
}
