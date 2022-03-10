//
//  CombineVC.swift
//  Tinder
//
//  Created by Matheus Barbosa on 10/03/22.
//

import UIKit

class CombineVC: UIViewController {
    
    let perfilButton: UIButton = .iconMenu(named: "icone-perfil")
    let chatButton: UIButton = .iconMenu(named: "icone-chat")
    let logoButton: UIButton = .iconMenu(named: "icone-logo")
    
    let deslikeButton: UIButton = .iconFooter(named: "icone-deslike")
    let superLikeButton: UIButton = .iconFooter(named: "icone-superlike")
    let likeButton: UIButton = .iconFooter(named: "icone-like")
    
    var usuarios: [Usuario] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = UIColor.systemGroupedBackground
        self.adicionaHeader()
        self.adicionarFooter()
        self.buscaUsuario()
    }
    
    func buscaUsuario () {
        self.usuarios = UsuarioService.shared.buscaUsuarios()
        self.adiconarCards()
    }
}

extension CombineVC {
    
    func adicionaHeader() {
        let window = view.window?.windowScene?.keyWindow
        let top: CGFloat = window?.safeAreaInsets.top ?? 44
        
        let stackView = UIStackView(arrangedSubviews: [perfilButton, logoButton, chatButton])
        stackView.distribution = .equalCentering
        
        view.addSubview(stackView)
        stackView.preencher(top: view.topAnchor,
                            leading: view.leadingAnchor,
                            trailing: view.trailingAnchor,
                            bottom: nil,
                            padding: .init(top: top, left: 16, bottom: 0, right: 16))
    }
    
    func adicionarFooter() {
        let stackView = UIStackView(arrangedSubviews: [UIView() ,deslikeButton, superLikeButton, likeButton, UIView()])
        stackView.distribution = .equalCentering
        
        view.addSubview(stackView)
        stackView.preencher(top: nil,
                            leading: view.leadingAnchor,
                            trailing: view.trailingAnchor,
                            bottom: view.bottomAnchor,
                            padding: .init(top: 0, left: 16, bottom: 34, right: 16))
    }
}

extension CombineVC {
    func adiconarCards () {
        for usuario in usuarios{
            let card = CombineCardView()
            card.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 32, height: view.bounds.height * 0.7)
            
            card.center = view.center
            card.usuario = usuario
            card.tag = usuario.id
            
            let gesture = UIPanGestureRecognizer()
            gesture.addTarget(self, action: #selector(handleCard))
            
            card.addGestureRecognizer(gesture)
            
            view.insertSubview(card, at: 0)
        }
        
    }
}

extension CombineVC {
    @objc func handleCard (_ gesture: UIPanGestureRecognizer) {
        if let card = gesture.view as? CombineCardView {
            let point = gesture.translation(in: view)
           
            card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
            
            let rotateAngle = point.x / view.bounds.width * 0.4
            
            if point.x > 0 {
                card.likeImageView.alpha = rotateAngle * 5
                card.deslikeImageView.alpha = 0
            } else {
                card.likeImageView.alpha = 0
                card.deslikeImageView.alpha = rotateAngle * 5 * -1
            }
            
            card.transform = CGAffineTransform(rotationAngle: rotateAngle)
            
            if gesture.state == .ended {
                UIView.animate(withDuration: 0.2, animations: {
                    card.center = self.view.center
                    card.transform = .identity
                    
                    card.likeImageView.alpha = 0
                    card.deslikeImageView.alpha = 0
                })
                
            }
        }
    }
}
