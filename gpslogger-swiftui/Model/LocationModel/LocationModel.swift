import Foundation
import CoreLocation

enum LocationAuthorizationError: Error {
    case notDetermined
    case denied
    case unknown
}

class LocationModel: ObservableObject {
    
    // MARK: - State
    @Published var isLocationUpdate: Bool = false
    
    // MARK: - Properties
    private var locationManager = CLLocationManager()
    
    // MARK: - Initialize
    init() {
        // LocationManagerの設定
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
        }
    }
}
