//
//  ViewController.swift
//  TestingHero
//
//  Created by Miguel Revetria on 26/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import UIKit
import Opera
import RxSwift
import XLSwiftKit

class ViewController: UIViewController {

    fileprivate let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        MarvelManager.shared.events()
            .subscribe(
                onNext: { data in
                    debugPrint(data)
                },
                onError: { [weak self] error in
                    self?.showError("Oops!", message: error.localizedDescription)
                }
            )
            .addDisposableTo(disposeBag)
    }

}
