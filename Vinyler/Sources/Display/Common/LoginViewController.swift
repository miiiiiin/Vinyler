//
//  LoginViewController.swift
//  Vinyler
//
//  Created by Songkyung Min on 3/25/25.
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
        
    }
}
