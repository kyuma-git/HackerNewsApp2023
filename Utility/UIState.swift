//
//  UIState.swift
//  Utility
//
//  Created by Kyuma Morita on 2023/12/12.
//

/// A format to standardize the display state management and prevent any oversights in error handling
public enum UIState<ViewData> {
    case initial
    case loading
    case error
    case empty
    case loaded(ViewData)
}
