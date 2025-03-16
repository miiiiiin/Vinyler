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

protocol SignUpViewModelInput {
    var emailInput: BehaviorSubject<String> { get }
    var passwordInput: BehaviorSubject<String> { get }
    var passwordCheckInput: BehaviorSubject<String> { get }
    var nicknameInput: BehaviorSubject<String> { get }
}

protocol SignUpViewModelOutput {
    var isSignUpEnabled: Observable<Bool> { get }
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
    
    
    var isSignUpEnabled = Observable<Bool>.just(false)
    
    
    var input: SignUpViewModelInput { return self }
    var output: SignUpViewModelOutput { return self }
    
    // MARK: - Private -
    
    private let sceneCoordinator: SceneCoordinatorType
    private let useCase: SignUpUseCase
    
    init(sceneCoordinator: SceneCoordinatorType, useCase: SignUpUseCase) {
        self.sceneCoordinator = sceneCoordinator
        self.useCase = useCase
        
        self.isSignUpEnabled = Observable.just(false)
        // 모든 필드가 채워져 있어야 회원가입 버튼 활성화
        self.isSignUpEnabled = Observable
            .combineLatest(emailInput, passwordInput, passwordCheckInput, nicknameInput)
            .map { email, password, passwordCheck, nickname in
                print("email check: \(email)")
                let isValid = !email.isEmpty && !password.isEmpty && password == passwordCheck && !nickname.isEmpty
                                print("🔹 isSignUpEnabled: \(isValid)")  // ✅ 값 변경 확인
                                return isValid
//                return !email.isEmpty && !password.isEmpty && password == passwordCheck && !nickname.isEmpty
            }
            .distinctUntilChanged()
//            .share(replay: 1, scope: .whileConnected)
    }
}
