//
//  RegisterInteractor.swift
//  WalkieTalkie
//

//

import Foundation

final class RegisterInteractor {
    weak var presenter: RegisterInteractorOutputProtocol?
    private let repository: RegisterRepositoryProtocol
    
    init(repository: RegisterRepositoryProtocol = RegisterRepository()) {
        self.repository = repository
    }
}

extension RegisterInteractor: RegisterInteractorProtocol {
    func register(user: RegisterRequest) {
        repository.register(user: user) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.presenter?.registerSuccess(message: response.message)
                case .failure(let error):
                    self?.presenter?.registerFailed(with: error)
                }
            }
        }
    }
}
