////
////  CheckOutView.swift
////  Vajra Wallet
////
////  Created by Rahul Roy on 12/11/23.
////
//
//
//import SwiftUI
//
//struct ContentView: View {
//    @State private var progress: CGFloat = 1.0
//    let startValue: UInt64 = 9223372036854775808 // Higher value
//    let endValue: UInt64 = 1000000000 // Lower value
//
//    var body: some View {
//        VStack {
//            Text("Linear Progress Bar")
//            ProgressBar(progress: $progress)
//                .onAppear {
//                    withAnimation(.linear(duration: 5.0)) {
//                        self.progress = 0.6
//                    }
//                }
//        }
//        .padding()
//    }
//}
//
//struct ProgressBar: View {
//    @Binding var progress: CGFloat
//
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack(alignment: .leading) {
//                Rectangle()
//                    .frame(width: geometry.size.width, height: 10)
//                    .opacity(0.3)
//                    .background(Color.gray)
//
//                Rectangle()
//                    .frame(width: min(self.progress * geometry.size.width, geometry.size.width), height: 10)
//                    .background(Color.blue)
//                    .cornerRadius(5.0)
//                    .animation(.linear)
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//
//
//
//#Preview {
//    ContentView()
//}
