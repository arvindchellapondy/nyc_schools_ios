//
//  Displayable.swift
//  20210730-ArvindChellapondy-NYCSchools
//
//  Created by Arvind Chellapondy on 7/31/21.
//

import Foundation

// displayable protocol to hold school detail items
protocol Displayable {
    var listItems: [(label: String, value: String?)] { get }
}
