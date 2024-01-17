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
        guard let url = URL(string: PersonRequest.url) else {
            return Fail(error: NSError(domain: "Missing PersonRequest URL", code: -10001, userInfo: nil)).eraseToAnyPublisher()
        }
        let request = URLRequest(url: url)
        return fetchData(request: request)
    }
    
    func randomAge(name: String) -> AnyPublisher<AgeResponse, Error> {
        guard let url = URL(string: AgeRequest.url + name) else {
            return Fail(error: NSError(domain: "Missing AgeRequest URL", code: -10001, userInfo: nil)).eraseToAnyPublisher()
        }
        let request = URLRequest(url: url)
        return fetchData(request: request)
    }
    
    func randomGender(name: String) -> AnyPublisher<GenderResponse, Error> {
        guard let url = URL(string: GenderRequest.url + name) else {
            return Fail(error: NSError(domain: "Missing GenderRequest URL", code: -10001, userInfo: nil)).eraseToAnyPublisher()
        }
        let request = URLRequest(url: url)
        return fetchData(request: request)
    }
    
    func randomNationality(name: String) -> AnyPublisher<NationalityResponse, Error> {
        guard let url = URL(string: NationalityRequest.url + name) else {
            return Fail(error: NSError(domain: "Missing NationalityRequest URL", code: -10001, userInfo: nil)).eraseToAnyPublisher()
        }
        let request = URLRequest(url: url)
        return fetchData(request: request)
    }
}