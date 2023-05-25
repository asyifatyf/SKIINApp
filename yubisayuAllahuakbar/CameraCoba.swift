//
//  CameraCoba.swift
//  yubisayuAllahuakbar
//
//  Created by Asyifa Tasya Fadilah on 22/05/23.
//

import SwiftUI
import AVFoundation
import Vision
import CoreML

struct CameraCoba: View{
    @StateObject var camera = CameraModel()
    @State private var shouldNavigate = false
    @State var imageData : Data = Data()
    @State var classificationResult: String = ""
    @StateObject var imageClassifierInstance = ImageClassifier()
    @State private var isButtonClicked: Bool = false
    
    var body: some View{
        
        NavigationView{
            GeometryReader { geo in
                ZStack {
                    Image("i")
                    
                    VStack{
                        CameraPreview(camera: camera)
                            .frame(width: 300, height: 450)
                            .cornerRadius(30)
                            .padding(.bottom)
                            .padding(.top,100)
                        
                        
                        Button(action: {camera.switchCamera()
                            
                        }, label: {
                            Image("camera")
                                .resizable()
                                .foregroundColor(.black)
                                .frame(width: 80, height: 80)
                        })
        
                        
                        ZStack{
                            Button(action: {camera.takePic()
                                classificationResult = camera.result
                                self.isButtonClicked = true
                                
                            }, label: {
                                Image("Start")
                                    .padding()
                            })
                            
                            
                            if isButtonClicked {
                                NavigationLink {
                                    ResultView(camera: camera)
                                } label: {
                                    Image("SR")
                                        .padding()
                                        .onChange(of: camera.alert, perform: { newValue in
                                            camera.takePic()
                                            DispatchQueue.global(qos: .background).async {
                                                classificationResult = camera.result }})
                                }
                            }
                        }
                      }
                                                   
                    }
                }
                .onAppear(perform: {
                    camera.Check()
                })
                .ignoresSafeArea()
            }
            .navigationBarBackButtonHidden(true)
        }
    }


struct CameraCoba_Previews: PreviewProvider {
    static var previews: some View {
        CameraCoba()
    }
}

class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate{
    @Published var isTaken = false
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var output = AVCapturePhotoOutput() // ini buat image yg di capture
    @Published var preview: AVCaptureVideoPreviewLayer!
    @Published var isSaved = false
    @Published var picData = Data(count:0)
    @Published var imageClassifierInstance = ImageClassifier()
    @Published var result : String = ""
    
    func Check(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case.authorized:
            setUp()
            return
        case.notDetermined:
            AVCaptureDevice.requestAccess(for: .video) {(status) in
                if status{
                    self.setUp()
                }
            }
        case.denied:
            self.alert.toggle()
            return
        default:
            return
        }
    }
    
    func setUp(){
        do{
            self.session.beginConfiguration()
            let device = AVCaptureDevice.default(for: .video)
            let input = try AVCaptureDeviceInput(device: device!)
            if self.session.canAddInput(input){
                self.session.addInput(input)
            }
            if self.session.canAddOutput(self.output){
                self.session.addOutput(self.output)
            }
            self.session.commitConfiguration()
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    
    func takePic(){
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        DispatchQueue.main.async {
            self.session.stopRunning()
            
        }
        DispatchQueue.main.async {
            withAnimation{
                self.isTaken.toggle()}
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error != nil{
            return
        }
        print("pic taken...")
        alert.toggle()
        guard let imageData = photo.fileDataRepresentation() else{return}
        self.picData = imageData
        
        guard let ciImage = CIImage(data: imageData) else { return }
        
        self.imageClassifierInstance.processImage(for: ciImage)
        self.result = imageClassifierInstance.result
    }
    
    func reTake(){
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
            DispatchQueue.main.async {
                withAnimation{self.isTaken.toggle()}
                self.isSaved = false
            }
        }
    }
    
    func savePic(){
        let image = UIImage(data: self.picData)!
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        self.isSaved = true
        print("saved successfully...")
    }
    
    func switchCamera() {
        session.beginConfiguration()
        let currentInput = session.inputs.first as? AVCaptureDeviceInput
        session.removeInput(currentInput!)
        let newCameraDevice = currentInput?.device.position == .back ? getCamera(with: .front) : getCamera(with: .back)
        let newVideoInput = try? AVCaptureDeviceInput(device: newCameraDevice!)
        session.addInput(newVideoInput!)
        session.commitConfiguration()
    }
    
    func getCamera(with position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        guard let devices = AVCaptureDevice.devices(for: AVMediaType.video) as? [AVCaptureDevice] else {
            return nil
        }
        
        return devices.filter {
            $0.position == position
        }.first
    }
}

class ImageClassifier: ObservableObject{
    var shared = createImageClassifier()
    @Published var result : String = ""
    static func createImageClassifier () -> VNCoreMLModel{
        let defaultConfig = MLModelConfiguration ()
        
        let imageClassifierWrapper = try? STClassifier (configuration: defaultConfig)
        
        guard let imageClassifier = imageClassifierWrapper else{
            fatalError ("Failed to create an ML Model instance")
        }
        let imageClassifierModel = imageClassifier.model
        guard let imageClassifierVisionModel = try? VNCoreMLModel (for: imageClassifierModel) else{
            fatalError ("Failed to create VNCoreMLModel Instance")
        }
        return imageClassifierVisionModel
    }
    
    func processImage (for image : CIImage) {
        let imageClassificationRequest = VNCoreMLRequest(model: shared)
        let handler = VNImageRequestHandler(ciImage: image, orientation: .up)
        let requests : [VNRequest] = [imageClassificationRequest]
        try? handler.perform(requests)
        guard let observations = imageClassificationRequest.results as?
                [VNClassificationObservation] else{
            print("VNRequest produced the wrong result type :",(type(of:
                                                                        imageClassificationRequest.results)))
            return
        }
        if let firstResult = observations.first{
            self.result = firstResult.identifier
        }
    }
}

struct CameraPreview: UIViewRepresentable{
    @ObservedObject var camera: CameraModel
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        
        camera.session.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
