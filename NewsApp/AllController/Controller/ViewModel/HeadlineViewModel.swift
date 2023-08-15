//
//  HeadlineViewModel.swift
//  NewsApp
//
//  Created by rahulverma on 14/8/23.
//

import Foundation

extension HeadlineViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}

final class HeadlineViewModel {

    var products = NSMutableArray()
    var eventHandler: ((_ event: Event) -> Void)?

    func fetchProducts(urlStr : String, result: @escaping ((String, DataError?)->())) {
        self.eventHandler?(.loading)
        APIManager.shared.request(urlStr:urlStr,
            modelType: HeadlineJSONModel.self,
                                  type: HTTPMethods.get.rawValue) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let products):
                    self.products.add(products)
                    result("Success",nil)
                case .failure(let error):
                    result("Fail", error)
                }
            }
    }

}

