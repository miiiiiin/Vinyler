//
//  AppInfoViewController.swift
//  Vinyler
//
//  Created by Min on 2020/01/25.
//  Copyright © 2020 songkyung min. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

class AppInfoViewController: UIViewController {
    
    let backBtn = UIButton.back
    let greetingLbl = UILabel.block
    let introduceBlock = CustomTextView(forAutoLayout: ())
    let openSourceBlock = CustomTextView(forAutoLayout: ())
    let resourcesBlock = CustomTextView(forAutoLayout: ())
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBtn.tintColor = .black
//        introduceBlock.bodyLbl.didTap(oneOf: [.discogs])
//            .subscribe(onNext: { _ in
//                guard let url = URL(string: "https://www.discogs.com") else { return }
//                UIApplication.shared.open(url, options: [:])
//            }).disposed(by: disposeBag)
//
//        openSourceBlock.bodyLbl.didTap(oneOf: [.email])
//            .flatMap { [weak self] _ -> Observable<MFMailComposeResult> in
//                guard MFMailComposeViewController.canSendMail() else {
//                    return Observable.just(.failed)
//                }
//                let mailComposeViewController = MFMailComposeViewController()
//                mailComposeViewController.setToRecipients([.email])
//                self?.present(mailComposeViewController, animated: true)
//                return mailComposeViewController.rx.didFinishWithResult.asObservable()
//            }.subscribe(onNext: { [weak self] result in
//                switch result {
//                case .cancelled,
//                     .failed:
//                    self?.dismiss(animated: true) { [weak self] in
//                        self?.showSendMailErrorAlert()
//                    }
//                case .saved,
//                     .sent:
//                    self?.dismiss(animated: true) { [weak self] in
//                        self?.showSendMailSuccessAlert()
//                    }
//                }
//            }).disposed(by: disposeBag)
//
//        let tapGithub = (openSourceBlock.bodyLbl.didTap(oneOf: [.github]) as AnyObject)
//            .map { _ in return URL(string: "https://github.com/miiiiiin/Vinyler") }
//
        backBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
    
    override func loadView() {
        let root = UIScrollView(frame: UIScreen.main.bounds)
        root.backgroundColor = .white
        let contentView = UIView(forAutoLayout: ())
        let stackView = UIStackView(forAutoLayout: ())
        stackView.axis = .vertical
        stackView.spacing = 33
        root.addSubview(contentView)
        contentView.pinToSuperview()
        contentView.widthAnchor.constraint(equalTo: root.widthAnchor).isActive = true
        
        [backBtn, stackView].forEach(contentView.addSubview)
            [greetingLbl, introduceBlock, openSourceBlock, resourcesBlock].forEach(stackView.addArrangedSubview)
            
            backBtn.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 33).isActive = true
            backBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 35).isActive = true
            stackView.topAnchor.constraint(equalTo: backBtn.bottomAnchor, constant: 44).isActive = true
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 44).isActive = true
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22).isActive = true
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -44).isActive = true
            
            self.view = root
            
//            greetingLbl.text = .welcome
            introduceBlock.titleLbl.text = .introduce
            let thanksBody = String(format: .introduceDetail, String.discogs)
//            introduceBlock.bodyLbl.set(bodyText: thanksBody, underlineParts: [.discogs])
            openSourceBlock.titleLbl.text = .openSource
            let openSourceBody = String(format: .privacyMessage, String.privacyMessageHighlighted, String.email)
        
            resourcesBlock.titleLbl.text = .resource
            let resourceBody = String(format: .privacyMessage, String.privacyMessageHighlighted, String.email)
        
    }
}
