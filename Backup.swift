////
////  Backup.swift
////  IC Covid
////
////  Created by Francesco Cenciarelli on 08/06/2021.
////  Copyright © 2021 Francesco Cenciarelli. All rights reserved.
//
//
////
////  TakePhoto.swift
////  IC Covid
////
////  Created by Francesco Cenciarelli on 10/04/2021.
////  Copyright © 2021 Francesco Cenciarelli. All rights reserved.
////
//
//import Foundation
//import SwiftUI
//import AVFoundation
//import Vision
//import UIKit
//
//struct TakePhoto: View {
//
//    @State private var image: Image?
//    @State private var showingImagePicker = false
//
//    @Binding var red: CGFloat
//
//    @State private var inputImage: UIImage?
//
//    @Binding var showTakePhoto: Bool
//    @Binding var showFinal: Bool
//
//    var body: some View {
//        VStack (alignment: .center, spacing: 20) {
//
//            if image == nil {
//
//                VStack (alignment: .center, spacing: 60){
//
//                    Text("Place the device on one hand and take a picture of the change in color at the top of the device.")
//                        .font(.subheadline)
//                        .bold()
//                        .foregroundColor(.white)
//                        .frame(width: 320, height: 150, alignment: .center)
//                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.init(color3)))
//
//                    Image("Step6")
//                        .scaleEffect(0.8)
//                        .frame(width: 200, height: 400, alignment: .center)
//                }
//            }
//
//            if image != nil {
//                image?
//                    .resizable()
//                    .scaledToFit()
//            }
//            Button("Take the picture") {
//                self.showingImagePicker = true
//            }.buttonStyle(FinalMenuButtonStyle())
//
//            if image != nil {
//                Button("Get your results") {
//                    if inputImage != nil {
//                        let heightInPoints = inputImage!.size.height
//                        let heightInPixels = heightInPoints * inputImage!.scale
//                        let widthInPoints = inputImage!.size.width
//                        let widthInPixels = widthInPoints * inputImage!.scale
//
//                        let Pixel1 = inputImage!.pixelColor(x: Int(widthInPixels/2)-1, y: Int(heightInPixels/2)+1).greenComponent
//                        let Pixel2 = inputImage!.pixelColor(x: Int(widthInPixels/2), y: Int(heightInPixels/2)+1).greenComponent
//                        let Pixel3 = inputImage!.pixelColor(x: Int(widthInPixels/2)+1, y: Int(heightInPixels/2)+1).greenComponent
//                        let Pixel4 = inputImage!.pixelColor(x: Int(widthInPixels/2)-1, y: Int(heightInPixels/2)).greenComponent
//                        let Pixel5 = inputImage!.pixelColor(x: Int(widthInPixels/2), y: Int(heightInPixels/2)).greenComponent
//                        let Pixel6 = inputImage!.pixelColor(x: Int(widthInPixels/2)+1, y: Int(heightInPixels/2)).greenComponent
//                        let Pixel7 = inputImage!.pixelColor(x: Int(widthInPixels/2)-1, y: Int(heightInPixels/2)-1).greenComponent
//                        let Pixel8 = inputImage!.pixelColor(x: Int(widthInPixels/2), y: Int(heightInPixels/2)-1).greenComponent
//                        let Pixel9 = inputImage!.pixelColor(x: Int(widthInPixels/2)+1, y: Int(heightInPixels/2)-1).greenComponent
//
//                        print(inputImage!.pixelColor(x: Int(widthInPixels/2), y: Int(heightInPixels/2)).greenComponent)
//                        print(inputImage!.pixelColor(x: Int(widthInPixels/2), y: Int(heightInPixels/2)).redComponent)
//                        print(inputImage!.pixelColor(x: Int(widthInPixels/2), y: Int(heightInPixels/2)).blueComponent)
//
//                        red = (Pixel1+Pixel2+Pixel3+Pixel4+Pixel5+Pixel6+Pixel7+Pixel8+Pixel9 ) / 9
//
//                        print("Value of green is \(red)")
//
//                    }
//                    self.showTakePhoto = false
//                    self.showFinal = true
//                }
//                .buttonStyle(FinalMenuButtonStyle())
//            }
//
//        }
//        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
//            CustomCameraView(image: self.$inputImage)
//        }
//        .edgesIgnoringSafeArea(.all)
//    }
//
//    func loadImage() {
//        guard let inputImage = inputImage else { return }
//        image = Image(uiImage: inputImage)
//    }
//}
//
//struct CustomCameraView: View {
//
//    @Binding var image: UIImage?
//    @State var didTapCapture: Bool = false
//
//    var body: some View {
//        ZStack(alignment: .bottom) {
//
//            ImagePicker(image: self.$image, didTapCapture: $didTapCapture)
//
//            RectangleView().onTapGesture{
//                self.didTapCapture = true
//            }
//
//            CaptureButtonView().onTapGesture{
//                self.didTapCapture = true
//            }
//
//        }
//    }
//}
//
//
//
//struct ImagePicker: UIViewControllerRepresentable {
//
//    @Binding var image: UIImage?
//    @Environment(\.presentationMode) var presentationMode
//    @Binding var didTapCapture: Bool
//
//
//    func makeUIViewController(context: Context) -> CustomCameraController {
//        let picker = CustomCameraController()
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ cameraViewController: CustomCameraController, context: Context) {
//
//        if(self.didTapCapture) {
//            cameraViewController.didTapRecord()
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, UINavigationControllerDelegate, AVCapturePhotoCaptureDelegate {
//
//        var parent: ImagePicker
//
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
//
//                    parent.didTapCapture = false
//
//                    if let imageData = photo.fileDataRepresentation() {
//                        parent.image = UIImage(data: imageData)
//                    }
//                    parent.presentationMode.wrappedValue.dismiss()
//                }
//
//    }
//}
//
//class CustomCameraController: UIViewController {
//
//    var image: UIImage?
//
//    var captureSession = AVCaptureSession()
//    var backCamera: AVCaptureDevice?
//    var frontCamera: AVCaptureDevice?
//    var currentCamera: AVCaptureDevice?
//    var photoOutput: AVCapturePhotoOutput?
//    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
//
//    //DELEGATE
//    var delegate: AVCapturePhotoCaptureDelegate?
//
//    func didTapRecord() {
//
//        let settings = AVCapturePhotoSettings()
//        photoOutput?.capturePhoto(with: settings, delegate: delegate!)
//
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setup()
//    }
//    func setup() {
//        setupCaptureSession()
//        setupDevice()
//        setupInputOutput()
//        setupPreviewLayer()
//        startRunningCaptureSession()
//    }
//    func setupCaptureSession() {
//        captureSession.sessionPreset = AVCaptureSession.Preset.photo
//    }
//
//    func setupDevice() {
//        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera],
//                                                                      mediaType: AVMediaType.video,
//                                                                      position: AVCaptureDevice.Position.unspecified)
//        for device in deviceDiscoverySession.devices {
//
//            switch device.position {
//            case AVCaptureDevice.Position.front:
//                self.frontCamera = device
//            case AVCaptureDevice.Position.back:
//                self.backCamera = device
//            default:
//                break
//            }
//        }
//
//        self.currentCamera = self.backCamera
//    }
//
//
//    func setupInputOutput() {
//        do {
//
//            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
//            captureSession.addInput(captureDeviceInput)
//            photoOutput = AVCapturePhotoOutput()
//            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
//            captureSession.addOutput(photoOutput!)
//
//        } catch {
//            print(error)
//        }
//
//    }
//    func setupPreviewLayer()
//    {
//        self.cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        self.cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
//        self.cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
//        self.cameraPreviewLayer?.frame = self.view.frame
//        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
//
//    }
//    func startRunningCaptureSession(){
//        captureSession.startRunning()
//    }
//}
//
//struct RectangleView: View {
//
//    var body: some View {
//
//        ZStack {
//            Rectangle()
//                .foregroundColor(Color.blue.opacity(0.5))
//                .mask(Window(size: CGSize(width: 200, height: 150)).fill(style: FillStyle(eoFill: true)))
//
//
//
//            RoundedRectangle(cornerRadius: 3).stroke(Color.blue, lineWidth: 3)
//                .frame(width: 200, height: 150)
//        }
//    }
//}
//
//struct Window: Shape {
//    let size: CGSize
//    func path(in rect: CGRect) -> Path {
//        var path = Rectangle().path(in: rect)
//
//        let origin = CGPoint(x: rect.midX - size.width / 2, y: rect.midY - size.height / 2)
//        path.addRect(CGRect(origin: origin, size: size))
//        return path
//    }
//}
//
//struct CaptureButtonView: View {
//    @State private var animationAmount: CGFloat = 1
//    var body: some View {
//        Image(systemName: "camera").font(.largeTitle)
//            .padding(30)
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .clipShape(Circle())
//            .overlay(
//                Circle()
//                    .stroke(Color.blue)
//                    .scaleEffect(animationAmount)
//                    .opacity(Double(2 - animationAmount))
//                    .animation(Animation.easeOut(duration: 1)
//                        .repeatForever(autoreverses: true))
//        )
//            .onAppear
//            {
//                self.animationAmount = 2
//        }
//    }
//}
//
//public extension UIImage {
//
//    var pixelWidth: Int {
//        return cgImage?.width ?? 0
//    }
//
//    var pixelHeight: Int {
//        return cgImage?.height ?? 0
//    }
//
//    func pixelColor(x: Int, y: Int) -> UIColor {
//        assert(
//            0..<pixelWidth ~= x && 0..<pixelHeight ~= y,
//            "Pixel coordinates are out of bounds")
//
//        guard
//            let cgImage = cgImage,
//            let data = cgImage.dataProvider?.data,
//            let dataPtr = CFDataGetBytePtr(data),
//            let colorSpaceModel = cgImage.colorSpace?.model,
//            let componentLayout = cgImage.bitmapInfo.componentLayout
//        else {
//            assertionFailure("Could not get a pixel of an image")
//            return .clear
//        }
//
//        assert(
//            colorSpaceModel == .rgb,
//            "The only supported color space model is RGB")
//        assert(
//            cgImage.bitsPerPixel == 32 || cgImage.bitsPerPixel == 24,
//            "A pixel is expected to be either 4 or 3 bytes in size")
//
//        let bytesPerRow = cgImage.bytesPerRow
//        let bytesPerPixel = cgImage.bitsPerPixel/8
//        let pixelOffset = y*bytesPerRow + x*bytesPerPixel
//
//        if componentLayout.count == 4 {
//            let components = (
//                dataPtr[pixelOffset + 0],
//                dataPtr[pixelOffset + 1],
//                dataPtr[pixelOffset + 2],
//                dataPtr[pixelOffset + 3]
//            )
//
//            var alpha: UInt8 = 0
//            var red: UInt8 = 0
//            var green: UInt8 = 0
//            var blue: UInt8 = 0
//
//            switch componentLayout {
//            case .bgra:
//                alpha = components.3
//                red = components.2
//                green = components.1
//                blue = components.0
//            case .abgr:
//                alpha = components.0
//                red = components.3
//                green = components.2
//                blue = components.1
//            case .argb:
//                alpha = components.0
//                red = components.1
//                green = components.2
//                blue = components.3
//            case .rgba:
//                alpha = components.3
//                red = components.0
//                green = components.1
//                blue = components.2
//            default:
//                return .clear
//            }
//
//            // If chroma components are premultiplied by alpha and the alpha is `0`,
//            // keep the chroma components to their current values.
//            if cgImage.bitmapInfo.chromaIsPremultipliedByAlpha && alpha != 0 {
//                let invUnitAlpha = 255/CGFloat(alpha)
//                red = UInt8((CGFloat(red)*invUnitAlpha).rounded())
//                green = UInt8((CGFloat(green)*invUnitAlpha).rounded())
//                blue = UInt8((CGFloat(blue)*invUnitAlpha).rounded())
//            }
//
//            return .init(red: red, green: green, blue: blue, alpha: alpha)
//
//        } else if componentLayout.count == 3 {
//            let components = (
//                dataPtr[pixelOffset + 0],
//                dataPtr[pixelOffset + 1],
//                dataPtr[pixelOffset + 2]
//            )
//
//            var red: UInt8 = 0
//            var green: UInt8 = 0
//            var blue: UInt8 = 0
//
//            switch componentLayout {
//            case .bgr:
//                red = components.2
//                green = components.1
//                blue = components.0
//            case .rgb:
//                red = components.0
//                green = components.1
//                blue = components.2
//            default:
//                return .clear
//            }
//
//            return .init(red: red, green: green, blue: blue, alpha: UInt8(255))
//
//        } else {
//            assertionFailure("Unsupported number of pixel components")
//            return .clear
//        }
//    }
//
//}
//
//public extension UIColor {
//
//    convenience init(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) {
//        self.init(
//            red: CGFloat(red)/255,
//            green: CGFloat(green)/255,
//            blue: CGFloat(blue)/255,
//            alpha: CGFloat(alpha)/255)
//    }
//
//}
//
//public extension CGBitmapInfo {
//
//    enum ComponentLayout {
//
//        case bgra
//        case abgr
//        case argb
//        case rgba
//        case bgr
//        case rgb
//
//        var count: Int {
//            switch self {
//            case .bgr, .rgb: return 3
//            default: return 4
//            }
//        }
//
//    }
//
//    var componentLayout: ComponentLayout? {
//        guard let alphaInfo = CGImageAlphaInfo(rawValue: rawValue & Self.alphaInfoMask.rawValue) else { return nil }
//        let isLittleEndian = contains(.byteOrder32Little)
//
//        if alphaInfo == .none {
//            return isLittleEndian ? .bgr : .rgb
//        }
//        let alphaIsFirst = alphaInfo == .premultipliedFirst || alphaInfo == .first || alphaInfo == .noneSkipFirst
//
//        if isLittleEndian {
//            return alphaIsFirst ? .bgra : .abgr
//        } else {
//            return alphaIsFirst ? .argb : .rgba
//        }
//    }
//
//    var chromaIsPremultipliedByAlpha: Bool {
//        let alphaInfo = CGImageAlphaInfo(rawValue: rawValue & Self.alphaInfoMask.rawValue)
//        return alphaInfo == .premultipliedFirst || alphaInfo == .premultipliedLast
//    }
//
//}
//
//extension UIColor {
//
//    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
//        var redColor: CGFloat = 0.0
//        var greenColor: CGFloat = 0.0
//        var blueColor: CGFloat = 0.0
//        var alphaColor: CGFloat = 0.0
//        getRed(&redColor, green: &greenColor, blue: &blueColor, alpha: &alphaColor)
//
//        return (red: redColor, green: greenColor, blue: blueColor, alpha: alphaColor)
//    }
//
//    var redComponent: CGFloat {
//        var red: CGFloat = 0.0
//        getRed(&red, green: nil, blue: nil, alpha: nil)
//
//        return red
//    }
//
//    var greenComponent: CGFloat {
//        var green: CGFloat = 0.0
//        getRed(nil, green: &green, blue: nil, alpha: nil)
//
//        return green
//    }
//
//    var blueComponent: CGFloat {
//        var blue: CGFloat = 0.0
//        getRed(nil, green: nil, blue: &blue, alpha: nil)
//
//        return blue
//    }
//
//    var alphaComponent: CGFloat {
//        var alpha: CGFloat = 0.0
//        getRed(nil, green: nil, blue: nil, alpha: &alpha)
//
//        return alpha
//    }
//}
// //https://gist.github.com/marchinram/3675efc96bf1cc2c02a5
