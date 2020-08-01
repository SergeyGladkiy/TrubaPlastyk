//
//  ViewModelMainScreen.swift
//  TrubaPND77
//
//  Created by Serg on 29.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class ViewModelMainScreen {
    private let model: ModelMainScreenProtocol
    var state: Observable<ViewModelMainScreenState>
    private var dictionaryOfItems = [Int: ItemMainScreen]()
    
    init(state: Observable<ViewModelMainScreenState>, model: ModelMainScreenProtocol) {
        self.state = state
        self.model = model
        twoWayDataBinding()
    }
    
    private func twoWayDataBinding() {
        model.errorOccure.bind { [weak self] (error) in
            //MARK: to understand what the error is
            print(error)
            self?.state.observable = .errorOccure(unknownError)
        }
        
        model.staticInfо.bind { [weak self] (dict) in
            if dict.isEmpty { return }
            self?.dictionaryOfItems = dict
            self?.state.observable = .readyToShowItems
        }
    }
}

extension ViewModelMainScreen: ViewModelMainScreenProtocol {
    func generateItems() {
        model.processingStaticInformation()
    }
    
    func numberOfRows() -> Int {
        return dictionaryOfItems.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CellViewModelMainScreen? {
        let data = dictionaryOfItems[indexPath.row]
        guard let model = data else {
            state.observable = .errorOccure(unknownError)
            return nil
        }
        return CellViewModelMainScreen(model: model)
    }
}
