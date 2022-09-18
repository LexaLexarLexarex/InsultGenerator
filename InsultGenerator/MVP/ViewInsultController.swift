//
//  ViewController.swift
//  InsultGenerator
//
//  Created by lexar on 15.09.2022.
//

import UIKit

protocol ViewInsult: AnyObject {
    func drawInsult(insult: Insult)
    func failureResponce(message: String)
    func initDraw()
}

class ViewInsultController: UIViewController, ViewInsult {
    var presenter: PresenterInsult!
    private lazy var generateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 12
        button.setTitle("JUST DO InsulT", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.backgroundColor = UIColor.white
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 2.0
        button.layer.shadowRadius = 2
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var ticket: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemBlue // UIColor(red: 135, green: 206, blue: 255, alpha: 20)
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    func shadowToView(view: UIView) {
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowOpacity = 0.6
        view.layer.shadowRadius = 3.0
        view.layer.shadowColor = UIColor.darkGray.cgColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PresenterInsultImpl(view: self)
    }

    func drawInsult(insult: Insult) {
        view.addSubview(ticket)

        ticket.transform = ticket.transform.rotated(by: -.pi / 2)

        ticket.text = insult.insult
        ticket.frame = CGRect(x: view.frame.width,
                              y: view.frame.width,
                              width: view.frame.width - view.frame.width / 4,
                              height: view.frame.height - view.frame.height * 3 / 4)
        UIView.animate(withDuration: 0.7,
                       delay: 0.8,
                       animations: {
                           self.ticket.transform = self.ticket.transform.rotated(by: .pi / 2)
                           self.ticket.frame = CGRect(x: self.view.frame.width / 8,
                                                      y: self.view.frame.height / 8,
                                                      width: self.view.frame.width - self.view.frame.width / 4,
                                                      height: self.view.frame.height - self.view.frame.height * 3 / 4)
                       })
    }

    func failureResponce(message: String) {
        view.backgroundColor = .blue
        ticket.text = message
        ticket.frame = CGRect(x: view.frame.width / 2,
                              y: view.frame.height / 4,
                              width: 0,
                              height: 0)
        ticket.backgroundColor = .red
        UIView.animate(withDuration: 0.7,
                       delay: 0.8,
                       animations: {
                           self.ticket.frame = CGRect(x: self.view.frame.width / 8,
                                                      y: self.view.frame.height / 8,
                                                      width: self.view.frame.width - self.view.frame.width / 4,
                                                      height: self.view.frame.height - self.view.frame.height * 3 / 4)
                       })
    }

    func initDraw() {
        view.backgroundColor = .white
        buttonSetup()
    }

    private func buttonSetup() {
        view.addSubview(generateButton)
        generateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height / 6).isActive = true
        generateButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height / 4).isActive = true
        generateButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width / 4).isActive = true
        generateButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -view.frame.width / 4).isActive = true
    }

    @objc private func buttonAction() {
        UIView.animate(withDuration: 0.7,
                       animations: {
                           self.ticket.transform = self.ticket.transform.rotated(by: -.pi / 2)
                           self.ticket.frame = CGRect(x: -self.view.frame.width,
                                                      y: -self.view.frame.width,
                                                      width: self.view.frame.width - self.view.frame.width / 4,
                                                      height: self.view.frame.height - self.view.frame.height * 3 / 4)
                       })
        ticket.transform = ticket.transform.rotated(by: .pi / 2)
        presenter.showInsult()
    }
}
