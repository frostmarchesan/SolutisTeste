//
//  StatementJsonResponse.swift
//  SolutisTeste
//
//  Created by Virtual Machine on 19/10/21.
//

import Foundation

struct StatementJsonResponse: Codable {
    let data: Date
    let descricao: String
    let valor: Double
}
