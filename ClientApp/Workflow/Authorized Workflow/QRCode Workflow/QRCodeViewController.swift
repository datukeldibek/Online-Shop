//
//  QRCodeViewController.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 7/11/21.
//

import UIKit
import AVFoundation

class QRCodeViewController: BaseViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Заказ через QR Code"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = " Пожалуйста наведите камеру на QR-код, который на столе, чтобы забронировать стол за вами"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private let borderView: UIImageView = {
        let view = UIImageView()
        view.image = Icons.QRCode.qrCodeBorder.image
        view.backgroundColor = .clear
        view.tintColor = Colors.orange.color
        return view
    }()
    
    private let QRCodeScanner: UIView = {
        let view = UIView()
        return view
    }()
    
    private let noteLabel: UILabel = {
        let label = UILabel()
        label.text = "Заказ по QR Code начислит вам бонусные баллы за оформленный заказ"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Properties
    private var video = AVCaptureVideoPreviewLayer()
    private let session = AVCaptureSession()
    private let output = AVCaptureMetadataOutput()
    private let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scanQRCode()
    }
    
    private func setUp() {
        setUpSubviews()
        setUpConstaints()
    }
    
    private func setUpSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(borderView)
        view.addSubview(QRCodeScanner)
        view.addSubview(noteLabel)
    }
    
    private func setUpConstaints () {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(25)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(60)
        }
        borderView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(250)
        }
        QRCodeScanner.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(192)
        }
        noteLabel.snp.makeConstraints { make in
            make.top.equalTo(QRCodeScanner.snp.bottom).offset(57)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
    }
    
    private func scanQRCode() {
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        } catch {
            print ("ERROR")
        }
    
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.videoGravity = .resizeAspectFill
        QRCodeScanner.layer.addSublayer(video)
        video.frame = QRCodeScanner.layer.bounds
        session.startRunning()
    }
}

// MARK: - QRCode reader

extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count != 0 {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                if object.type == AVMetadataObject.ObjectType.qr,
                   let nameText = object.stringValue {
                    let alert = UIAlertController(title: "Заказ успешно оформлен на стол: ", message: "\(nameText)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Назад", style: .default, handler: { [weak self] _ in
                        self?.dismiss(animated: true)
                    }))
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
