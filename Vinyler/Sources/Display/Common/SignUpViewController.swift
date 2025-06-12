//
//  SignUpViewController.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/11/25.
//  Copyright © 2025 songkyung min. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import SnapKit

class SignUpViewController: UIViewController, ViewModelBindableType {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView = UIStackView(forAutoLayout: ())
    private let titleLabel = UILabel.headerBold
    private let emailField = CustomTextFieldView(forAutoLayout: ())
    private let passwordField = CustomTextFieldView(forAutoLayout: ())
    private let passwordCheckField = CustomTextFieldView(forAutoLayout: ())
    private let nicknameField = CustomTextFieldView(forAutoLayout: ())
    private var doneButton = UIButton.done
    
    // MARK: - ViewModel
    
    var viewModel: SignUpViewModelType!
    
    private let disposeBag = DisposeBag()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    override func viewDidLoad() {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setUp() {
        setupKeyboardHandling()
        
    }
    
    override func loadView() {
        let root = UIView()
        root.backgroundColor = .coldDarkBlue
        self.view = root
        
        passwordField.textField.isSecureTextEntry = true
        passwordCheckField.textField.isSecureTextEntry = true
        
        root.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.keyboardDismissMode = .interactive
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: root.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: root.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: root.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: root.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: root.widthAnchor) // 가로 크기 고정
        ])
        
        titleLabel.text = .signUp
        emailField.setLabel(str: "이메일", text: "이메일을 입력해주세요")
        passwordField.setLabel(str: "비밀번호", text: "비밀번호를 입력해주세요")
        passwordCheckField.setLabel(str: "비밀번호 확인", text: "비밀번호를 입력해주세요")
        nicknameField.setLabel(str: "닉네임", text: "닉네임을 입력해주세요")
        
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fill
        stackView.alignment = .fill
        
        let textFields = [emailField, passwordField, passwordCheckField, nicknameField]
        
        textFields.forEach { field in
            field.setLabelColor(label: .white, text: .white)
            stackView.addArrangedSubview(field)
        }
        
        [titleLabel, stackView, doneButton].forEach {
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            // 제목
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 110),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            // StackView
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            // 버튼
            doneButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            doneButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            doneButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            doneButton.heightAnchor.constraint(equalToConstant: 50),
            doneButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    private func setupKeyboardHandling() {
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
            .subscribe(onNext: { [weak self] keyboardFrame in
                guard let self = self else { return }
                let keyboardHeight = keyboardFrame.height
                self.scrollView.contentInset.bottom = keyboardHeight + 20
            })
            .disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .subscribe(onNext: { [weak self] _ in
                self?.scrollView.contentInset.bottom = 0
            })
            .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        let input = viewModel.input
        let output = viewModel.output
        
        emailField.textField.rx.text.orEmpty
            .observe(on: MainScheduler.instance)
            .bind(to: input.emailInput)
            .disposed(by: disposeBag)
        
        passwordField.textField.rx.text.orEmpty
            .observe(on: MainScheduler.instance)
            .bind(to: input.passwordInput)
            .disposed(by: disposeBag)
        
        passwordCheckField.textField.rx.text.orEmpty
            .observe(on: MainScheduler.instance)
            .bind(to: input.passwordCheckInput)
            .disposed(by: disposeBag)
        
        nicknameField.textField.rx.text.orEmpty
            .observe(on: MainScheduler.instance)
            .bind(to: input.nicknameInput)
            .disposed(by: disposeBag)
        
        // 버튼 색상 변경 (비활성화 시)
        output.isSignUpEnabled
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isEnabled in
                guard let self = self else { return }
                self.doneButton.backgroundColor = isEnabled ? .purplishDarkBlue : .inactive
            })
            .disposed(by: disposeBag)
        
        doneButton.rx.action = input.doneAction
    }
}
