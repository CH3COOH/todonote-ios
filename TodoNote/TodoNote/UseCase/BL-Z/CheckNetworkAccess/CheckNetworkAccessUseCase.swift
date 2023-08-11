//
//  CheckNetworkAccessUseCase.swift
//
//  Created by KENJIWADA on 2023/01/03.
//  Copyright © 2023 KENJI WADA. All rights reserved.
//

import Foundation
import Reachability

class CheckNetworkAccessUseCase: UseCaseProctol {
    func execute(_: CheckNetworkAccessUseCaseInput) async -> CheckNetworkAccessUseCaseResult {
        return await checkReachability()
    }

    private func checkReachability() async -> CheckNetworkAccessUseCaseResult {
        do {
            let reachability = try Reachability()
            switch reachability.connection {
            case .unavailable:
                return .unavailable
            default:
                return await checkNetworkAccess()
            }
        } catch {
            // Reachability が例外を吐いた場合は次へ進む
            return await checkNetworkAccess()
        }
    }

    private func checkNetworkAccess() async -> CheckNetworkAccessUseCaseResult {
        // TODO: 自分のサイトにアクセスして通信可能かどうか調べている
        do {
            var request = URLRequest(url: URL(string: "https://ch3cooh.net/success.html")!)
            request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            request.timeoutInterval = 10
            let (data, response) = try await URLSession.shared.data(for: request)
            if
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let dataString = String(data: data, encoding: .utf8),
                dataString == "Success"
            {
                return .connected
            } else {
                fatalError("ネットワークのアクセス経路に異常あり")
            }
        } catch {
            return .unavailable
        }
    }
}
