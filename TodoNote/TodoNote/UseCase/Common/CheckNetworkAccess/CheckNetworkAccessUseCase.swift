//
//  CheckNetworkAccessUseCase.swift
//
//  Created by KENJIWADA on 2023/01/03.
//  Copyright © 2023 KENJI WADA. All rights reserved.
//

import Foundation
import Reachability

/// BL-Z03 ネットワーク接続状態のチェック
class CheckNetworkAccessUseCase: UseCaseProtocol {
    private let reachabilityProvider: ReachabilityProviderProtocol

    init(reachabilityProvider: ReachabilityProviderProtocol = ReachabilityProvider()) {
        self.reachabilityProvider = reachabilityProvider
    }

    func execute(_: CheckNetworkAccessUseCaseInput) async -> CheckNetworkAccessUseCaseResult {
        return await checkReachability()
    }

    private func checkReachability() async -> CheckNetworkAccessUseCaseResult {
        do {
            let isConnected = try reachabilityProvider.isConnected()
            if isConnected {
                return await checkNetworkAccess()
            } else {
                return .unavailable
            }
        } catch {
            // Reachability が例外を吐いた場合は次のステップへ進む
            print("Error with Reachability: \(error)")
            return await checkNetworkAccess()
        }
    }

    /// 自分のサイトへアクセスして、正しい文言が得られるか調べる
    private func checkNetworkAccess() async -> CheckNetworkAccessUseCaseResult {
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
                // ネットワークのアクセス経路に異常がある
                throw AppError.invalidContent
            }
        } catch {
            return .unavailable
        }
    }
}
