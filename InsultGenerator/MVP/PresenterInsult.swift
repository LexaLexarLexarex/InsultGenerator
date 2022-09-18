//
//  Presenter.swift
//  InsultGenerator
//
//  Created by lexar on 15.09.2022.
//

import Alamofire
import Foundation

protocol PresenterInsult {
    init(view: ViewInsult)

    func showInsult()
}

class PresenterInsultImpl: PresenterInsult {
    unowned let view: ViewInsult

    required init(view: ViewInsult) {
        self.view = view
        self.view.initDraw()
    }

    func showInsult() {
        AF.request("https://evilinsult.com/generate_insult.php?lang=en&type=json")
            .validate()
            .responseDecodable(of: Insult.self) { response in
                guard let insult = response.value else {
                    return
                }
                switch response.result {
                case .failure:
                    self.view.failureResponce(message: "Turn on Internet, shortdickman")
                case .success:
                    self.view.drawInsult(insult: insult)
                }
            }

        // Этим действием избавился от проблемы кэширования(результат одного и того же запроса не менялся)
        URLCache.shared.removeAllCachedResponses()
    }
}
