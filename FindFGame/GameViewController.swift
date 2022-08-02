//
//  ViewController.swift
//  FindFGame
//
//  Created by Мария Газизова on 17.07.2022.
//

import UIKit

class GameViewController: UIViewController {
    
    private var shadowView: UIView?
    private var safeArea: UILayoutGuide?
    private var titleLabel: UILabel?
    private var fLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        safeArea = view.layoutMarginsGuide
        
        configureView()
        configureFLabel()
        configureShadowView()
        configureTitleLabel()
        setConstraints()
    }
}

extension GameViewController {
    private func configureView() {
        view.backgroundColor = .white
    }
    
    private func configureFLabel() {
        fLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        
        guard let fLabel = fLabel else { return }
        fLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 30)
        fLabel.text = "f"
        fLabel.textColor = .red

        self.view.addSubview(fLabel)
    }
    
    private func configureShadowView() {
        shadowView = UIView(frame: view.frame)
        
        guard let shadowView = shadowView else { return }
        shadowView.backgroundColor = .darkGray
        
        self.view.addSubview(shadowView)
    }
    
    private func configureTitleLabel() {
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        
        guard let titleLabel = titleLabel else { return }
        titleLabel.text = "Find f if you can"
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 30)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .lightGray
    
        self.view.addSubview(titleLabel)
    }
    
    private func configureElementsWhenWin() {
        titleLabel?.text = "YOU ARE WIN!"
        titleLabel?.textColor = .darkGray
        titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 50)
        
        shadowView?.backgroundColor = .clear
    }
    
    private func setConstraints() {
        guard let safeArea = safeArea else { return }

        shadowView?.translatesAutoresizingMaskIntoConstraints = false
        shadowView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        shadowView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        shadowView?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        shadowView?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
        titleLabel?.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        
        let width = safeArea.layoutFrame.width * CGFloat.random(in: 0...1)
        let height = safeArea.layoutFrame.height * CGFloat.random(in: 0...1)
        fLabel?.translatesAutoresizingMaskIntoConstraints = false
        fLabel?.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: height).isActive = true
        fLabel?.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: width).isActive = true
    }
}

extension GameViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let shadowView = shadowView else { return }
        titleLabel?.isHidden = true
        for touch in touches {
            let magnifier = Circle(withCenter: touch.location(in: view), andRadius: 50)
            magnifier.display(onView: shadowView)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let shadowView = shadowView else { return }
        
        for touch in touches {
            let magnifier = Circle(withCenter: touch.location(in: view), andRadius: 50)
            magnifier.display(onView: shadowView)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let currentPossiton = touch.location(in: view)
            let distanceX = abs(currentPossiton.x - fLabel!.frame.midX)
            let distanceY = abs(currentPossiton.y - fLabel!.frame.midY)
            
            if distanceX <= CGFloat(30) && distanceY <= CGFloat(30) {
                configureElementsWhenWin()
            }
            
            titleLabel?.isHidden = false
        }
    }
}
