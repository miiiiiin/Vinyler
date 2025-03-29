//
//  LoginViewModel.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/25/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action
import Toaster

protocol LoginViewModelInput {
    var emailInput: BehaviorSubject<String> { get }
    var passwordInput: BehaviorSubject<String> { get }
    var doneAction: CocoaAction { get }
}

protocol LoginViewModelOutput {
    var isLoginEnabled: Observable<Bool> { get }
    var isEmailTextValid: Observable<Bool> { get }
}

protocol LoginViewModelType {
    var input: LoginViewModelInput { get }
    var output: LoginViewModelOutput { get }
}

class LoginViewModel: LoginViewModelInput, LoginViewModelOutput, LoginViewModelType {
    
    var input: LoginViewModelInput { return self }
    var output: LoginViewModelOutput { return self }
    
    var emailInput = BehaviorSubject<String>(value: "")
    var passwordInput = BehaviorSubject<String>(value: "")
    
    lazy var doneAction: CocoaAction = {
        CocoaAction { [unowned self] input in
            let password = try? self.passwordInput.value()
            let email = try? self.emailInput.value()
            
            var request = LoginRequest()
            request.email = email
            request.password = password
            
            return self.useCase.execute(request: request)
                .flatMap { result -> Observable<Void> in
                    switch result {
                    case let .success(response):
                        
                        debugPrint("login succ: \(response.grantType)")
                        
                        let viewModel = MainViewModel(sceneCoordinator: self.sceneCoordinator, useCase: self.useCase)
                        return self.sceneCoordinator.transition(to: Scene.main(viewModel))
                        
                        
                    case let .failure(error):
                        let errorResponse = error.errorDescription
                        Toast(text: errorResponse).show()
                        return .empty()
                    }
                }
        }
    }()
    
    // MARK: - Output -

    var isEmailTextValid = Observable<Bool>.just(false)
    var isLoginEnabled = Observable<Bool>.just(false)
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    private let useCase: CommonUseCase
    
    init(sceneCoordinator: SceneCoordinatorType, useCase: CommonUseCase) {
        self.sceneCoordinator = sceneCoordinator
        self.useCase = useCase
        
        // 이메일 유효성 검사
        isEmailTextValid = emailInput.distinctUntilChanged()
            .map { text in
                return !text.isEmpty && !text.isValidEmail
            }
        
        // 모든 필드가 채워져 있어야 회원가입 버튼 활성화
        self.isLoginEnabled = Observable
            .combineLatest(emailInput, passwordInput, isEmailTextValid)
            .map { email, password, emailValid in
                return !email.isEmpty && !password.isEmpty  && !emailValid
            }
    }
}
