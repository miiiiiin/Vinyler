//
//  LoginViewModel.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/25/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation

protocol LoginViewModelInput {
}

protocol LoginViewModelOutput {
}

protocol LoginViewModelType {
    var input: LoginViewModelInput { get }
    var output: LoginViewModelOutput { get }
}

class LoginViewModel: LoginViewModelInput, LoginViewModelOutput, LoginViewModelType {
    
    
    var input: LoginViewModelInput { return self }
    var output: LoginViewModelOutput { return self }
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    private let useCase: SignUpUseCase
    
    init(sceneCoordinator: SceneCoordinatorType, useCase: SignUpUseCase) {
        self.sceneCoordinator = sceneCoordinator
        self.useCase = useCase
    }
}
