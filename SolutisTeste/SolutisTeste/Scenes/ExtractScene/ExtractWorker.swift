//
//  ExtractWorker.swift
//  SolutisTeste
//
//  Created by Virtual Machine on 26/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class ExtractWorker
{
    
    var request = ServiceRequest()
    
    func doSomeWork()
    {
    }
    
    func extractAPIRequest() {
        request.performStatementRequest(urlString: url, userToken: <#T##String#>, completion: <#T##(Result<[Statement], Error>) -> Void#>)
    }
    
}
