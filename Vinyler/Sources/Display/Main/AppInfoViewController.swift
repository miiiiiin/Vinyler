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
    private let dispoeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        introduceBlock.bodyLbl.didTap(oneOf: [.discogs])
            .subscribe(onNext: { _ in
                guard let url = URL(string: "https://www.discogs.com") else { return }
                UIApplication.shared.open(url, options: [:])
            }).disposed(by: bag)
        
        openSourceBlock.bodyLabel.didTap(oneOf: [.email])
            .flatMap { [weak self] _ -> Observable<MFMailComposeResult> in
                guard MFMailComposeViewController.canSendMail() else {
                    return Observable.just(.failed)
                }
                let mailComposeViewController = MFMailComposeViewController()
                mailComposeViewController.setToRecipients([.email])
                self?.present(mailComposeViewController, animated: true)
                return mailComposeViewController.rx.didFinishWithResult.asObservable()
            }.subscribe(onNext: { [weak self] result in
                switch result {
                case .cancelled,
                     .failed:
                    self?.dismiss(animated: true) { [weak self] in
                        self?.showSendMailErrorAlert()
                    }
                case .saved,
                     .sent:
                    self?.dismiss(animated: true) { [weak self] in
                        self?.showSendMailSuccessAlert()
                    }
                }
            }).disposed(by: bag)
        
        let tapGithub = openSourceGroup.bodyLbl.didTap(oneOf: [.github])
            .map { _ in return URL(string: "https://github.com/miiiiiin/Vinyler") }
        
        backBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: bag)
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
        
        [backButton, stackView].forEach(contentView.addSubview)
            [greetingLabel, thanksGroup, privacyGroup, instructionsGroup, openSourceGroup, creditsGroup].forEach(stackView.addArrangedSubview)
            
            backButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 33).isActive = true
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 35).isActive = true
            stackView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 44).isActive = true
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 44).isActive = true
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22).isActive = true
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -44).isActive = true
            
            self.view = root
            
            greetingLabel.text = .welcome
            thanksGroup.titleLabel.text = .thanks
            let thanksBody = String(format: .about, String.discogs)
            thanksGroup.bodyLabel.set(bodyText: thanksBody, underlineParts: [.discogs])
            privacyGroup.titleLabel.text = .privacyTitle
            let privacyBody = String(format: .privacyMessage, String.privacyMessageHighlighted, String.email)
            privacyGroup.bodyLabel.set(bodyText: privacyBody, boldPart: .privacyMessageHighlighted, underlineParts: [.email])
            instructionsGroup.titleLabel.text = .instructionsTitle
            let instructionsBody = String(format: .instructionsMessage, String.catalogNumber, String.catalogNumber)
            instructionsGroup.bodyLabel.set(bodyText: instructionsBody, underlineParts: [.catalogNumber])
            openSourceGroup.titleLabel.text = .openSourceTitle
            let openSourceBody = String(format: .openSourceMessage, String.github)
            openSourceGroup.bodyLabel.set(bodyText: openSourceBody, underlineParts: [.github])
            creditsGroup.titleLabel.text = .credits
            let creditsBody = String(format: .vinylIcon + "\n" + .cameraIcon + "\n" + .appIcon, String.freepik, String.smashicons, String.alexanderKahlkopf)
            creditsGroup.bodyLabel.set(bodyText: creditsBody, underlineParts: [.freepik, .smashicons, .alexanderKahlkopf])
    }
}
