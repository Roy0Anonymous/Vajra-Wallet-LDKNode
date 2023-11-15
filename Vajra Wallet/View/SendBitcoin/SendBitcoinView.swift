//
//  SendBitcoinView.swift
//  Vajra Wallet
//
//  Created by Rahul Roy on 07/11/23.
//

import SwiftUI
import LDKNode

struct SendBitcoinView: View {
    @State var clipboardClicked = false
    @State var manualClicked = false
    @State var address: String = ""
    @State var invoice: String = ""
    @State var amount: String = ""
    @State var successAlertPresented: Bool = false
    @State var failedAlertPresented: Bool = false
    @State var txid: Txid? = nil
    @State var paymentHash: PaymentHash? = nil
//    @Binding var value: Double
    var isBitcoin: Bool
    var viewModel: SendBitcoinViewModel = SendBitcoinViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                clipboardClicked = true
            }, label: {
                MenuCell(image: Image(systemName: "doc.on.clipboard"), text: "Paste from Clipboard")
            })
            .popover(isPresented: $clipboardClicked, content: {
                VStack {
                    CustomTextField(textContent: $amount, placeholder: "Enter the Amount")
                        .padding(.horizontal, 10)
                        .padding(.bottom, 10)
                    CustomButtons(label: "Send")
                        .onTapGesture {
                            txid = viewModel.sendBitcoin(amount: UInt64(amount) ?? 0)
                            if txid != nil {
                                successAlertPresented = true
                            } else {
                                failedAlertPresented = true
                            }
                        }
                        .presentationCompactAdaptation(.sheet)
                        .presentationDetents([.height(170)])
                        .frame(width: 100)
                        .alert("Txid", isPresented: $successAlertPresented) {
                            Button(action: {
                                UIPasteboard.general.string = txid ?? ""
                                successAlertPresented = false
                            }, label: {
                                Text("Copy")
                            })
                            Button(action: {
                                successAlertPresented = false
                            }, label: {
                                Text("Cancel")
                            })
                        } message: {
                            Text(txid ?? "")
                        }
                        .alert("Txid", isPresented: $failedAlertPresented) {
                            Button(action: {
                                failedAlertPresented = false
                            }, label: {
                                Text("Cancel")
                            })
                        } message: {
                            Text("Failed to Send Bitcoins")
                        }
                }
            })
            Divider()
            Button(action: {
                
            }, label: {
                MenuCell(image: Image(systemName: "qrcode"), text: "Scan QR")
            })
            Divider()
            Button(action: {
                
            }, label: {
                MenuCell(image: Image(systemName: "photo.stack.fill"), text: "Choose Image")
            })
            Divider()
            Button(action: {
                manualClicked = true
            }, label: {
                MenuCell(image: Image(systemName: "highlighter"), text: "Manual input")
            })
            .popover(isPresented: $manualClicked, content: {
                VStack {
                    if isBitcoin {
                        bitcoinInput
                    } else {
                        lightningInput
                    }
                }
            })
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 20)
    }
    
    var bitcoinInput: some View {
        VStack {
            CustomTextField(textContent: $address, placeholder: "Enter the Address")
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
            CustomTextField(textContent: $amount, placeholder: "Enter the Amount")
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
            CustomButtons(label: "Send")
                .onTapGesture {
                    txid = viewModel.sendBitcoinOnChain(address: address, amount: UInt64(amount) ?? 0)
                    if txid != nil {
                        successAlertPresented = true
                    } else {
                        failedAlertPresented = true
                    }
                }
                .presentationCompactAdaptation(.sheet)
                .presentationDetents([.height(240)])
                .frame(width: 100)
                .alert("Txid", isPresented: $successAlertPresented) {
                    Button(action: {
                        UIPasteboard.general.string = txid ?? ""
                        successAlertPresented = false
                    }, label: {
                        Text("Copy")
                    })
                    Button(action: {
                        successAlertPresented = false
                    }, label: {
                        Text("Cancel")
                    })
                } message: {
                    Text(txid ?? "")
                }
                .alert("Txid", isPresented: $failedAlertPresented) {
                    Button(action: {
                        failedAlertPresented = false
                    }, label: {
                        Text("Cancel")
                    })
                } message: {
                    Text("Failed to Send Bitcoins")
                }
        }
    }
    
    var lightningInput: some View {
        VStack {
            CustomTextField(textContent: $invoice, placeholder: "Enter the Lightning Invoice")
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
            CustomButtons(label: "Send")
                .onTapGesture {
                    paymentHash = viewModel.sendBitcoinOffChain(invoice: invoice)
                    if paymentHash != nil {
                        successAlertPresented = true
                    } else {
                        failedAlertPresented = true
                    }
                }
                .presentationCompactAdaptation(.sheet)
                .presentationDetents([.height(240)])
                .frame(width: 100)
                .alert("Txid", isPresented: $successAlertPresented) {
                    Button(action: {
                        UIPasteboard.general.string = paymentHash ?? ""
                        successAlertPresented = false
                    }, label: {
                        Text("Copy")
                    })
                    Button(action: {
                        successAlertPresented = false
                    }, label: {
                        Text("Cancel")
                    })
                } message: {
                    Text(paymentHash ?? "")
                }
                .alert("payment Hash", isPresented: $failedAlertPresented) {
                    Button(action: {
                        failedAlertPresented = false
                    }, label: {
                        Text("Cancel")
                    })
                } message: {
                    Text("Failed to Send Bitcoins")
                }
        }
    }
    
}

#Preview {
    SendBitcoinView(isBitcoin: true)
}
