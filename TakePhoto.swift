//
//  TakePhoto.swift
//
//
//  Created by Francesco Cenciarelli on 10/04/2021.
//  Copyright © 2021 Francesco Cenciarelli. All rights reserved.
//

// Importing all the library used

import Foundation
import SwiftUI
import AVFoundation
import Vision
import UIKit

struct TakePhoto: View {

    @State private var image: Image? // At the start image is Null
    @State private var showingImagePicker = false

    @Binding var result: CGFloat // Final result variable to pass to the final result tab

    @State private var inputImage: UIImage? // value passed to image by load_image()

    @Binding var showTakePhoto: Bool // If false it will change view
    @Binding var showFinal: Bool // If true it will show the final result tab

    var body: some View {
        // Vertical stack to organise the elements
        VStack (alignment: .center, spacing: 20) {

            // If there is no image, show the instructions
            if image == nil {

                VStack (alignment: .center, spacing: 60){

                    Text("Place the device on one hand and take a picture of the change in color at the top of the device.")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 320, height: 150, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.init(color3)))

                    Image("Step6")
                        .scaleEffect(0.8)
                        .frame(width: 200, height: 400, alignment: .center)
                }
            }
            // if there is image, show the image
            if image != nil {
                image?
                    .resizable()
                    .scaledToFit()
            }
            // Button to activate the camera
            Button("Take the picture") {
                self.showingImagePicker = true
            }.buttonStyle(FinalMenuButtonStyle())

            // Button to do start the data processing
            if image != nil {
                Button("Get your results") {
                    if inputImage != nil {
                        // getting the image data
                        let heightInPoints = inputImage!.size.height
                        let heightInPixels = heightInPoints * inputImage!.scale
                        let widthInPoints = inputImage!.size.width
                        let widthInPixels = widthInPoints * inputImage!.scale

                        // nine pixels forming a cube around the centre of the image, for each get the green component value

                        let Pixel1 = inputImage!.pixelColor(x: Int(widthInPixels/2)-1, y: Int(heightInPixels/2)+1).greenComponent
                        let Pixel2 = inputImage!.pixelColor(x: Int(widthInPixels/2), y: Int(heightInPixels/2)+1).greenComponent
                        let Pixel3 = inputImage!.pixelColor(x: Int(widthInPixels/2)+1, y: Int(heightInPixels/2)+1).greenComponent
                        let Pixel4 = inputImage!.pixelColor(x: Int(widthInPixels/2)-1, y: Int(heightInPixels/2)).greenComponent
                        let Pixel5 = inputImage!.pixelColor(x: Int(widthInPixels/2), y: Int(heightInPixels/2)).greenComponent
                        let Pixel6 = inputImage!.pixelColor(x: Int(widthInPixels/2)+1, y: Int(heightInPixels/2)).greenComponent
                        let Pixel7 = inputImage!.pixelColor(x: Int(widthInPixels/2)-1, y: Int(heightInPixels/2)-1).greenComponent
                        let Pixel8 = inputImage!.pixelColor(x: Int(widthInPixels/2), y: Int(heightInPixels/2)-1).greenComponent
                        let Pixel9 = inputImage!.pixelColor(x: Int(widthInPixels/2)+1, y: Int(heightInPixels/2)-1).greenComponent

                        // Printing the resuls to the debugger
                        print(inputImage!.pixelColor(x: Int(widthInPixels/2), y: Int(heightInPixels/2)).greenComponent)
                        print(inputImage!.pixelColor(x: Int(widthInPixels/2), y: Int(heightInPixels/2)).redComponent)
                        print(inputImage!.pixelColor(x: Int(widthInPixels/2), y: Int(heightInPixels/2)).blueComponent)

                        // Avarage the values and get the final result
                        result = (Pixel1+Pixel2+Pixel3+Pixel4+Pixel5+Pixel6+Pixel7+Pixel8+Pixel9 ) / 9

                        // Printing result to debugger
                        print("Value of green is \(result)")

                    }
                    self.showTakePhoto = false
                    self.showFinal = true
                }
                .buttonStyle(FinalMenuButtonStyle()) // Button colour and shape
            }

        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            CustomCameraView(image: self.$inputImage) // presenting the custom camera. When the picture is taken, load the image.
        }
        .edgesIgnoringSafeArea(.all)
    }

    func loadImage() {
        guard let inputImage = inputImage else { return } // guard statement because at the start the image is null
        image = Image(uiImage: inputImage) // setting a UIImage called image
    }
}

struct CustomCameraView: View {

    @Binding var image: UIImage? // Take the image from TakePhoto
    @State var didTapCapture: Bool = false

    // Body contains 3 elements: the camera view, the custom mask view and the camera Button
    var body: some View {
        ZStack(alignment: .bottom) {

            ImagePicker(image: self.$image, didTapCapture: $didTapCapture)

            RectangleView().onTapGesture{
                self.didTapCapture = true
            }
            
            CaptureButtonView().onTapGesture{
                self.didTapCapture = true
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {

    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode // used to dismiss the view
    @Binding var didTapCapture: Bool


    // A controller requires the following 3 methods
    // Create the controller and assign the custom camera view
    func makeUIViewController(context: Context) -> CustomCameraController {
        let picker = CustomCameraController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ cameraViewController: CustomCameraController, context: Context) {

        if(self.didTapCapture) {
            cameraViewController.didTapRecord()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, AVCapturePhotoCaptureDelegate {

        var parent: ImagePicker
        // Initialise the image picker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {

        parent.didTapCapture = false

        // Sending the image to the Binding variable that will be transferred to TakePhoto struct
        if let imageData = photo.fileDataRepresentation() {
            parent.image = UIImage(data: imageData)
        }
        parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

class CustomCameraController: UIViewController {

    var image: UIImage?
    // Initialise the variables assigning them as optional of AV libary elements
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    var photoOutput: AVCapturePhotoOutput?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    var delegate: AVCapturePhotoCaptureDelegate?

    func didTapRecord() {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: delegate!) // Start the capture

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSession()
    }

    func setupSession() {
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
    }
    
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }

    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera],
                                                                      mediaType: AVMediaType.video,
                                                                      position: AVCaptureDevice.Position.unspecified)
        for device in deviceDiscoverySession.devices {

            switch device.position {
            case AVCaptureDevice.Position.front:
                self.frontCamera = device
            case AVCaptureDevice.Position.back:
                self.backCamera = device
            default:
                break
            }
        }

        self.currentCamera = self.backCamera
    }


    func setupInputOutput() {
        do {

            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)

        } catch {
            print(error)
        }

    }
    func setupPreviewLayer()
    {
        self.cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        self.cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)

    }
    func startRunningCaptureSession(){
        captureSession.startRunning()
    }
}

struct RectangleView: View {
    // View containing the mask to capture the picture
    var body: some View {

        ZStack {
            // Main Rectangle which serves as the mask
            Rectangle()
                .foregroundColor(Color.blue.opacity(0.5))
                .mask(Window(size: CGSize(width: 200, height: 150)).fill(style: FillStyle(eoFill: true))) // Cutted Frame inside the main rectangle
            // Frame around the main rectangle
            RoundedRectangle(cornerRadius: 3).stroke(Color.blue, lineWidth: 3)
                .frame(width: 200, height: 150)
        }
    }
}


// Creating a shape by tracing a rectangular path that serves inside the RectangularView to create the mask
struct Window: Shape {
    let size: CGSize
    func path(in rect: CGRect) -> Path {
        var path = Rectangle().path(in: rect)
        let origin = CGPoint(x: rect.midX - size.width / 2, y: rect.midY - size.height / 2)
        path.addRect(CGRect(origin: origin, size: size))
        return path
    }
}
// Creating the custom button to take the picture
struct CaptureButtonView: View {
    @State private var animationAmount: CGFloat = 1
    var body: some View {
        
        Image(systemName: "camera").font(.largeTitle) // Importing the camera icon
            .padding(30)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.blue)
                    .scaleEffect(animationAmount)
                    .opacity(Double(2 - animationAmount))
                    .animation(Animation.easeOut(duration: 1)
                        .repeatForever(autoreverses: true))
        )
            .onAppear
            {
                self.animationAmount = 2
        }
    }
}

// Creating additional variables and functions of the UIImage class

public extension UIImage {
    // Main processing function, takes the point position and outputs a UIColor object
    func pixelColor(x: Int, y: Int) -> UIColor {

        guard
            let cgImage = cgImage,  // Use CGImage format since UIImage cannot be used
            let data = cgImage.dataProvider?.data,
            let dataPtr = CFDataGetBytePtr(data), // Getting the bits data from
            let componentLayout = cgImage.bitmapInfo.componentLayout
        else {
            assertionFailure("Error in getting the pixel")
            return .clear
        }

        let bytesPerRow = cgImage.bytesPerRow
        let bytesPerPixel = cgImage.bitsPerPixel/8
        let pixelOffset = y*bytesPerRow + x*bytesPerPixel

        if componentLayout.count == 4 {
            // If there is red, blue, green and alpha, create a 4 pointer array
            let components = (
                dataPtr[pixelOffset + 0],
                dataPtr[pixelOffset + 1],
                dataPtr[pixelOffset + 2],
                dataPtr[pixelOffset + 3]
            )
            // Initilising the colours variables
            var alpha: UInt8 = 0
            var red: UInt8 = 0
            var green: UInt8 = 0
            var blue: UInt8 = 0
            // depending on the order change the order of the components
            switch componentLayout {
            case .bgra:
                alpha = components.3
                red = components.2
                green = components.1
                blue = components.0
            case .abgr:
                alpha = components.0
                red = components.3
                green = components.2
                blue = components.1
            case .argb:
                alpha = components.0
                red = components.1
                green = components.2
                blue = components.3
            case .rgba:
                alpha = components.3
                red = components.0
                green = components.1
                blue = components.2
            default:
                return .clear
            }

            return .init(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))

        } else if componentLayout.count == 3 {
            // If the components are only 3, create a 3 pointers array
            let components = (
                dataPtr[pixelOffset + 0],
                dataPtr[pixelOffset + 1],
                dataPtr[pixelOffset + 2]
            )

            var red: UInt8 = 0
            var green: UInt8 = 0
            var blue: UInt8 = 0

            switch componentLayout {
            case .bgr:
                red = components.2
                green = components.1
                blue = components.0
            case .rgb:
                red = components.0
                green = components.1
                blue = components.2
            default:
                return .clear
            }
            // initialise a Colour with the values of the colours variables
            return .init(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: CGFloat(UInt8(255))/255)

        } else {
            assertionFailure("Error in number of Pixel components") // avoid crashes if there are too many components
            return .clear
        }
    }

}

public extension CGBitmapInfo {
    // Creating different types of attributes depending on the pixel type
    enum ComponentLayout {
        // These are the possible colours orders
        case bgra
        case abgr
        case argb
        case rgba
        case bgr
        case rgb

        var count: Int {
            switch self {
            case .bgr, .rgb: return 3 // if there is no alpha, number of values is 3
            default: return 4
            }
        }

    }
    // Checking the format of the Pixel to understand the colour order
    var componentLayout: ComponentLayout? {
        guard let alphaInfo = CGImageAlphaInfo(rawValue: rawValue & Self.alphaInfoMask.rawValue) else { return nil }
        let checkLittleEndian = contains(.byteOrder32Little) // check the notation of the bytes
        
        // if checkLittleEndian is True invert the rgb order
        
        if alphaInfo == .none {
            return checkLittleEndian ? .bgr : .rgb
        }
        let alphaIsFirst = alphaInfo == .premultipliedFirst || alphaInfo == .first || alphaInfo == .noneSkipFirst
        // if alpha is before the rest of the colours change the orders
        if checkLittleEndian {
            return alphaIsFirst ? .bgra : .abgr
        } else {
            return alphaIsFirst ? .argb : .rgba
        }
    }

}

extension UIColor {
    // Extension to obtain each component value
    var redComponent: CGFloat {
        var red: CGFloat = 0.0
        getRed(&red, green: nil, blue: nil, alpha: nil)

        return red
    }

    var greenComponent: CGFloat {
        var green: CGFloat = 0.0
        getRed(nil, green: &green, blue: nil, alpha: nil)

        return green
    }

    var blueComponent: CGFloat {
        var blue: CGFloat = 0.0
        getRed(nil, green: nil, blue: &blue, alpha: nil)

        return blue
    }
}
