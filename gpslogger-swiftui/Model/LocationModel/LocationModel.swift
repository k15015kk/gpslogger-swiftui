import Foundation
import CoreLocation
import SwiftData

enum LocationAuthorizationError: Error {
    case notDetermined
    case denied
    case unknown
}

class LocationModel: ObservableObject {
    
    // MARK: - State
    @Published var isLocationUpdate: Bool = false
    
    // Locationの情報
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0
    @Published var altitude: Double = 0.0
    @Published var ellipsoidalAltitude: Double = 0.0
    @Published var speed: Double = 0.0
    @Published var course: Double = 0.0
    
    // MARK: - Properties
    private var locationManager = CLLocationManager()
    
    // MARK: - Handler
    var locationSaveHandler: (@MainActor (CLLocation) -> Void)? = nil
    
    // MARK: - Initialize
    init() {
        
    }
    
    // MARK: - functions
    @MainActor
    func startLocation() async throws {
        
        print("現在の許可状態: \(locationManager.authorizationStatus)")
        
        switch locationManager.authorizationStatus {
            
        // まだ許可していない場合
        case .notDetermined :
            locationManager.requestWhenInUseAuthorization()
            self.isLocationUpdate = false
            throw LocationAuthorizationError.notDetermined
            
        // 拒否している状態
        case .restricted, .denied:
            self.isLocationUpdate = false
            throw LocationAuthorizationError.denied
            
        // 許可している場合
        case .authorizedAlways:
            try await locationUpdate()
            break
        
        // アプリ使用中のみ許可している場合
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
            try await locationUpdate()
            break
            
        // 不明
        @unknown default:
            self.isLocationUpdate = false
            throw LocationAuthorizationError.unknown
        }
    }
    
    @MainActor
    private func locationUpdate() async throws {
        let updates = CLLocationUpdate.liveUpdates()
        
        for try await update in updates {
            
            if !isLocationUpdate {
                break
            }
            
            guard let location = update.location else {
                return
            }
            
            print(location)
            latitude = floorWithDigit(location.coordinate.latitude, digit: 6)
            longitude = floorWithDigit(location.coordinate.longitude, digit: 6)
            altitude = floorWithDigit(location.altitude, digit: 3)
            ellipsoidalAltitude = floorWithDigit(location.ellipsoidalAltitude, digit: 3)
            speed = location.speed < 0 ? 0.0 : floorWithDigit(location.speed, digit: 3)
            course = location.course
            
            locationSaveHandler?(location)
        }
    }
    
    private func floorWithDigit(_ value: Double, digit: Int) -> Double {
        let digitWeight: Double = pow(10.0, Double(digit))
        
        return floor(value * digitWeight) / digitWeight
    }
}
