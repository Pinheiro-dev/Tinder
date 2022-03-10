//
//  CombineCardView.swift
//  Tinder
//
//  Created by Matheus Barbosa on 10/03/22.
//

import UIKit

class CombineCardView: UIView {
    
    var usuario: Usuario? {
        didSet {
            if let usuario = usuario {
                fotoImageView.image = UIImage.init(named: usuario.foto)
                nomeLabel.text = usuario.nome
                idadeLabel.text = String(usuario.idade)
                fraseLabel.text = usuario.frase
            }
        }
    }
    
    let fotoImageView: UIImageView = .fotoImageView()
    
    let nomeLabel: UILabel = .textBoldLabel(32, textColor: .white)
    let idadeLabel: UILabel = .textLabel(28, textColor: .white)
    let fraseLabel: UILabel = .textLabel(18, textColor: .white, numberOfLines: 2)
    
    let deslikeImageView: UIImageView = .iconCard(named: "card-deslike")
    let likeImageView: UIImageView = .iconCard(named: "card-like")
    
    lazy var nomeIdadeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nomeLabel, idadeLabel, UIView()])
        stackView.spacing = 12
        
        return stackView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nomeIdadeStackView, fraseLabel])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        return stackView
    }()
    
   override init(frame: CGRect) {
       super.init(frame: frame)
       
       layer.borderWidth = 0.3
       layer.borderColor = UIColor.lightGray.cgColor
       layer.cornerRadius = 8
       clipsToBounds = true
    
       nomeLabel.adiconaShadow()
       idadeLabel.adiconaShadow()
       fraseLabel.adiconaShadow()
       setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setLayout() {
        addSubview(fotoImageView)
        addSubview(deslikeImageView)
        addSubview(likeImageView)
        addSubview(stackView)
        
        fotoImageView.preencherSuperview()
        
        deslikeImageView.preencher(top: topAnchor, leading: nil, trailing: trailingAnchor, bottom: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 20))
        
        likeImageView.preencher(top: topAnchor, leading: leadingAnchor, trailing: nil, bottom: nil, padding: .init(top: 20, left: 20, bottom: 0, right: 0))

        stackView.preencher(top: nil,
                            leading: leadingAnchor,
                            trailing: trailingAnchor,
                            bottom: bottomAnchor,
                            padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        
    }
    
}
