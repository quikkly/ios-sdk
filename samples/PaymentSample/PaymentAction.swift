//
//  PaymentAction.swift
//  Samples
//
//  Created by Julian Gruber on 15/01/2017.
//  Copyright © 2017 Quikkly Ltd. All rights reserved.
//

import UIKit
import Quikkly

class PaymentAction: Action {
    let keyWallet = "wallet"
    let keyAmount = "amount"
    
    var wallet:Int!
    var amount:Float!
    
    override var data: [String : Any]? {
        get {
            if let w = self.wallet, let a = self.amount {
                return [self.keyWallet:w,
                        self.keyAmount:a]
            }
            return [:]
        }
    }
    
    init(withWalletId wallet:Int, amount:Float) {
        super.init()
        
        self.wallet = wallet
        self.amount = amount
    }
    
    override func perform(withCompletion completion: @escaping (ActionResult) -> Void) {
        
        //This is where the actual payment (e.g. API call) would be implemented. But for simplicity we just display a hard coded completion screen.
        
        let vc = CompletionViewController(withWalletId:self.wallet, amount:self.amount)
        
        //Use the present method provided by the action class
        self.present(viewController: vc)
        
        completion(ActionResult(withState: .unavailable))
    }
}
