import CoreLocation
import Foundation
import GooglePlaces
import GoogleMaps
import Foundation

public protocol AddressResult {
    var coordinate: CLLocationCoordinate2D { get }
    var formattedAddress: String? { get }
    var name: String? { get }
    var addressAndName: String? { get }
}

extension GMSAddress {
    public var formattedAddress: String? {
        guard let lines = lines else { return nil }
        let result = lines.reduce("") { (previous, line) -> String in
            let previousString = previous.isEmpty ? "" : "\(previous), "
            return "\(previousString)\(line)"
        }
        return result.isEmpty ? nil : result
    }
    
    public var addressAndName: String? {
        return self.formattedAddress
    }
    
    public var name: String? { return nil }
}

extension GMSAddress: AddressResult {}
extension GMSPlace: AddressResult {
    public var addressAndName: String? {
        return "\(self.name.isNilOrEmpty ? "" : "\(self.name!) ,") \(self.formattedAddress ?? "")"
    }
}

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}

