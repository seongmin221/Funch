//
//  MatchingRepository.swift
//  FunchApp
//
//  Created by Geon Woo lee on 1/21/24.
//

import SwiftUI
import Moya

/// User 타인을 기준으로 하는 repository
final class MatchingRepository: MatchingRepositoryType {
    
    private let apiClient: APIClient
    
    init() {
        apiClient = APIClient()
    }
    
    /// 상대 프로필 검색
    func matchingUser(
        searchUserQuery: MatchingUserQuery,
        completion: @escaping (Result<MatchingInfo, MoyaError>) -> Void
    ) {
        let requestDTO = RequestDTO.MatchingUser(query: searchUserQuery)
        apiClient.request(
            ResponseDTO.MatchingUser.self,
            target: .matchingUser(parameters: requestDTO.toDitionary)
        ) { result in
            switch result {
            case .success(let success):
                SwiftUI.Task { @MainActor in
                    completion(.success(success.toDomain()))
                }
            case .failure(let failure):
                SwiftUI.Task { @MainActor in
                    completion(.failure(failure))
                }
            }
        }
    }
    
}
