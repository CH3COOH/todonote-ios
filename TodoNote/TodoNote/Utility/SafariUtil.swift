//
//  SafariUtil.swift
//
//  Created by KENJIWADA on 2022/03/21.
//  Copyright © 2022 KENJI WADA. All rights reserved.
//

import SafariServices
import UIKit

struct SafariUtil {
    static func show(from viewController: UIViewController?, url: URL, page: FAPage?) {
        let vc = SFSafariViewController(url: url)
        vc.preferredControlTintColor = R.color.accentColor()
        viewController?.present(vc, animated: true) {
            page?.send()
        }
    }
}
