//
//  SendBitcoinViewModel.swift
//  Vajra Wallet
//
//  Created by Rahul Roy on 12/11/23.
//

import Foundation
import LDKNode
import UIKit

class SendBitcoinViewModel {
    let ldkNode = LDKNodeManager.shared
    func sendBitcoin(amount: UInt64) -> Txid? {
        do {
            return try ldkNode.sendOnchain(address: UIPasteboard.general.string ?? "", amount: amount)
        } catch {
            return nil
        }
    }
    
    func sendBitcoinOnChain(address: String, amount: UInt64) -> Txid? {
        do {
            return try ldkNode.sendOnchain(address: address, amount: amount)
        } catch {
            return nil
        }
    }
    
    func sendBitcoinOffChain(invoice: Invoice) -> PaymentHash? {
        do {
            return try ldkNode.sendPayment(invoice: invoice)
        } catch {
            return nil
        }
    }
}
