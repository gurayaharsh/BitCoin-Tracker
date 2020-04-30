//
//  CoinData.swift
//  ByteCoin
//
//  Created by Harsh  on 2020-04-30.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Decodable {
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
