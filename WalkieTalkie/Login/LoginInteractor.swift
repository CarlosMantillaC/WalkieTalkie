//
//  LoginInteractor.swift
//  WalkieTalkie
//

//

import Foundation

final class LoginInteractor {
    weak var presenter: LoginInteractorOutputProtocol?
    private let repository: LoginRepositoryProtocol
    
    init(repository: LoginRepositoryProtocol = LoginRepository()) {
        self.repository = repository
    }
}

extension LoginInteractor: LoginInteractorProtocol {
    func login(request: LoginRequest) {
        repository.login(request: request) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let token):
                    self?.presenter?.loginSucceeded(with: token)
                case .failure(let error):
                    self?.presenter?.loginFailed(with: error)
                }
            }
        }
    }
}
