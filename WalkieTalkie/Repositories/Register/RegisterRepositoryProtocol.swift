//
//  RegisterRepositoryProtocol.swift
//  WalkieTalkie
//

//

protocol RegisterRepositoryProtocol {
    func register(user: RegisterRequest, completion: @escaping (Result<RegisterResponse, Error>) -> Void)
}
