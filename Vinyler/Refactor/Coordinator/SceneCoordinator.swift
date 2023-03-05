//
//  SceneCoordinator.swift
//  Vinyler
//
//  Created by Songkyung Min on 2023/03/05.
//  Copyright © 2023 songkyung min. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SceneCoordinator: NSObject, SceneCoordinatorType {
    
    static var shared: SceneCoordinator!
    
    fileprivate var window: UIWindow
    public var currentViewController: UIViewController {
        didSet {
            currentViewController.navigationController?.delegate = self
            currentViewController.tabBarController?.delegate = self
        }
    }
    
    required init(window: UIWindow) {
        self.window = window
        currentViewController = window.rootViewController ?? UINavigationController()
    }
    
    static func actualViewController(for viewController: UIViewController) -> UIViewController {
        var controller = viewController
        if let tabBarController = controller as? UITabBarController {
            guard let selectedViewController = tabBarController.selectedViewController else {
                return tabBarController
            }
            controller = selectedViewController
            
            return actualViewController(for: controller)
        }
        
        if let navigationController = viewController as? UINavigationController {
            controller = navigationController.viewControllers.first!
            
            return actualViewController(for: controller)
        }
        return controller
    }
    
    @discardableResult
    func transition(to scene: TargetScene) -> Observable<Void> {
        let subject = PublishSubject<Void>()
        
        switch scene.transition {
        case let .tabBar(tabBarController):
            guard let selectedViewController = tabBarController.selectedViewController else {
                fatalError("Selected view controller doesn't exists")
            }
            currentViewController = SceneCoordinator.actualViewController(for: selectedViewController)
            window.rootViewController = tabBarController
            
        case let .root(viewController):
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
            
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.navigationBar.isHidden = true
            window.rootViewController = navigationController
            subject.onCompleted()
            
        case let .push(viewController):
            guard let navigationController = currentViewController.navigationController else {
                fatalError("Can't push a view controller without a current navigation controller")
            }
            _ = navigationController.rx.delegate
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                .ignoreAll()
                .bind(to: subject)
            
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
            navigationController.pushViewController(currentViewController, animated: true)
            
        case let .present(viewController):
            viewController.modalPresentationStyle = .fullScreen
            currentViewController.present(viewController, animated: true) {
                subject.onCompleted()
            }
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
            currentViewController.navigationController?.navigationBar.isHidden = true
            
        case let .alert(viewController):
            currentViewController.present(viewController, animated: true) {
                subject.onCompleted()
            }
        }
        
        return subject
            .asObservable()
            .take(1)
    }
    
    
    @discardableResult
    func handleTabBar(show: Bool) -> Observable<Void> {
        let subject = PublishSubject<Void>()
        
        let returnValue = subject
            .asObservable()
            .take(1)
        
        guard let tabBar = currentViewController.tabBarController?.tabBar else { return returnValue }
        tabBar.isHidden = show ? false : true
        subject.onCompleted()
        
        return returnValue
    }
    
    @discardableResult
    func popToScene(to scene: TargetScene, animated: Bool) -> Completable {
        return Completable.create { [unowned self] completable in
            //completable을 직접 생성하는 형식으로 구현
            switch scene.transition {
                
            case .root(_):
                break
            case let .push(viewController):
                guard let navigationController = currentViewController.navigationController else {
                    fatalError("Can't push a view controller without a current navigation controller")
                }
                
                navigationController.viewControllers.forEach { vc in
                    if viewController.className == vc.className {
                        currentViewController = SceneCoordinator.actualViewController(for: vc)
                        navigationController.popToViewController(vc, animated: true)
                        return
                    }
                }
                
                completable(.completed)
                
            case .present(_):
                break
            case .alert(_):
                break
            case .tabBar(_):
                break
            }
            
            return Disposables.create()
        }
    }
    
    @discardableResult
    func dismiss(animated: Bool) -> Completable {
        
        return Completable.create { [unowned self] completable in
            //completable을 직접 생성하는 형식으로 구현
            if let presentingViewController = currentViewController.presentingViewController {
                currentViewController.dismiss(animated: animated) {
                    currentViewController = SceneCoordinator.actualViewController(for: presentingViewController)
                    completable(.completed)
                }
            }
            return Disposables.create()
        }
    }
    
    @discardableResult
    func dismissAll(animated: Bool) -> Completable {
        return Completable.create { [unowned self] completable in
            //completable을 직접 생성하는 형식으로 구현
            if let presentingViewController = currentViewController.presentingViewController?.presentingViewController {
                presentingViewController.dismiss(animated: animated) {
                    currentViewController = SceneCoordinator.actualViewController(for: presentingViewController)
                    completable(.completed)
                }
            }
            
            return Disposables.create()
        }
    }
    
    @discardableResult
    func pop(animated: Bool) -> Observable<Void> {
        let subject = PublishSubject<Void>()
        
        if let navigationController = currentViewController.navigationController {
            _ = navigationController.rx.delegate
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:willShow:animated:)))
                .ignoreAll()
                .bind(to: subject)
            
            guard navigationController.popViewController(animated: animated) != nil else {
                fatalError("can't navigate back from \(currentViewController)")
            }
            
            currentViewController = SceneCoordinator.actualViewController(for: navigationController.viewControllers.last!)
            subject.onCompleted()
        } else {
            fatalError("Not a modal, no navigation controller: can't navigate back from \(currentViewController)")
        }
        
        return subject
            .asObservable()
            .take(1)
    }
}

// MARK: - UINavigationControllerDelegate -

extension SceneCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        currentViewController = SceneCoordinator.actualViewController(for: viewController)
    }
}

// MARK: - UITabBarControllerDelegate

extension SceneCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController)  {
        currentViewController = SceneCoordinator.actualViewController(for: viewController)
    }
}
