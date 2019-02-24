//
//  GoHomeAPI.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/17.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import Alamofire
import RxSwift

protocol GoHomeAPI {
    associatedtype ResponseType: Decodable

    var path: String { get }
    var method: HTTPMethod { get }
}

extension GoHomeAPI {
    /// Success handler
    private typealias SuccessHandler<T> = (_ response: ResponseType) -> Void
    /// Failure handler
    private typealias FailureHandler = (_ error: Error) -> Void

    private func request(_ parameters: Parameters?, success: SuccessHandler<ResponseType>?, failure: FailureHandler?) {
        let url = ProcessInfo.processInfo.environment["GOHOME_API_ENDPOINT"]! + path

        print("API CONNECTION OCCURRED: URL=\(url),\tmethod=\(method.rawValue),\tparameters=\(parameters?.description ?? "nil")")

        Alamofire.request(url,
                          method: method,
                          parameters: parameters,
                          encoding: URLEncoding.default)
            .responseData {
                switch $0.result {
                case .success:
                    guard let data = $0.data else { return }

                    print("RECEIVED JSON: \(String(data: data, encoding: .utf8) ?? "")")

                    let decoder: JSONDecoder = JSONDecoder()
                    guard let response: ResponseType = try? decoder.decode(ResponseType.self, from: data) else { return }
                    success?(response)
                case .failure(let error):
                    failure?(error)
                }
            }
    }

    func _request(_ parameters: Parameters? = nil) -> Single<ResponseType> {
        return Single.create { single -> Disposable in
            let success: SuccessHandler<ResponseType> = { single(.success($0)) }
            let failure: FailureHandler = { single(.error($0)) }
            self.request(parameters, success: success, failure: failure)
            return Disposables.create()
        }
        .subscribeOn(SerialDispatchQueueScheduler(qos: .default))
        .observeOn(MainScheduler.asyncInstance)
    }
}
