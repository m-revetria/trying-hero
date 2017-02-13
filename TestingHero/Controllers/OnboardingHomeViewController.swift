//
//  OnboardingHomeViewController.swift
//  TestingHero
//
//  Created by Miguel Revetria on 10/2/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Hero
import UIKit

class OnboardingHomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 212
        tableView.register(R.nib.loadingCellTableViewCell)
    }

    @IBAction func backButtonDidTouch(_ sender: Any) {
        _ = navigationController?.popToRootViewController(animated: true)
    }

}

extension OnboardingHomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.loadingCell)
        cell.heroModifiers = [.principleDefaultAnimationCurve, .delay(1 + 0.1 * Double(indexPath.row)), .fade, .translate(x: 0, y: 200, z: 0)]
        return cell
    }

}
