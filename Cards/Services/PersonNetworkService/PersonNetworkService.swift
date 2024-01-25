//  PersonNetworkService.swift
//  Cards
//  Created by Adam West on 16.01.2024.

import Combine
import Foundation

protocol PersonNetworkService {
    func randomPerson() -> AnyPublisher<Person, Error>
    func randomAge(name: String) throws -> AnyPublisher<AgeResponse, Never>
    func randomGender(name: String) throws -> AnyPublisher<GenderResponse, Never>
    func randomNationality(name: String) throws -> AnyPublisher<NationalityResponse, Never>
}

final class PersonNetworkServiceImpl: NetworkService, PersonNetworkService {
    func randomPerson() -> AnyPublisher<Person, Error> {
        guard let url = URL(string: PersonNetworkConstants.personRequest) else {
            return Fail(error: NSError(
                domain: "\(APIError.invalidURL("PersonResponse"))",
                code: -10001,
                userInfo: nil))
            .eraseToAnyPublisher()
        }
        let request = URLRequest(url: url)
        return fetchData(request: request)
            .tryMap { (response: PersonResponse) -> Person in
                guard let response = response.results.first else {
                    throw NSError(
                        domain: "\(APIError.invalidData("Empty results"))",
                        code: -10001,
                        userInfo: nil)
                }
                return response
            }
            .eraseToAnyPublisher()
    }
    
    func randomAge(name: String) throws -> AnyPublisher<AgeResponse, Never> {
        guard let url = URL(string: PersonNetworkConstants.ageRequest + name) else {
            throw NSError(
                domain: "\(APIError.invalidURL("AgeRequest"))",
                code: -10001,
                userInfo: nil)
        }
        let request = URLRequest(url: url)
        return fetchData(request: request)
            .replaceError(with: AgeResponse())
            .eraseToAnyPublisher()
        
    }
    
    func randomNationality(name: String) throws -> AnyPublisher<NationalityResponse, Never> {
        guard let url = URL(string: PersonNetworkConstants.nationalityRequest + name) else {
            throw NSError(
                domain: "\(APIError.invalidURL("NationalityResponse"))",
                code: -10001,
                userInfo: nil)
        }
        let request = URLRequest(url: url)
        return fetchData(request: request)
            .replaceError(with: NationalityResponse())
            .eraseToAnyPublisher()
    }
    
    func randomGender(name: String) throws -> AnyPublisher<GenderResponse, Never> {
        guard let url = URL(string: PersonNetworkConstants.genderRequest + name) else {
            throw NSError(
                domain: "\(APIError.invalidURL("GenderResponse"))",
                code: -10001,
                userInfo: nil)
        }
        let request = URLRequest(url: url)
        return fetchData(request: request)
            .replaceError(with: GenderResponse())
            .eraseToAnyPublisher()
    }
}

private extension PersonNetworkServiceImpl {
    enum PersonNetworkConstants {
        static let personRequest = "https://randomuser.me/api/?inc=gender,name,email,phone,picture"
        static let ageRequest = "https://api.agify.io/?name="
        static let nationalityRequest = "https://api.nationalize.io/?name="
        static let genderRequest = "https://api.genderize.io?name="
    }
}
