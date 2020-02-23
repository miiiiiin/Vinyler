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
    let introduceBlock = CustomTextView(forAutoLayout: ())
    let openSourceBlock = CustomTextView(forAutoLayout: ())
    let resourcesBlock = CustomTextView(forAutoLayout: ())
    let thanksBlock = CustomTextView(forAutoLayout: ())
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBtn.tintColor = .black
        
        introduceBlock.bodyLbl.tapped(oneOf: [.inspiredFrom])
            .subscribe(onNext: { _ in
                guard let url = URL(string: "https://apps.apple.com/us/developer/ivan-blagajic/id1433818197") else { return }
                UIApplication.shared.open(url, options: [:])
            }).disposed(by: disposeBag)
        
        let tapHere = openSourceBlock.bodyLbl.tapped(oneOf: [.githubLink])
            .map { _ in
                return URL(string: "https://github.com/miiiiiin/Vinyler/blob/master/Podfile")}
        
        let tapResource = resourcesBlock.bodyLbl.tapped(oneOf: [.flatIcon, .icons8])
            .map { tapped -> URL? in
                switch tapped {
                case .flatIcon:
                    return Resources.flatIcon.url
                case .icons8:
                    return Resources.icons8.url
                default:
                    return nil
                }
        }
        
        Observable.merge(tapResource, tapHere)
            .subscribe(onNext: { url in
                guard let url = url else { return }
                UIApplication.shared.open(url, options: [:])
            }).disposed(by: disposeBag)
        
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
            [introduceBlock, openSourceBlock, resourcesBlock, thanksBlock].forEach(stackView.addArrangedSubview)
            
            backBtn.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 33).isActive = true
            backBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 35).isActive = true
            stackView.topAnchor.constraint(equalTo: backBtn.bottomAnchor, constant: 44).isActive = true
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 44).isActive = true
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22).isActive = true
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -44).isActive = true
            
            self.view = root
            
            introduceBlock.titleLbl.text = .introduce
            let introduceBody = String(format: .introduceDetail, String.inspiredFrom)
            introduceBlock.bodyLbl.set(bodyText: introduceBody, underlineParts: [.inspiredFrom])
        
            openSourceBlock.titleLbl.text = .openSource
            let openSourceBody = String(format: .openSourceDetail, String.discogs, String.githubLink)
            openSourceBlock.bodyLbl.set(bodyText: openSourceBody, underlineParts: [.githubLink])
        
            resourcesBlock.titleLbl.text = .resource
            let resourceBody = String(format: .resourceDetail, String.flatIcon, String.icons8)
            resourcesBlock.bodyLbl.set(bodyText: resourceBody, underlineParts: [.flatIcon, .icons8])
        
            thanksBlock.titleLbl.text = .thanks
            let thanksBody = String(format: .thanksDetail)
            thanksBlock.bodyLbl.set(bodyText: thanksBody)
    }
}

enum Resources {
    case flatIcon
    case icons8
    
    var url: URL? {
        switch self {
        case .flatIcon:
            return URL(string: "https://www.flaticon.com/")
        case .icons8:
            return URL(string: "https://icons8.com/")
        }
    }
}
