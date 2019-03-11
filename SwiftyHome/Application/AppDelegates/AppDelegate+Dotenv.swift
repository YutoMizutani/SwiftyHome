//
//  AppDelegate+Dotenv.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/17.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import Foundation

extension AppDelegate {
    func configureEnvfile() {
        guard let path = Bundle.main.path(forResource: ".env", ofType: nil) else {
            fatalError(".env file not found")
        }

        let url = URL(fileURLWithPath: path)
        guard
            let data = try? Data(contentsOf: url),
            let readAll = String(data: data, encoding: .utf8)
            else { return }

        let readLines = readAll.replacingOccurrences(of: "\"", with: "")
            .replacingOccurrences(of: "'", with: "")
            .components(separatedBy: "\n")

        for readLine in readLines {
            let keyValue = readLine.components(separatedBy: "=")
            if keyValue.count == 2 {
                setenv(keyValue[0], keyValue[1], 1)
            }
        }
    }
}
