//
//  ConfigurableCell.swift
//
//  Protocol for configurable cells to take in a generic model and configure cell attributes.
//
//  Created by Max Rogers on 12/2/17.
//

import Foundation

protocol ConfigurableCell {
    associatedtype T
    var model: T? { get set }
    func configure(with model : T)
}

