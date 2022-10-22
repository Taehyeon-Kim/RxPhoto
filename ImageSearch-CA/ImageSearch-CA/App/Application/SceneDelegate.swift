//
//  SceneDelegate.swift
//  ImageSearch-CA
//
//  Created by taekki on 2022/10/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let respository = PhotoRepositoryImpl()
        let useCase = SearchPhotoUseCaseImpl(photoRepository: respository)
        let viewModel = SearchPhotoViewModel(searchPhotoUseCase: useCase)
        let viewController = SearchPhotoViewController(viewModel: viewModel)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}

