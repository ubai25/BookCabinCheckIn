//
//  BarcodeView.swift
//  BookCabin_CheckIn
//
//  Created by Ubaidillah Ahmad on 07/12/25.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct BarcodeView: View {
    let data: String
    let context = CIContext()
    let filter = CIFilter.code128BarcodeGenerator()

    var body: some View {
        if let image = generateBarcode(from: data) {
            Image(uiImage: image)
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(height: 120)
        }
    }

    func generateBarcode(from string: String) -> UIImage? {
        let data = Data(string.utf8)
        filter.message = data

        if let output = filter.outputImage {
            if let cgimg = context.createCGImage(output, from: output.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return nil
    }
}

#Preview {
    BarcodeView(data: "M1TEST")
}
