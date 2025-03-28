//
//  SignUpViewModel.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/11/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Action
import Toaster

protocol SignUpViewModelInput {
    var emailInput: BehaviorSubject<String> { get }
    var passwordInput: BehaviorSubject<String> { get }
    var passwordCheckInput: BehaviorSubject<String> { get }
    var nicknameInput: BehaviorSubject<String> { get }
    
    var doneAction: CocoaAction { get }
}
    
protocol SignUpViewModelOutput {
    var isSignUpEnabled: Observable<Bool> { get }
    var isPWTextValid: Observable<Bool> { get }
    var isCheckTextValid: Observable<Bool> { get }
    var isEmailTextValid: Observable<Bool> { get }
}

protocol SignUpViewModelType {
    var input: SignUpViewModelInput { get }
    var output: SignUpViewModelOutput { get }
}

class SignUpViewModel: SignUpViewModelInput, SignUpViewModelOutput, SignUpViewModelType {
    
    var emailInput = BehaviorSubject<String>(value: "")
    var passwordInput = BehaviorSubject<String>(value: "")
    var passwordCheckInput = BehaviorSubject<String>(value: "")
    var nicknameInput = BehaviorSubject<String>(value: "")
    
    var input: SignUpViewModelInput { return self }
    var output: SignUpViewModelOutput { return self }
    
    // MARK: - Input -
    
    lazy var doneAction: CocoaAction = {
        CocoaAction { [unowned self] input in
            //fixme
            
            let checkedPw = try? self.passwordCheckInput.value()
            let email = try? self.emailInput.value()
            let nickname = try? self.nicknameInput.value()
            
            var request = SignUpRequest()
            request.email = email
            request.password = checkedPw
            request.nickname = nickname
            request.profile = nil
            request.birthday = nil
            
            return self.useCase.execute(request: request)
                .flatMap { result -> Observable<Void> in
                    switch result {
                    case let .success(response):
                        // TODO: Login
                        
                        return .empty()
                        
                    case let .failure(error):
                        let errorResponse = error.errorDescription
                        Toast(text: errorResponse).show()
                        return .empty()
                        
                    }
                }
        }
    }()
    
    // MARK: - Output -
    
    var isPWTextValid = Observable<Bool>.just(false)
    var isCheckTextValid = Observable<Bool>.just(false)
    var isEmailTextValid = Observable<Bool>.just(false)
    var isSignUpEnabled = Observable<Bool>.just(false)
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    private let useCase: CommonUseCase
    
    init(sceneCoordinator: SceneCoordinatorType, useCase: CommonUseCase) {
        self.sceneCoordinator = sceneCoordinator
        self.useCase = useCase
        
        isPWTextValid = passwordInput.asObservable()
            .map { text in
                return text.count >= 6
            }
        
        isCheckTextValid = Observable.combineLatest(passwordInput.asObservable(), passwordCheckInput.asObservable())
            .map { newText, currentText  in
                return newText == currentText
            }
        
        // 이메일 유효성 검사
        isEmailTextValid = emailInput.distinctUntilChanged()
            .map { text in
                return !text.isEmpty && !text.isValidEmail
            }
        
        // 모든 필드가 채워져 있어야 회원가입 버튼 활성화
        self.isSignUpEnabled = Observable
            .combineLatest(emailInput, passwordInput, passwordCheckInput, nicknameInput, isEmailTextValid)
            .map { email, password, passwordCheck, nickname, emailValid in
                return !email.isEmpty && !password.isEmpty && password == passwordCheck && !nickname.isEmpty && !emailValid
            }
    }
}
