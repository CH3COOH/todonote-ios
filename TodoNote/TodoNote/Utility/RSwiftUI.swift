//
//  RSwiftUI.swift
//

import RswiftResources
import SwiftUI

extension ColorResource {
    var color: Color {
        Color(name)
    }
}

extension UIColor {
    var color: Color {
        Color(self)
    }
}

extension StringResource {
    var text: Text {
        Text(self)
    }
}

extension ImageResource {
    var image: Image {
        Image(name)
    }
}
