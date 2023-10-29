import SwiftUI
import MapKit
import SwiftData

struct LoggingView: View {
    
    // MARK: State
    @StateObject var locationModel = LocationModel()
    
    @Environment(\.modelContext) private var context
    @Query private var locations: [LocationItem]
    
    // MARK: Properties
    private let tokyoStationCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 35.681111, longitude: 139.766667)
    
    var body: some View {
        ZStack {
            Map {
                Marker("TokyoStation", systemImage: "tram.circle.fill", coordinate: tokyoStationCoordinate)
            }
            .mapControls {
                MapCompass()
                MapUserLocationButton()
                MapScaleView()
            }
            .mapControlVisibility(.visible)
            
            VStack {
                Spacer()
                Button(
                    action: {
                        Task {
                            do {
                                if locationModel.isLocationUpdate {
                                    locationModel.isLocationUpdate.toggle()
                                } else {
                                    locationModel.isLocationUpdate.toggle()
                                    locationModel.locationSaveHandler = self.add(location:)
                                    try await locationModel.startLocation()
                                }
                            } catch {
                                print(error)
                                print("位置情報の取得ができませんでした")
                            }
                        }
                    },
                    label: {
                        Label(
                            title: {
                                Text( locationModel.isLocationUpdate ? "LocationStop" : "Location Start")
                                    .foregroundStyle(.white)
                            },
                            icon: {
                                Image(systemName: "record.circle")
                                    .foregroundStyle(.white)
                            }
                        )
                        .padding(8)
                        .background(.red)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .padding(.bottom, 8)
                    }
                )
            }
        }
    }
    
    // MARK: - function
    private func add(location: CLLocation) {
        let data = LocationItem(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude,
            altitude: location.altitude,
            ellipsoidalAltitude: location.ellipsoidalAltitude,
            horizontalAccuracy: location.horizontalAccuracy,
            verticalAccuracy: location.verticalAccuracy,
            speed: location.speed,
            speedAccuracy: location.speedAccuracy,
            course: location.course,
            courseAccuracy: location.courseAccuracy,
            timestamp: location.timestamp
        )
        
        context.insert(data)
    }
}

#Preview {
    LoggingView()
}
