//
//  ViewState.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 07/11/24.
//

import Foundation

// MARK: - View State
enum ViewState {
    case idle
    case loading
    case loaded
    case error(Error)
}
