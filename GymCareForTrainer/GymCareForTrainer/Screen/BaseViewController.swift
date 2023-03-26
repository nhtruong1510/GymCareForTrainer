//
//  BaseViewController.swift
//  SchoolUp
//
//  Created by Nguyen Ha on 02/02/2023.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class BaseViewController: UIViewController {

    @IBOutlet weak var cutomNavi: TypeNavigator!

    override func viewDidLoad() {
//        self.navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
//        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func touchOut(type: TypeTapGesture = .keyboard) {
        var tap = UITapGestureRecognizer()
        switch type {
        case .keyboard:
            tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        case .dissMissView:
            tap = UITapGestureRecognizer(target: self, action: #selector(dismissScreen))
        }
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func nextScreen(ctrl: UIViewController) {
        self.navigationController?.pushViewController(ctrl, animated: true)
    }

    func backScreen() {
        self.navigationController?.popViewController(animated: true)
    }

    func backToRootScreen() {
        self.navigationController?.popToRootViewController(animated: true)
    }

    @objc func dismissScreen(completion: (() -> Void)? = nil) {
        self.dismiss(animated: true, completion: completion)
    }

    func showScreen(ctrl: UIViewController, fullScreen: Bool? = true) {
        if fullScreen == true {
            ctrl.modalPresentationStyle = .overCurrentContext
            ctrl.modalTransitionStyle = .crossDissolve
        } else {
            ctrl.modalTransitionStyle = .coverVertical
        }
        if tabBarController != nil {
            self.tabBarController?.present(ctrl, animated: true)
        } else {
            self.present(ctrl, animated: true)
        }
    }
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        guard let viewControllers = navigationController?.viewControllers else {return}
        if let vc = viewControllers.first(where: { $0.isKind(of: ofClass) }) {
            self.navigationController?.popToViewController(vc, animated: true)
        }
    }

    func playVideo(url: URL?, urlString: String?) {
        let videoURL = url != nil ? url! : URL(string: castToString(urlString))
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    func configNavigator() {

    }
}
