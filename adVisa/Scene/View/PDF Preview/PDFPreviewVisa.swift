//
//  PDFPreviewVisa.swift
//  adVisa
//
//  Created by hendra on 21/08/24.
//

import SwiftUI
import PDFKit

struct PDFPreviewView: UIViewRepresentable {
    let pdfDocument: PDFDocument

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}
}

struct PDFPreviewVisa: View {
    @StateObject private var pdfPreviewViewModel: PdfPreviewVisaViewModel = PdfPreviewVisaViewModel()
    @State private var pdfDocument: PDFDocument?

    var body: some View {
        VStack {
            if let pdfDocument = pdfDocument {
                PDFPreviewView(pdfDocument: pdfDocument)
            } else {
                Text("No PDF Loaded")
            }
        }
        
    }
    
    
}

#Preview {
    PDFPreviewVisa()
}
