//
//  LoginRepositoryProtocol.swift
//  WalkieTalkie
//

//

protocol LoginRepositoryProtocol {
    func login(request: LoginRequest, completion: @escaping (Result<LoginResponse, Error>) -> Void)
}
