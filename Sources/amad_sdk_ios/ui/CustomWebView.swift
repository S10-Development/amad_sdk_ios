//
//  CustomWebView.swift
//  amad_sdk_ios
//
//  Created by Pablo Jair Angeles on 12/05/25.
//

//
//  WebView.swift
//  ui
//
//  Created by Pablo Jair Angeles on 08/03/25.
//
import SwiftUI
import WebKit
import CoreLocation

/// Wrapping WKWebView para SwiftUI con soporte de geolocalización y enlaces en la misma ventana
 struct CustomWrapperWebView: UIViewRepresentable {
    var url: URL
    let locationManager = CLLocationManager()

    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate, CLLocationManagerDelegate {
        let parent: CustomWrapperWebView

        init(_ parent: CustomWrapperWebView) {
            self.parent = parent
        }

        // MARK: CLLocationManagerDelegate
        nonisolated func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                print("Permiso de localización concedido")
            case .denied, .restricted:
                print("Permiso de localización denegado")
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            @unknown default:
                break
            }
        }

        // MARK: WKNavigationDelegate
        private func webView(_ webView: WKWebView,
                     decidePolicyFor navigationAction: WKNavigationAction,
                     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            decisionHandler(.allow)
        }

        // Soporta enlaces con target="_blank" o window.open
        func webView(_ webView: WKWebView,
                     createWebViewWith configuration: WKWebViewConfiguration,
                     for navigationAction: WKNavigationAction,
                     windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            return nil
        }

        // MARK: WKUIDelegate
         func webView(_ webView: WKWebView,
                     runJavaScriptAlertPanelWithMessage message: String,
                     initiatedByFrame frame: WKFrameInfo,
                     completionHandler: @escaping () -> Void) {
            print("Alerta web: \(message)")
            completionHandler()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.preferences.javaScriptCanOpenWindowsAutomatically = true
        config.allowsInlineMediaPlayback = true

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true

        // Pedir permisos de ubicación
        locationManager.delegate = context.coordinator
        locationManager.requestWhenInUseAuthorization()

        // Carga inicial
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        guard webView.url != url else { return }
        webView.load(URLRequest(url: url))
    }
}

public struct CustomWebView: View {
    let url: String
    @Environment(\.dismiss) private var dismiss

    public init(url: String) {
        self.url = url
    }

    public var body: some View {
        VStack(spacing: 0) {
            CustomWrapperWebView(url: URL(string: url)!)
                .edgesIgnoringSafeArea(.all)
        }
        
              .navigationBarBackButtonHidden(true)
              .toolbar {
                  ToolbarItem(placement: .navigationBarLeading) {
                      Button("Listo") {
                          dismiss()
                      }
                  }
              }    }
}

#Preview {
    CustomWebView(url: "https://demoamadalvaroobregon.s10plus.com")
}
