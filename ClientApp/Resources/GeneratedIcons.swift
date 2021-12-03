// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Icons {
  internal enum Basket {
    internal static let animal = ImageAsset(name: "Animal")
  }
  internal static let bonusImage = ImageAsset(name: "BonusImage")
  internal static let caretLeft = ImageAsset(name: "CaretLeft")
  internal static let caretRight = ImageAsset(name: "CaretRight")
  internal static let compass = ImageAsset(name: "Compass")
  internal static let house = ImageAsset(name: "House")
  internal enum MainMenu {
    internal static let bakery = ImageAsset(name: "Bakery")
    internal static let cocktails = ImageAsset(name: "Cocktails")
    internal static let coffee = ImageAsset(name: "Coffee")
    internal static let desserts = ImageAsset(name: "Desserts")
    internal static let tea = ImageAsset(name: "Tea")
  }
  internal static let mapPin = ImageAsset(name: "MapPin")
  internal static let paperPlaneTilt = ImageAsset(name: "PaperPlaneTilt")
  internal static let pencil = ImageAsset(name: "Pencil")
  internal enum Profile {
    internal static let signOut = ImageAsset(name: "SignOut")
  }
  internal enum QRCode {
    internal static let qrCodeBorder = ImageAsset(name: "qrCodeBorder")
  }
  internal static let qrCode = ImageAsset(name: "QrCode")
  internal enum Registration {
    internal static let calendar = ImageAsset(name: "Calendar")
    internal static let phone = ImageAsset(name: "Phone")
    internal static let registrationIcon = ImageAsset(name: "RegistrationIcon")
    internal static let user = ImageAsset(name: "User")
  }
  internal static let toteSimple = ImageAsset(name: "ToteSimple")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
