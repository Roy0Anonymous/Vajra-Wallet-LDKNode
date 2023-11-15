//
//  ReceiveBitcoinViewModel.swift
//  Vajra Wallet
//
//  Created by Rahul Roy on 12/11/23.
//

import Foundation
import CoreImage.CIFilterBuiltins
import UIKit

class ReceiveBitcoinViewModel {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    func generateQRCode(from string: String) -> Data? {
        let data = string.data(using: .ascii, allowLossyConversion: false)
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else {
            return nil
        }
        filter.setValue(data, forKey: "inputMessage")
        guard let ciimage = filter.outputImage else {
            return nil
        }
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledCIImage = ciimage.transformed(by: transform)
        let uiimage = UIImage(ciImage: scaledCIImage)
        return uiimage.pngData()!
    }
}
