//  PersonNetworkService.swift
//  Cards
//  Created by Adam West on 16.01.2024.

import Combine
import Foundation

protocol PersonNetworkService {
    func randomPerson() -> AnyPublisher<PersonResponse, Error>
    func randomAge(name: String) -> AnyPublisher<AgeResponse, Error>
    func randomGender(name: String) -> AnyPublisher<GenderResponse, Error>
    func randomNationality(name: String) -> AnyPublisher<NationalityResponse, Error>
}

final class PersonNetworkServiceImpl: NetworkService, PersonNetworkService {
    func randomPerson() -> AnyPublisher<PersonResponse, Error> {
        guard let url = URL(string: PersonNetworkConstants.personRequest) else {
            return Fail(error: NSError(
                domain: "\(APIError.invalidURL("PersonResponse"))",
                code: -10001,
                userInfo: nil))
            .eraseToAnyPublisher()
        }
        let request = URLRequest(url: url)
        print(request)
        return fetchData(request: request)
    }
    
    func randomAge(name: String) -> AnyPublisher<AgeResponse, Error> {
        guard let url = URL(string: PersonNetworkConstants.ageRequest + name) else {
            return Fail(error: NSError(
                domain: "\(APIError.invalidURL("AgeRequest"))",
                code: -10001,
                userInfo: nil))
            .eraseToAnyPublisher()
        }
        let request = URLRequest(url: url)
        print(request)
        return fetchData(request: request)
    }
    
    func randomNationality(name: String) -> AnyPublisher<NationalityResponse, Error> {
        guard let url = URL(string: PersonNetworkConstants.nationalityRequest + name) else {
            return Fail(error: NSError(
                domain: "\(APIError.invalidURL("NationalityResponse"))",
                code: -10001,
                userInfo: nil))
            .eraseToAnyPublisher()
        }
        let request = URLRequest(url: url)
        print(request)
        return fetchData(request: request)
    }
    
    func randomGender(name: String) -> AnyPublisher<GenderResponse, Error> {
        guard let url = URL(string: PersonNetworkConstants.genderRequest + name) else {
            return Fail(error: NSError(
                domain: "\(APIError.invalidURL("GenderResponse"))",
                code: -10001,
                userInfo: nil))
            .eraseToAnyPublisher()
        }
        let request = URLRequest(url: url)
        return fetchData(request: request)
    }
}
